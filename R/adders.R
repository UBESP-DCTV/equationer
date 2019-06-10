add_age_classes <- function(x) {

    stopifnot("age" %in% names(x))

    age <- x[["age"]]

    res <- x %>%
        mutate(
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
            mutate(
                bmi = weight / (height/100)^2
            )
    }

    res %>%
        mutate(
            bmi_greater_21 = as.character(bmi > 21),
            bmi_class = dplyr::case_when(
                bmi < 18.5 ~ "underweight",
                bmi < 25   ~ "normal weight",
                bmi < 30   ~ "overweight",
                TRUE       ~ "obese"
            ),
            bmi_pavlidou   = weight * bmi^(-0.152),
            bmi_pavlidou_m = weight * bmi^(-0.1786),
            bmi_pavlidou_f = weight * bmi^(-0.2115)
        )
}



add_adj_weight <- function(x) {

    stopifnot(all(c("weight", "height", "sex") %in% names(x)))

    x %>%
        mutate(

            height_feet = height * 0.0328084,

            ibw = ifelse(sex == "male",
                52 + 1.9 * ((height_feet - 5)*12),
                49 + 1.7 * ((height_feet - 5)*12)
            ),

            adj_weight = 0.25*(weight - ibw) + ibw

        )
}




add_lbm <- function(x) {

    stopifnot(all(c("weight", "sex") %in% names(x)))

    x %>%
        mutate(
            lbm = ifelse(sex == "male",
                (79.5 - 0.24*weight - 0.15*age)*weight/73.2,
                (69.8 - 0.26*weight - 0.12*age)*weight/73.2
            )
        )
}



add_livingston_weight <- function(x) {

    stopifnot("weight" %in% names(x))

    x %>%
        mutate(
            livingston_weight_f       = weight^0.4330,
            livingston_weight_m       = weight^0.4356,
            livingston_weight_f_alone = weight^0.4613,
            livingston_weight_m_alone = weight^0.4473,
            livingston_weight_alone   = weight^0.4722,
            livingston_weight_age     = weight^0.4456
        )
}
