# Setup -----------------------------------------------------------
options(shiny.reactlog = TRUE)

library(shiny)
library(reactlog)
library(plotly)

library(tidyverse)
library(forcats)
# library(ggExtra)
library(DT)
library(shinyjs)
library(shinyBS)
library(equationer)
  data("reer")

reer_covs_no_intercept <- get_covariates(reer) %>%
  .[!stringr::str_detect(., "intercept")] %>%
  sort()



# UI --------------------------------------------------------------

ui <- fluidPage(
  # Use shiny js to disable fields
  useShinyjs(),
  title_text(),
  instructions_text(),


  sidebarLayout(

    sidebarPanel(
      tabsetPanel(
        anthropometric_tab(), measurements_tab(), conditions_tab(),
        lab_tests_tab(), physical_activity_tab(), environment_tab(),
        vital_parameters_tab(), outcomes_tab()
      ),
      actionButton("eval", "Evaluate equations", icon = icon("refresh"))
    ),

    mainPanel(
      tabsetPanel(
        tabPanel("Plots",
          icon = icon("chart-bar"),
          verticalLayout(
            shiny::plotOutput("res_plot"),
            fluidRow(
              column(2, numericInput("bxWidth", "Width (cm)", value = 11, min = 1, max = 22)),
              column(2, numericInput("bxHeight", "Height (cm)", value = 7, min = 1, max = 14)),
              column(2, selectInput("bxFormat", "Format", choices = c("png", "tiff", "pdf", "jpeg", "svg", "bmp"), selected = "png")),
              column(6, downloadButton('downloadBoxPlot','Download Boxplot'))
            ),
            hr(),
            shiny::plotOutput("bar_plot"),
            fluidRow(
              column(2, numericInput("brWidth", "Width (cm)", value = 11, min = 1, max = 22)),
              column(2, numericInput("brHeight", "Height (cm)", value = 7, min = 1, max = 14)),
              column(2, selectInput("brFormat", "Format", choices = c("png", "tiff", "pdf", "jpeg", "svg", "bmp"), selected = "png")),
              column(6, downloadButton('downloadBarPlot','Download Barplot'))
            )
          )
        ),
        tabPanel("Table",
          icon = icon("grip-horizontal"),
          dataTableOutput("res_tab")
        )
      )
    )
  )
)




# Server ----------------------------------------------------------

server <- function(input, output, session) {

  usethis::ui_done("Start server")
  usethis::ui_info(Sys.getpid())
  # covariates ------------------------------------------------------

  activate_numeric_if_checked("abdomen_circ", input, output, session)
  activate_numeric_if_checked("adjusted_weight", input, output, session)
  activate_numeric_if_checked("age", input, output, session)
  activate_numeric_if_checked("air_humidity", input, output, session)
  activate_numeric_if_checked("air_temperature", input, output, session)
  activate_numeric_if_checked("albumin_mg_dl", input, output, session)
  activate_numeric_if_checked("arm_span", input, output, session)
  activate_numeric_if_checked("blood_pressure_gradient", input, output, session)
  activate_numeric_if_checked("bmi", input, output, session)
  activate_numeric_if_checked("body_surface_area", input, output, session)
  activate_numeric_if_checked("body_temperature", input, output, session)
  activate_numeric_if_checked("fasting_plasma_glucose", input, output, session)
  activate_numeric_if_checked("glucose_g_dl", input, output, session)
  activate_numeric_if_checked("height", input, output, session)
  activate_numeric_if_checked("hip_circumference", input, output, session)
  activate_numeric_if_checked("hour", input, output, session)
  activate_numeric_if_checked("lta", input, output, session)
  activate_numeric_if_checked("mean_chest_skinfold", input, output, session)
  activate_numeric_if_checked("midarm_circumference", input, output, session)
  activate_numeric_if_checked("pulse", input, output, session)
  activate_numeric_if_checked("subscapular_skinfold", input, output, session)
  activate_numeric_if_checked("weight", input, output, session)
  activate_numeric_if_checked("wrist_circumference", input, output, session)
  activate_numeric_if_checked("crp_mg_l", input, output, session)

  activate_selector_if_checked("menopausal", input, output, session)

  usethis::ui_done("Covariates")

  # strata ----------------------------------------------------------

  activate_selector_if_checked("activity_intensity", input, output, session)
  activate_selector_if_checked("ethnicity", input, output, session)
  activate_selector_if_checked("pal", input, output, session)
  activate_selector_if_checked("sex", input, output, session)
  activate_selector_if_checked("race", input, output, session)
  activate_selector_if_checked("meal", input, output, session)

  activate_bool_if_checked("athletic", input, output, session)
  activate_bool_if_checked("diabetic", input, output, session)
  activate_bool_if_checked("inpatients", input, output, session)
  activate_bool_if_checked("rheumatoid_arthritis", input, output, session)
  activate_bool_if_checked("hf", input, output, session)
  activate_bool_if_checked("copd", input, output, session)
  activate_bool_if_checked("smoke", input, output, session)

  usethis::ui_done("Strata")
  # Evaluate --------------------------------------------------------

  # output[["test_text"]] <- renderText(glue::glue("age_tick: {input[['age_tick']]}"))

  observeEvent(input[["eval"]], {
    usethis::ui_info("Start observe")

    # Auxiliary variables ==========================================


    ## Age
    #
    init_age_val()
    init_age_tick(value = FALSE)

    if (input[["age_tick"]]) {
      init_age_tick(value = TRUE)
      update_ages(input[["age"]])
    }
    usethis::ui_done("Age setup")


    ## BMI and BMI_pavlidou
    #

    bmi <- 0
    bmi_greater_21 <- "TRUE"
    bmi_class <- "not-considered"
    bmi_pavlidou <- 0
    bmi_pavlidou_m <- 0
    bmi_pavlidou_f <- 0

    bmi_tick <- FALSE
    bmi_greater_21_tick <- FALSE
    bmi_class_tick <- FALSE
    bmi_pavlidou_tick <- FALSE

    if (
      input[["weight_tick"]] && input[["height_tick"]]
    ) {
      bmi <- input[["weight"]] / (input[["height"]]/100)^2

      showNotification(
        glue::glue("Body Mass Index (BMI) calculated to be: {round(bmi, 1)}"),
        duration = 30, type = "message"
      )


      bmi_greater_21 <- as.character(bmi > 21)



      bmi_class <- dplyr::case_when(
        bmi < 18.5 ~ "underweight",
        bmi < 25   ~ "normal weight",
        bmi < 30   ~ "overweight",
        TRUE       ~ "obese"
      )

      showNotification(
        glue::glue("BMI class considered: {bmi_class}"),
        duration = 30, type = "message"
      )



      bmi_pavlidou <- input[["weight"]] * bmi^(-0.152)
      bmi_pavlidou_m <- input[["weight"]] * bmi^(-0.1786)
      bmi_pavlidou_f <- input[["weight"]] * bmi^(-0.2115)

      bmi_tick <- TRUE
      bmi_greater_21_tick <- TRUE
      bmi_class_tick <- TRUE
      bmi_pavlidou_tick <- TRUE

    }
    usethis::ui_done("BMI setup")


    ## IBW
    #
    ibw <- 0
    ibw_tick <- FALSE
    adj_weight <- 0
    adj_weight_tick <- FALSE

    if (
      input[["weight_tick"]] &&
      input[["height_tick"]] &&
      input[["sex_tick"]]
    ) {
      height_feet <- input[["height"]] * 0.0328084

      if (input[["sex"]] == "male") {
        ibw <- 52 + 1.9 * ((height_feet - 5)*12)
      }
      if (input[["sex"]] == "female") {
        ibw <- 49 + 1.7 * ((height_feet - 5)*12)
      }
      showNotification(
        glue::glue("Ideal Body Weigth (IBW, Robinson et.al 1983) calculated to be: {round(ibw, 1)}"),
        duration = 30, type = "message"
      )

      adj_weight <- 0.25*(input[["weight"]] - ibw) + ibw

      ibw_tick <- TRUE
      adj_weight_tick <- TRUE
    }
    usethis::ui_done("IBW setup")


    ## LBM
    #

    lbm <- 0
    lbm_tick <- FALSE

    if (
      input[["weight_tick"]] &&
      input[["age_tick"]] &&
      input[["sex_tick"]]
    ) {
      lbm <- if (input[["sex"]] == "male") {
        (79.5 - 0.24*input[['weight']] - 0.15*input[['age']])*input[['weight']]/73.2
      } else {
        (69.8 - 0.26*input[['weight']] - 0.12*input[['age']])*input[['weight']]/73.2
      }
      showNotification(
        glue::glue("Lean Body Mass (LBM) calculated to be: {round(lbm, 1)}"),
        duration = 30, type = "message"
      )

      lbm_tick <- TRUE
    }
    usethis::ui_done("LBW setup")



    ## Livinston weight exp
    #
    livingston_weight_f <- 0
    livingston_weight_m <- 0
    livingston_weight_f_alone <- 0
    livingston_weight_m_alone <- 0
    livingston_weight_alone <- 0
    livingston_weight_age <- 0

    livingston_weight_tick <- FALSE

    if (input[["weight_tick"]]) {
      livingston_weight_f <- input[["weight"]]^0.4330
      livingston_weight_m <- input[["weight"]]^0.4356
      livingston_weight_f_alone <- input[["weight"]]^0.4613
      livingston_weight_m_alone <- input[["weight"]]^0.4473
      livingston_weight_alone <- input[["weight"]]^0.4722
      livingston_weight_age <- input[["weight"]]^0.4456

      livingston_weight_tick <- TRUE
    }
    usethis::ui_done("Livinston weight setup")



    ## Metsios var
    #
    var_metsios <- 0
    var_metsios_tick <- FALSE

    if (
      input[["weight_tick"]] &&
      input[["age_tick"]] &&
      input[["crp_mg_l_tick"]]
    ) {
      var_metsios <- input[["weight"]]^0.57 * input[["age"]]^(-0.29) * input[["crp_mg_l"]]^0.066
      var_metsios_tick <- TRUE
    }
    usethis::ui_done("Metsios setup")


    ## BSA Body surface area
    #
    body_surface_area <- 0
    body_surface_area_tick <- FALSE

    if (
      input[["weight_tick"]] &&
      input[["height_tick"]]
    ) {
      body_surface_area <- 0.007184 * input[["weight"]]^0.425 * input[["height"]]^0.725
      body_surface_area_tick <- TRUE
      showNotification(
        glue::glue("Body Surface Area (BSA, Dubois et.al 1916) calculated to be: {round(body_surface_area, 1)}"),
        duration = 30, type = "message"
      )
    }
    usethis::ui_done("Body_surface_area setup")







    # Input check ==================================================

    menopausal_check <- TRUE
    if (
      input[["menopausal_tick"]] &&
      input[["sex_tick"]] && (input[["sex"]] == "male")
    ) {
      showNotification(
        glue::glue("You have select a menopausal status for a male. Menopausal status has been unselected."),
        duration = 30, type = "error"
      )
      updateCheckboxInput(session, "menopausal_tick", value = FALSE)
      disable("menopausal")
      updateSelectInput(session, "menopausal", choices = "not-selected", selected = "not-selected")
      menopausal_check <- FALSE
    }

    if (
      input[["glucose_g_dl_tick"]] && (input[["glucose_g_dl"]] > 126) &&
      input[["diabetic_tick"]] && (input[["diabetic"]] == "FALSE")
    ) {
      showNotification(
        glue::glue("Glucose above 126 g/dl should be diabetic. Glucose provided is {input[['glucose_g_dl']]} and diabetic is marked FALSE"),
        duration = 30, type = "error"
      )
    }


   cov <- list(
        input[["abdomen_circ"]],
        adj_weight,
        input[["age"]],
        input[["air_humidity"]],
        input[["air_temperature"]],
        input[["albumin_mg_dl"]],
        input[["arm_span"]],
        input[["blood_pressure_gradient"]],
        bmi,
        bmi_pavlidou,
        bmi_pavlidou_f,
        bmi_pavlidou_m,
        input[["body_surface_area"]],
        input[["body_temperature"]],
        input[["fasting_plasma_glucose"]],
        input[["glucose_g_dl"]],
        input[["height"]],
        input[["hip_circumference"]],
        input[["hour"]],
        lbm,
        livingston_weight_age,
        livingston_weight_alone,
        livingston_weight_f,
        livingston_weight_f_alone,
        livingston_weight_m,
        livingston_weight_m_alone,
        input[["lta"]],
        input[["mean_chest_skinfold"]],
        input[["menopausal"]],
        input[["midarm_circumference"]],
        input[["pulse"]],
        input[["subscapular_skinfold"]],
        var_metsios,
        input[["weight"]],
        input[["wrist_circumference"]]
      ) %>%
      setNames(reer_covs_no_intercept) %>%
      .[c(
        input[["abdomen_circ_tick"]],
        adj_weight_tick,
        input[["age_tick"]],
        input[["air_humidity_tick"]],
        input[["air_temperature_tick"]],
        input[["albumin_mg_dl_tick"]],
        input[["arm_span_tick"]],
        input[["blood_pressure_gradient_tick"]],
        bmi_tick,
        bmi_pavlidou_tick,
        bmi_pavlidou_tick,
        bmi_pavlidou_tick,
        input[["body_surface_area_tick"]],
        input[["body_temperature_tick"]],
        input[["fasting_plasma_glucose_tick"]],
        input[["glucose_g_dl_tick"]],
        input[["height_tick"]],
        input[["hip_circumference_tick"]],
        input[["hour_tick"]],
        lbm_tick,
        livingston_weight_tick,
        livingston_weight_tick,
        livingston_weight_tick,
        livingston_weight_tick,
        livingston_weight_tick,
        livingston_weight_tick,
        input[["lta_tick"]],
        input[["mean_chest_skinfold_tick"]],
        (input[["menopausal_tick"]] && menopausal_check),
        input[["midarm_circumference_tick"]],
        input[["pulse_tick"]],
        input[["subscapular_skinfold_tick"]],
        var_metsios_tick,
        input[["weight_tick"]],
        input[["wrist_circumference_tick"]]
      )]

      if (input[["menopausal_tick"]] && menopausal_check) {
        cov[["menopausal"]] <- dplyr::case_when(
          cov[["menopausal"]] == "pre-menopausal" ~ 1,
          cov[["menopausal"]] == "perimenopausal" ~ 2,
          cov[["menopausal"]] == "post-menopausal" ~ 3,
          TRUE ~ 0
        )
      }


    cat("\nCOV\n")
    cat(str(cov))

    strata <- list(
        input[["activity_intensity"]],
        age_18_65,
        age_18_74,
        age_50_69,
        age_60_70,
        age_60_74,
        input[["athletic"]],
        bmi_class,
        bmi_greater_21,
        input[["copd"]],
        input[["diabetic"]],
        input[["ethnicity"]],
        input[["hf"]],
        input[["inpatients"]],
        input[["meal"]],
        # older_18,
        older_29,
        # older_59,
        older_60,
        older_70,
        older_74,
        input[["pal"]],
        input[["race"]],
        input[["rheumatoid_arthritis"]],
        input[["sex"]],
        input[["smoke"]]
      ) %>%
      setNames(c(
        'activity_intensity', 'age_18_65', 'age_18_74',
        'age_50_69', 'age_60_70', 'age_60_74', 'athletic',
        'bmi_class', 'bmi_greater_21', 'copd', 'diabetic',
        'ethnicity', 'hf', 'inpatients', 'meal',
        # 'older_18',
        'older_29',
        # 'older_59',
        'older_60', 'older_70',
        'older_74', 'pal', 'race', 'rheumatoid_arthritis',
        'sex', 'smoke'
      )) %>%
      .[c(
        input[["activity_intensity_tick"]],
        age_18_65_tick,
        age_18_74_tick,
        age_50_69_tick,
        age_60_70_tick,
        age_60_74_tick,
        input[["athletic_tick"]],
        bmi_class_tick,
        bmi_greater_21_tick,
        input[["copd_tick"]],
        input[["diabetic_tick"]],
        input[["ethnicity_tick"]],
        input[["hf_tick"]],
        input[["inpatients_tick"]],
        input[["meal_tick"]],
        # older_18_tick,
        older_29_tick,
        # older_59_tick,
        older_60_tick,
        older_70_tick,
        older_74_tick,
        input[["pal_tick"]],
        input[["race_tick"]],
        input[["rheumatoid_arthritis_tick"]],
        input[["sex_tick"]],
        input[["smoke_tick"]]
      )]

    cat("\nSTRATA\n")
    cat(str(strata))


    outcomes <- c("bee", "bmr", "ree", "rmr", "eee", "eer")[c(
        input[["beebmr_tick"]], input[["beebmr_tick"]],
        input[["reermr_tick"]], input[["reermr_tick"]],
        input[["eeeeer_tick"]], input[["eeeeer_tick"]]
      )]


    cat("\noutcomes\n")
    cat(str(outcomes))

    dots <- if (length(cov)) {
        as.data.frame(c(cov, strata)) %>%
          dplyr::mutate_if(is.factor, as.character)
      } else {
        showNotification("Please, supply information about more covariates.", duration = 30, type = "error")
        data.frame(foo = 0, stringsAsFactors = FALSE)
      }


    cat("\ndots\n")
    cat(str(dots))

    res <- evaluate_at(reer, dots, .outcome = outcomes) %>%
        dplyr::mutate(
          estimation = round(.data[["estimation"]], 2),
          outcome =  .data[["outcome"]] %>%
            forcats::fct_collapse(
              "bee/bmr" = c("bee", "bmr"),
              "ree/rmr" = c("ree", "rmr"),
              "eee/eer" = c("eee", "eer")
            )
        ) %>%
        dplyr::select("outcome", "estimation", dplyr::everything()) %>%
        dplyr::mutate_if(is.character,
                         ~ tidyr::replace_na(., "not-considered") %>% as.factor()
        ) %>%
        dplyr::rename(gender = sex)

    output[["res_tab"]] <- renderDT(res,
                                    rownames = FALSE,
                                    filter = "top",
                                    selection = list(mode = "single", selected = 1L, target = "column")
    )


    resplot <- res %>%
        ggplot(aes(x = gender, y = estimation, colour = gender)) +
        geom_violin(aes(fill = gender),
                    alpha = 0.2,
                    # draw_quantiles = c(0.01, 0.1, 0.25, 0.5, 0.75, 0.9, 0.99),
                    trim = FALSE,
                    scale = "count"
        ) +
        geom_boxplot(varwidth = TRUE, alpha = 0.7) +
        stat_summary(fun.data = fun_min, geom = "text",
                     vjust = 2, hjust = -0.5
        ) +
        stat_summary(fun.data = fun_median, geom = "text",
                     vjust = -3, hjust = -0.5) +
        stat_summary(fun.data = fun_max, geom = "text",
                     vjust = -2, hjust = -0.5
        ) +
        theme(axis.text.x = element_blank()) +
        ggtitle(
          "Distributions for all the equations calculated according to the value provided.",
          subtitle = 'Label "Not considered" refers to the distributions of the equations that do not distinguish between male and female. For each distribution are provided, minum, median and maximum value.'
        ) +
        ylab("Estimation (Kcal/day)")

    bplot <- res %>%
        ggplot(aes(x = reorder(eq_group, -estimation), y = estimation, color = gender, fill = gender)) +
        geom_bar(stat = "identity", position = "dodge") +
        facet_grid(vars(gender)) +
        theme(
          axis.text.x = element_text(angle = 30, hjust = 0.95, vjust = 1)
        ) +
        ggtitle(
          "Barplot of the estimated energy outcomes",
          subtitle = "Distinct bars correspond to distinct equations."
        ) +
        xlab("Equation groups [Author_year_additional-spec]") +
        ylab("Estimation (Kcal/day)")


    observeEvent({
      input$eval
      input$bxWidth
      input$bxHeight
      input$bxFormat
    }, {

      output$downloadBoxPlot <- downloadHandler(
        filename = paste0(Sys.Date(), "-eq_boxplot", ".", input$bxFormat),
        content = function(file){
          ggsave(file, device = input$bxFormat, plot = resplot,
            width = input$bxWidth,
            height = input$bxHeight,
            scale = 2^(22/input$bxWidth),
            units = "cm"
          )
        }
      )
    })

    observeEvent({
      input$eval
      input$brWidth
      input$brHeight
      input$brFormat
    }, {

      output$downloadBarPlot <- downloadHandler(
        filename = paste0(Sys.Date(), "-eq_barplot", ".", input$brFormat),
        content = function(file){
          ggsave(file, device = input$brFormat, plot = bplot,
                 width = input$brWidth,
                 height = input$brHeight,
                 scale = 2^(22/input$brWidth),
                 units = "cm"
          )
        }
      )
    })



    output[["res_plot"]] <- renderPlot(resplot)
    output[["bar_plot"]] <- renderPlot(bplot)
  })

}

shinyApp(ui, server)
