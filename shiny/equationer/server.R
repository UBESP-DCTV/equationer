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
    activate_numeric_if_checked("lta", input, output, session)
    activate_numeric_if_checked("mean_chest_skinfold", input, output, session)
    activate_numeric_if_checked("subscapular_skinfold", input, output, session)
    activate_numeric_if_checked("surface_area", input, output, session)
    activate_numeric_if_checked("weight", input, output, session)
    activate_numeric_if_checked("wrist_circumference", input, output, session)
    activate_numeric_if_checked("crp_mg_l", input, output, session)

    activate_selector_if_checked("menopausal", input, output, session)

# strata ----------------------------------------------------------

    activate_selector_if_checked("sex", input, output, session)
    activate_selector_if_checked("pal", input, output, session)
    activate_selector_if_checked("ethnicity", input, output, session)

    activate_bool_if_checked("diabetic", input, output, session)
    activate_bool_if_checked("inpatients", input, output, session)
    activate_bool_if_checked("rheumatoid_arthritis", input, output, session)
    activate_bool_if_checked("hf", input, output, session)
    activate_bool_if_checked("copd", input, output, session)


# Evaluate --------------------------------------------------------


    # output[["test_text"]] <- renderText(glue::glue("age_tick: {input[['age_tick']]}"))


    observeEvent(input[["eval"]], {


        # Auxiliary variables ==========================================


        ## Age
        #
        age_18_74 <- older_18 <- older_29 <- older_59 <-
            older_60 <- age_60_70 <- older_70 <- age_60_74 <-
            older_74 <- "FALSE"

        age_18_74_tick <- older_18_tick <- older_29_tick <-
            older_59_tick <- older_60_tick <- age_60_70_tick <-
            older_70_tick <- age_60_74_tick <- older_74_tick <- FALSE

        if (input[["age_tick"]]) {
            age <- input[["age"]]

            age_18_74_tick <- older_18_tick <- older_29_tick <-
                older_59_tick <- older_60_tick <- age_60_70_tick <-
                older_70_tick <- age_60_74_tick <- older_74_tick <- TRUE


            if (age >= 18) {age_18_74 <- "TRUE"}
            if (age > 18) {older_18 <- "TRUE"}
            if (age > 29) {older_29 <- "TRUE"}
            if (age > 59) {older_59 <- age_60_70 <- age_60_74 <- "TRUE"}
            if (age > 60) {older_60 <- "TRUE"}
            if (age > 70) {
                older_70 <- "TRUE"
                age_60_70 <- "FALSE"
            }
            if (age > 74) {
                older_74 <- "TRUE"
                age_60_74 <- age_18_74 <- "FALSE"
            }

        }


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
                input[["weight"]] < 18.5 ~ "underweight",
                input[["weight"]] < 25   ~ "normal weight",
                input[["weight"]] < 25   ~ "overweight",
                TRUE                     ~ "overweight"
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


        reer_covs_no_intercept <- get_covariates(reer) %>%
            .[!stringr::str_detect(., "intercept")] %>%
            sort()


        cov <- list(
            adj_weight,
            input[["age"]],
            input[["air_humidity"]],
            input[["air_temperature"]],
            input[["albumin_mg_dl"]],
            bmi,
            bmi_pavlidou,
            bmi_pavlidou_f,
            bmi_pavlidou_m,
            input[["glucose_g_dl"]],
            input[["height"]],
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
            input[["subscapular_skinfold"]],
            input[["surface_area"]],
            var_metsios,
            input[["weight"]],
            input[["wrist_circumference"]]
        ) %>%
            setNames(reer_covs_no_intercept) %>%
            .[c(
                adj_weight_tick,
                input[["age_tick"]],
                input[["air_humidity_tick"]],
                input[["air_temperature_tick"]],
                input[["albumin_mg_dl_tick"]],
                bmi_tick,
                bmi_pavlidou_tick,
                bmi_pavlidou_tick,
                bmi_pavlidou_tick,
                input[["glucose_g_dl_tick"]],
                input[["height_tick"]],
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
                input[["subscapular_skinfold_tick"]],
                input[["surface_area_tick"]],
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
            age_18_74,
            age_60_70,
            age_60_74,
            bmi_class,
            bmi_greater_21,
            input[["copd"]],
            input[["diabetic"]],
            input[["ethnicity"]],
            input[["hf"]],
            input[["inpatients"]],
            older_18,
            older_29,
            older_59,
            older_60,
            older_70,
            older_74,
            input[["pal"]],
            input[["rheumatoid_arthritis"]],
            input[["sex"]]
        ) %>%
            setNames(c(
                'age_18_74', 'age_60_70', 'age_60_74', 'bmi_class',
                'bmi_greater_21', 'copd', 'diabetic', 'ethnicity', 'hf',
                'inpatients', 'older_18', 'older_29', 'older_59',
                'older_60', 'older_70', 'older_74', 'pal',
                'rheumatoid_arthritis', 'sex'
            )) %>%
            .[c(
                age_18_74_tick,
                age_60_70_tick,
                age_60_74_tick,
                bmi_class_tick,
                bmi_greater_21_tick,
                input[["copd_tick"]],
                input[["diabetic_tick"]],
                input[["ethnicity_tick"]],
                input[["hf_tick"]],
                input[["inpatients_tick"]],
                older_18_tick,
                older_29_tick,
                older_59_tick,
                older_60_tick,
                older_70_tick,
                older_74_tick,
                input[["pal_tick"]],
                input[["rheumatoid_arthritis_tick"]],
                input[["sex_tick"]]
            )]

cat("\nSTRATA\n")
cat(str(strata))



        dots <- as.data.frame(c(cov, strata)) %>%
            dplyr::mutate_if(is.factor, as.character)

cat("\ndots\n")
cat(str(dots))

        outcomes <- c("bee", "bmr", "eee", "ree", "rmr")[c(
            input[["bee_tick"]], input[["bmr_tick"]],
            input[["eee_tick"]], input[["ree_tick"]],
            input[["rmr_tick"]]
        )]


cat("\noutcomes\n")
cat(str(outcomes))

        if (!length(cov)) {
          showNotification("Please, supply information about more covariates.", duration = 30, type = "error")
            dots <- data.frame(foo = 0, stringsAsFactors = FALSE)
        }

cat("\ndots\n")
cat(str(dots))


        res <- evaluate_at(reer, dots, .outcome = outcomes) %>%
            dplyr::mutate(estimation = round(estimation, 2)) %>%
            dplyr::select(outcome, estimation, dplyr::everything()) %>%
            dplyr::mutate_if(is.character, ~tidyr::replace_na(., "not-considered") %>% as.factor()) %>%
            dplyr::rename(gender = sex)

cat(str(res))

        output[["res_tab"]] <- renderDT(res,
            rownames = FALSE,
            filter = "top",
            selection = list(
                mode = "single",
                selected = 1L,
                target = "column"
            )
        )


        resplot <- res %>%
            ggplot(aes(x = gender, y = estimation, colour = gender)) +
            geom_boxplot(varwidth = TRUE) +
            theme(axis.text.x = element_blank()) +
            ggtitle(
                "Distribution of the Estimated Energy Requirements by Gender",
                subtitle = "'not-considered' are the estimations from the equations which do not consider the gender."
            )

        output[["res_plot"]] <- renderPlot(resplot)


    })

})
