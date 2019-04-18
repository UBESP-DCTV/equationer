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
    # activate_numeric_if_checked("lbm", input, output, session)
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

        updateSelectInput(session, "lbm_tick", choices = c(TRUE, FALSE), selected = FALSE)
        updateNumericInput(session, "lbm", value = 0)

        if (
            input[["weight_tick"]] &&
            input[["age_tick"]] &&
            input[["sex_tick"]]
        ) {
            lbm_tick <- TRUE
            lbm <- if (input[["sex"]] == "male") {
                (79.5 - 0.24*input[['weight']] - 0.15*input[['age']])*input[['weight']] + 73.2
            } else {
                (69.8 - 0.26*input[['weight']] - 0.12*input[['age']])*input[['weight']] + 73.2
            }
            showNotification(
                glue::glue("Lean Body Mass (LBM) calculated to be: {lbm}"),
                duration = 30, type = "message"
            )
        } else {
            lbm_tick <- FALSE
            lbm <- 0
        }


        reer_covs_no_intercept <- get_covariates(reer) %>%
            .[!stringr::str_detect(., "intercept")] %>%
            sort()

        cov <- list(
            input[["adjusted_weight"]],
            input[["age"]],
            input[["air_humidity"]],
            input[["air_temperature"]],
            input[["albumin_mg_dl"]],
            input[["bmi"]],
            input[["glucose_g_dl"]],
            input[["height"]],
            lbm,
            input[["lta"]],
            input[["mean_chest_skinfold"]],
            input[["menopausal"]],
            input[["subscapular_skinfold"]],
            input[["surface_area"]],
            input[["weight"]],
            input[["wrist_circumference"]]
        ) %>%
            setNames(reer_covs_no_intercept) %>%
            .[c(
                input[["adjusted_weight_tick"]],
                input[["age_tick"]],
                input[["air_humidity_tick"]],
                input[["air_temperature_tick"]],
                input[["albumin_mg_dl_tick"]],
                input[["bmi_tick"]],
                input[["glucose_g_dl_tick"]],
                input[["height_tick"]],
                lbm_tick,
                input[["lta_tick"]],
                input[["mean_chest_skinfold_tick"]],
                input[["menopausal_tick"]],
                input[["subscapular_skinfold_tick"]],
                input[["surface_area_tick"]],
                input[["weight_tick"]]
            )]

        if (input[["menopausal_tick"]]) {
            cov[["menopausal"]] <- as.integer(cov[["menopausal"]])
        }

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

        if (!ncol(dots)) {
          showNotification("Please, supply information about more covariates.", duration = 30, type = "error")
            dots <- data.frame(age = 0)
        }

        if (
            input[['bmi_tick']] &&
            input[['weight_tick']] &&
            input[['height_tick']] &&
            (input[['height']] > 0) &&
            (abs(input[['bmi']] - input[['height']]/(input[['weight']]/100)^2) >= 1)
        ) {
            showNotification(
                glue::glue("BMI supplied - BMI computed = {round(input[['bmi']] - input[['weight']]/(input[['height']]/100)^2)}"),
                duration = 30, type = "warning"
            )
        }


        if (
            input[['bmi_tick']] &&
            input[['bmi_greater_21_tick']] &&
            (
                ((input[['bmi']] >  21) && (input[['bmi_greater_21']] == "FALSE")) ||
                ((input[['bmi']] <= 21) && (input[['bmi_greater_21']] == "TRUE"))
            )
        ) {
            showNotification(
                glue::glue("BMI > 21 strata is {input[['bmi_greater_21']]} but BMI supplied is {input[['bmi']]}."),
                duration = 30, type = "warning"
            )
        }



        res <- evaluate_at(reer, dots, .outcome = outcomes) %>%
            dplyr::mutate(estimation = round(estimation, 2))


        res <- res %>%
            dplyr::select(outcome, estimation, dplyr::everything()) %>%
            dplyr::mutate_if(is.character, ~ tidyr::replace_na(., "NOTCONSIDERED") %>% factor()) %>%
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


    })

})
