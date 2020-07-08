add_age_classes <- function(x) {

    stopifnot("age" %in% names(x))

    age <- x[["age"]]

    res <- x %>%
        dplyr::mutate(
            age_18_74 = FALSE,
            older_18  = FALSE,
            older_29  = FALSE,
            older_59  = FALSE,
            older_60  = FALSE,
            age_60_70 = FALSE,
            older_70  = FALSE,
            age_60_74 = FALSE,
            older_74  = FALSE
        )

    res[res[["age"]] >= 18, "age_18_74"] <- TRUE
    res[res[["age"]] >  18, "older_18" ] <- TRUE
    res[res[["age"]] >  29, "older_29" ] <- TRUE
    res[res[["age"]] >  59, c("older_59", "age_60_70", "age_60_74")] <- TRUE
    res[res[["age"]] >  60, "older_60" ] <- TRUE
    res[res[["age"]] >  70, "older_70" ] <- TRUE
    res[res[["age"]] >  70, "age_60_70" ] <- FALSE
    res[res[["age"]] >  74, "older_74" ] <- TRUE
    res[res[["age"]] >  74, c("age_60_74", "age_18_74")] <- FALSE

    res
}




add_bmi_class <- function(x) {

    stopifnot("weight" %in% names(x))

    stopifnot(
        ("bmi" %in% names(x)) || ("height" %in% names(x))
    )

    res <- x

    if (is.null(x[["bmi"]])) {
        res <- res %>%
            dplyr::mutate(
                bmi = .data$weight / (.data$height/100)^2
            )
    }

    res %>%
        dplyr::mutate(
            bmi_greater_21 = as.character(.data$bmi > 21),
            bmi_class = dplyr::case_when(
                .data$bmi < 18.5 ~ "underweight",
                .data$bmi < 25   ~ "normal weight",
                .data$bmi < 30   ~ "overweight",
                TRUE       ~ "obese"
            ),
            bmi_pavlidou   = .data$weight * .data$bmi^(-0.152),
            bmi_pavlidou_m = .data$weight * .data$bmi^(-0.1786),
            bmi_pavlidou_f = .data$weight * .data$bmi^(-0.2115)
        )
}



add_adj_weight <- function(x) {

    stopifnot(all(c("weight", "height", "sex") %in% names(x)))

    x %>%
        dplyr::mutate(

            height_feet = .data$height * 0.0328084,

            ibw = ifelse(.data$sex == "male",
                52 + 1.9 * ((.data$height_feet - 5)*12),
                49 + 1.7 * ((.data$height_feet - 5)*12)
            ),

            adj_weight = 0.25*(.data$weight - .data$ibw) + .data$ibw

        )
}




add_lbm <- function(x) {

    stopifnot(all(c("weight", "sex") %in% names(x)))

    x %>%
        dplyr::mutate(
            lbm = ifelse(.data$sex == "male",
                (79.5 - 0.24*.data$weight - 0.15*.data$age)*.data$weight/73.2,
                (69.8 - 0.26*.data$weight - 0.12*.data$age)*.data$weight/73.2
            )
        )
}



add_livingston_weight <- function(x) {

    stopifnot("weight" %in% names(x))

    x %>%
        dplyr::mutate(
            livingston_weight_f       = .data$weight^0.4330,
            livingston_weight_m       = .data$weight^0.4356,
            livingston_weight_f_alone = .data$weight^0.4613,
            livingston_weight_m_alone = .data$weight^0.4473,
            livingston_weight_alone   = .data$weight^0.4722,
            livingston_weight_age     = .data$weight^0.4456
        )
}
