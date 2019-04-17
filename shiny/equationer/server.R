shinyServer(function(input, output, session) {


# covariates ------------------------------------------------------


    activate_numeric_if_checked("adjusted_weight", input, output, session)
    activate_numeric_if_checked("age", input, output, session)
    activate_numeric_if_checked("air_humidity", input, output, session)
    activate_numeric_if_checked("air_temperature", input, output, session)
    activate_numeric_if_checked("albumin_mg_dl", input, output, session)
    activate_numeric_if_checked("bmi", input, output, session)
    activate_numeric_if_checked("glucose_g_dl", input, output, session)
    activate_numeric_if_checked("height", input, output, session)
    activate_numeric_if_checked("lbm", input, output, session)
    activate_numeric_if_checked("lta", input, output, session)
    activate_numeric_if_checked("mean_chest_skinfold", input, output, session)
    activate_numeric_if_checked("subscapular_skinfold", input, output, session)
    activate_numeric_if_checked("surface_area", input, output, session)
    activate_numeric_if_checked("weight", input, output, session)
    activate_numeric_if_checked("wrist_circumference", input, output, session)

    activate_selector_if_checked("menopausal", input, output, session)

# strata ----------------------------------------------------------

    activate_selector_if_checked("bmi_class", input, output, session)
    activate_selector_if_checked("bmi_greater_21", input, output, session)
    activate_selector_if_checked("diabetic", input, output, session)
    activate_selector_if_checked("ethnicity", input, output, session)
    activate_selector_if_checked("hf", input, output, session)
    activate_selector_if_checked("sex", input, output, session)


# Evaluate --------------------------------------------------------

    observeEvent(input[["eval"]], {
        cov <- list(
            input[["adjusted_weight"]],
            input[["age"]],
            input[["air_humidity"]],
            input[["air_temperature"]],
            input[["albumin_mg_dl"]],
            input[["bmi"]],
            input[["glucose_g_dl"]],
            input[["height"]],
            1L,
            input[["lbm"]],
            input[["lta"]],
            input[["mean_chest_skinfold"]],
            input[["menopausal"]],
            input[["subscapular_skinfold"]],
            input[["surface_area"]],
            input[["weight"]],
            input[["wrist_circumference"]]
        ) %>%
            setNames(sort(get_covariates(reer))) %>%
            .[c(
                input[["adjusted_weight_tick"]],
                input[["age_tick"]],
                input[["air_humidity_tick"]],
                input[["air_temperature_tick"]],
                input[["albumin_mg_dl_tick"]],
                input[["bmi_tick"]],
                input[["glucose_g_dl_tick"]],
                input[["height_tick"]],
                TRUE,
                input[["lbm_tick"]],
                input[["lta_tick"]],
                input[["mean_chest_skinfold_tick"]],
                input[["menopausal_tick"]],
                input[["subscapular_skinfold_tick"]],
                input[["surface_area_tick"]],
                input[["weight_tick"]]
            )]

cat("\nCOV\n")
cat(str(cov))

        strata <- list(
            input[["bmi_class"]],
            input[["bmi_greater_21"]],
            input[["diabetic"]],
            input[["ethnicity"]],
            input[["hf"]],
            input[["sex"]]
        ) %>%
            setNames(c(
                "bmi_class", "bmi_greater_21", "diabetic", "ethnicity",
                "hf", "sex"
            )) %>%
            .[c(
                input[["bmi_class_tick"]],
                input[["bmi_greater_21_tick"]],
                input[["diabetic_tick"]],
                input[["ethnicity_tick"]],
                input[["hf_tick"]],
                input[["sex_tick"]]
            )]

cat("\nSTRATA\n")
cat(str(strata))



        dots <- as.data.frame(c(cov, strata)) %>%
            dplyr::mutate_if(is.factor, as.character) %>%
            dplyr::mutate_if(is.character, ~ifelse(. %in% c("TRUE", "FALSE"), as.logical(.), .))

cat("\ndots\n")
cat(str(dots))

        outcomes <- c("bee", "bmr", "eee", "ree", "rmr")[c(
            input[["bee_tick"]], input[["bmr_tick"]],
            input[["eee_tick"]], input[["ree_tick"]],
            input[["rmr_tick"]]
        )]


cat("\noutcomes\n")
cat(str(outcomes))

        res <- evaluate_at(reer, dots, .outcome = outcomes) %>%
            dplyr::mutate(estimation = round(estimation, 2))

        output[["res_tab"]] <- renderDT(res,
            options = list(filter = "top")
        )


    })

})
