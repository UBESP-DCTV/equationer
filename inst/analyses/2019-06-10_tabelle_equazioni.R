library(tidyverse)
library(equationer)
library(irr)
library(Hmisc)
library(depigner)
library(pander)
panderOptions("round", 2)
panderOptions("table.split.table", Inf)
panderOptions("table.alignment.default",
              function(df) {
                  n <- length(df) - 1L
                  c("left", rep("center", n))
              }
)

# weigth, eigth, age, sex, bmi
data("data_20190412")

sample_data <- dplyr::as_tibble(data_20190412) %>%
    dplyr::transmute(
        record_id = record_id,
        age = eta,
        height = height,
        weight = intpeso,
        sex = sesso.factor,
        ethnicity = razza.factor,
        mean_chest_skinfold = mean_chest_skinfold,
        subscapular_skinfold = mean_subscapular_skinfold,
        wrist_circumference = wrist_circumference,
        menopausal = menopausa,
        atheletes = atheletes
    ) %>%
    filter(!is.na(age)) %>%
    janitor::remove_empty()



sample_estimations <- sample_data %>%
    add_age_classes() %>%
    add_bmi_class() %>%
    add_adj_weight() %>%
    add_lbm() %>%
    add_livingston_weight() %>%
    mutate_if(is.logical, as.character) %>%
    mutate_if(is.factor, as.character) %>%
    nest(-record_id) %>%
    mutate(
        estimations = map(data, evaluate_at, x = reer)
    )

sample_unnested <- sample_estimations %>%
    mutate(
        data = map(data,
            ~select(., bmi_class, age, sex)
        ),
        estimations = map(estimations,
            ~select(., estimation, outcome, eq_group)
        )
    ) %>%
    unnest(data) %>%
    unnest(estimations) %>%
    filter(!is.na(estimation))

to_tablerize <- sample_unnested %>%
    mutate(
        age_class = case_when(
            age < 65 ~ "age < 65",
            age < 75 ~ "65<= age < 75",
            age < 85 ~ "75<= age < 85",
            TRUE ~ "85 <= age"
        ) %>% ordered(levels = c("age < 65", "65<= age < 75", "75<= age < 85", "85 <= age"))
    ) %>%
    select(-age) %>%
    mutate_if(is.character, as_factor) %>%
    mutate_if(is.factor, ~fct_explicit_na(., na_level = "generic")) %>%
    mutate(
        bmi_class = ordered(bmi_class, levels = rev(levels(bmi_class)))
    ) %>%
    filter(estimation < 1e5)

estimated_equations <- to_tablerize

summary_estimation <- estimated_equations %>%
    group_by(bmi_class, sex, age_class) %>%
    summarise(
        n      = n(),
        lq     = quantile(estimation, p = 0.25, na.rm = TRUE),
        median = median(estimation, na.rm = TRUE),
        mean   = mean(estimation, na.rm = TRUE),
        hq     = quantile(estimation, p = 0.75, na.rm = TRUE),
        sd     = sd(estimation, na.rm = TRUE)
    )



estimated_equations %>%
    ggplot(aes(x = age_class, y = estimation, color = sex)) +
    geom_boxplot() +
    facet_grid(.~ bmi_class, scales = "free")
ggsave("bp_by-sex_bmi_age.png", width = 11.7, height = 8.3)

save(summary_estimation, estimated_equations, file = "equations_tables.rda")
