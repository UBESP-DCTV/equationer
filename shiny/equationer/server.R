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
        reer_covs_no_intercept <- get_covariates(reer) %>%
            .[!stringr::str_detect(., "intercept")]

        cov <- list(
            input[["adjusted_weight"]],
            input[["age"]],
            input[["air_humidity"]],
            input[["air_temperature"]],
            input[["albumin_mg_dl"]],
            input[["bmi"]],
            input[["glucose_g_dl"]],
            input[["height"]],
            input[["lbm"]],
            input[["lta"]],
            input[["mean_chest_skinfold"]],
            input[["menopausal"]],
            input[["subscapular_skinfold"]],
            input[["surface_area"]],
            input[["weight"]],
            input[["wrist_circumference"]]
        ) %>%
            setNames(sort(reer_covs_no_intercept)) %>%
            .[c(
                input[["adjusted_weight_tick"]],
                input[["age_tick"]],
                input[["air_humidity_tick"]],
                input[["air_temperature_tick"]],
                input[["albumin_mg_dl_tick"]],
                input[["bmi_tick"]],
                input[["glucose_g_dl_tick"]],
                input[["height_tick"]],
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

        if (!ncol(dots)) {
          showNotification("Please, supply information about more covariates.", duration = 3, type = "error")
            dots <- data.frame(foo = "foo")
        }

        if (
            !is.na(input[['bmi']]) &&
            !is.na(input[['weight']]) &&
            !is.na(input[['height']]) &&
            (input[['height']] > 0) &&
            input[['bmi']] != input[['height']]/(input[['weight']]/100)^2
        ) {
            showNotification(
                glue::glue("BMI supplied - BMI computed = {round(input[['bmi']] - input[['weight']]/(input[['height']]/100)^2, 2)}"),
                duration = 3, type = "warning"
            )
        }


        if (
            !is.na(input[['bmi']]) &&
            !is.na(input[['bmi_greater_21']]) &&
            (
                ((input[['bmi']] >  21) && (input[['bmi_greater_21']] == "FALSE")) ||
                ((input[['bmi']] <= 21) && (input[['bmi_greater_21']] == "TRUE"))
            )
        ) {
            showNotification(
                glue::glue("BMI > 21 strata is {input[['bmi_greater_21']]} but BMI supplied is {input[['bmi']]}."),
                duration = 3, type = "warning"
            )
        }



        res <- evaluate_at(reer, dots, .outcome = outcomes) %>%
            dplyr::mutate(estimation = round(estimation, 2))


        res <- res %>%
            dplyr::select(outcome, estimation, dplyr::everything())

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
