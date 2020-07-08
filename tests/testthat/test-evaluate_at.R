context("test-evaluate_at")

test_that("correct class", {
    expect_is(evaluated, "tbl_df")
    expect_is(evaluated1, "tbl_df")
    expect_is(evaluated2, "tbl_df")

    expect_is(evaluateds, "tbl_df")
    expect_is(evaluateds1, "tbl_df")
    expect_is(evaluateds2, "tbl_df")
})

test_that("correct columns", {
    expect_equal(
        names(evaluated),
        c("age", "bmi", "outcome", "estimation", "eq_name")
    )
    expect_equal(
        names(evaluated1),
        c("age", "bmi", "outcome", "estimation", "eq_name")
    )
    expect_equal(
        names(evaluated2),
        c("age", "bmi", "sex", "nyha", "outcome", "estimation", "eq_name")
    )


    expect_equal(names(evaluateds), var_output)
    expect_equal(names(evaluateds1), var_output_weight)
    expect_equal(names(evaluateds2), var_output)
    expect_equal(names(evaluateds3), var_output)
    expect_equal(names(evaluateds4), var_output)
    expect_equal(
        names(suppressWarnings(
            evaluate_at(eqs_test, age = 38, bmi = 18, sex = "unknown")
        )),
        var_output
    )
    expect_equal(
        names(suppressWarnings(
            evaluate_at(eqs_test, age = 38, bmi = 18, .outcome = "kcal")
        )),
        var_output
    )
    expect_equal(
        names(suppressWarnings(evaluate_at(eqs_test,
            age = 38, bmi = 18,
            sex = "unknown",
            .outcome = "kcal"
        ))),
        var_output
    )
})


test_that("correct evaluation for eq", {

    expect_equal(evaluated[["age"]], 38)
    expect_equal(evaluated[["bmi"]], 18)
    expect_equal(evaluated[["outcome"]], "kcal/day")
    expect_equal(evaluated[["estimation"]], c(`kcal/day` = 13.6))
    expect_equal(evaluated[["eq_name"]], "eq_test")


    expect_equal(evaluated2[["sex"]], "male")
    expect_equal(evaluated2[["nyha"]], 1)

})


test_that("error works for eq", {
    expect_error(
        evaluate_at(eq_test, age = 38, weight = "heavy"),
        "are included",
        class = "equationer_error"
    )

    expect_error(evaluate_at(eq_test, 38), "names",
        class = "equationer_error"
    )

    expect_error(
        evaluate_at(eq_test, age = 38, bmi = 18, age = 38),
        "duplicated",
        class = "equationer_error"
    )

    expect_error(
        evaluate_at(eq_test, age = 38),
        "included in the set supplied",
        class = "equationer_error"
    )
})


test_that("correct evaluation for eqs", {
    expect_equal(unname(evaluateds[["estimation"]]),  c(2.4, 13.6, -2.4, -13.6))
    expect_equal(unname(evaluateds1[["estimation"]]), c(2.4, 13.6, -2.4, -13.6))
    expect_equal(unname(evaluateds2[["estimation"]]), c(13.6, -13.6))
    expect_equal(unname(evaluateds3[["estimation"]]), c(2.4, 13.6, -2.4, -13.6))
    expect_equal(unname(evaluateds4[["estimation"]]), c(13.6, -13.6))

    expect_equal(evaluateds[["age"]],  rep(38, 4))
    expect_equal(evaluateds[["bmi"]],  rep(18, 4))
    expect_equal(
        evaluateds[["sex"]],
        rep(c("male", "female"), 2)
    )
    expect_equal(evaluateds[["outcome"]],  rep("kcal/day", 4))
    expect_equal(evaluateds[["eq_name"]],  paste0("cl_test_", 1:4))
    expect_equal(evaluateds[["eq_group"]],  rep("eqs-test", 4))
    expect_equal(evaluateds[["reference"]],  rep("ref-1", 4))

})


test_that("errors work for eqs", {
    expect_error(evaluate_at(eqs_test, 38), "names",
        class = "equationer_error")
    expect_error(
        evaluate_at(eqs_test, age = 38, bmi = 18, age = 38),
        "duplicated",
        class = "equationer_error"
    )
})

test_that("warnins work for eqs", {
    expect_warning(
        evaluate_at(eqs_test, age = 38, bmi = 18, sex = "unknown"),
        "levels requested are not included"
    )
    expect_warning(
        evaluate_at(eqs_test, age = 38, bmi = 18, .outcome = "xxx"),
        "Only equations with possible outcome"
    )

    expect_warning(
        evaluate_at(eqs_test, age = 38, sex = 1, bmi = 18),
        "levels requested are not included"
    )
})






test_that("correct evaluation for eqs_bag", {

    expect_equal(
        evaluate_at(eqs_bag_test, age = 35)[["estimation"]],
        numeric()
    )

    expect_equal(
        suppressWarnings(
            unname(evaluate_at(eqs_bag_test, age = 35, bmi = 18)[["estimation"]])
        ),
        c(1.5, 12.1, -1.5, -12.1)
    )

    expect_equal(
        suppressWarnings(
            unname(evaluate_at(eqs_bag_test, age = 35, bmi = 18, weight = 81)[["estimation"]])
        ),
        c(1.5, 12.1, -1.5, -12.1, 12.7, 1.1, -12.7, -9.2)
    )

    expect_equal(
        suppressWarnings(
            unname(evaluate_at(eqs_bag_test, age = 35, bmi = 18, sex = "female")[["estimation"]])
        ),
        c(12.1, -12.1)
    )

    expect_equal(
        suppressWarnings(
            unname(evaluate_at(eqs_bag_test, age = 35, bmi = 18, weight = 81, sex = "female")[["estimation"]])
        ),
        c(12.1, -12.1,  12.7, -12.7)
    )

    expect_equal(
        suppressWarnings(
            unname(evaluate_at(eqs_bag_test, age = 35, bmi = 18, weight = 81, nyha = 1)[["estimation"]])
        ),
        c(1.5, 12.1, 12.7, 1.1, -12.7, -9.2)
    )

    expect_equal(
        unname(evaluate_at(eqs_bag_test, age = 35, bmi = 18, weight = 81, .outcome = "kcal/day")[["estimation"]]),
        c(1.5, 12.1, -1.5, -12.1, -12.7, -9.2)
    )

    expect_equal(
        unname(evaluate_at(eqs_bag_test, age = 35, bmi = 18, weight = 81, sex = "female", .outcome = "kcal/day")[["estimation"]]),
        c(12.1, -12.1, -12.7)
    )
})


test_that("warnins work for eqs", {
    expect_warning(
        evaluate_at(eqs_bag_test, age = 38, bmi = 18, sex = "unknown"),
        "levels requested are not included"
    )

    expect_warning(
        evaluate_at(eqs_bag_test, age = 35, bmi = 18),
        "Only equations with possible outcome"
    )
    expect_warning(
        evaluate_at(eqs_bag_test, age = 35, bmi = 18, weight = 81),
        "Only equations with possible outcome"
    )
    expect_warning(
        evaluate_at(eqs_bag_test, age = 35, bmi = 18, sex = "female"),
        "Only equations with possible outcome"
    )
    expect_warning(
        evaluate_at(eqs_bag_test, age = 35, bmi = 18, weight = 81, sex = "female"),
        "Only equations with possible outcome"
    )
    expect_warning(
        evaluate_at(eqs_bag_test, age = 35, bmi = 18, weight = 81, nyha = 1),
        "Only equations with possible outcome"
    )

})

test_that("works with data frames", {
    expect_is(
        suppressWarnings(evaluate_at(eqs_bag_test, one_patient)),
        "tbl_df"
    )
    expect_is(
        suppressWarnings(evaluate_at(eqs_bag_test, more_patients)),
        "tbl_df"
    )

    expect_equal(
        suppressWarnings(
            unname(evaluate_at(eqs_bag_test, one_patient)[["estimation"]])
        ),
        c(12.1, -12.1, 12.7, -12.7)
    )
    expect_equal(
        suppressWarnings(
            unname(evaluate_at(eqs_bag_test, more_patients)[["estimation"]])
        ),
        c(12.1, -12.1, 12.7, -12.7, -1.9, 1.9, 3.9, -13.2)
    )

    expect_equal(
        suppressWarnings(
            names(evaluate_at(eqs_bag_test, more_patients))
        ),
        c(
            "age", "bmi", "sex", "nyha", "outcome",
            "estimation", "eq_name", "eq_group", "reference",
            "weight", ".source_row"
        )
    )

})


test_that("works with multiple posible matching variables", {
    expect_is(evaluated_multimatch_bag, "tbl_df")
    expect_equal(nrow(evaluated_multimatch_bag), 4)
})




test_that("eqs_bag works with data that include missing strata", {
    expect_is(
        suppressWarnings(
            evaluate_at(eqs_bag_test,
                age = 1, bmi = 1, weight = 1, diabetics = FALSE
            )
        ),
        "tbl_df"
    )
})


test_that("Works with only age and BMI on reer", {
    expect_is(
        suppressWarnings(evaluate_at(reer, age = 50, bmi = 21)),
        "tbl_df"
    )
})


test_that("intercept is not a strata (i.e., no warnings here!)", {
    expect_silent(evaluate_at(reer, sex = "male", .outcome = "bmr"))
})


test_that("problems with factor and character join do not occurs", {
    a <- data.frame(
        age = 38, bmi = 25.1, bmi_pavlidou = 52.1, bmi_pavlidou_f = 43,
        bmi_pavlidou_m = 47.8, height = 184, lbm = 62,
        livingston_weight_age = 7.24, livingston_weight_alone = 8.15,
        livingston_weight_f = 6.85, livingston_weight_f_alone = 7.76,
        livingston_weight_m = 6.93, livingston_weight_m_alone = 7.3,
        weight = 85, age_18_74 = "TRUE", age_60_70 = "FALSE",
        age_60_74 = "FALSE", bmi_class = "overweight",
        bmi_greater_21 = "TRUE", copd = "FALSE", diabetic = "FALSE",
        ethnicity = "white", hf = "FALSE", inpatients = "FALSE",
        older_18 = "TRUE", older_29 = "TRUE", older_59 = "FALSE",
        older_60 = "FALSE", older_70 = "FALSE", older_74 = "FALSE",
        pal = "low-active", rheumatoid_arthritis = "FALSE",
        sex = "male", stringsAsFactors = FALSE
    )

    expect_is(
        suppressWarnings(suppressMessages(
            evaluate_at(reer, a)
        )),
        "tbl_df"
    )
})
