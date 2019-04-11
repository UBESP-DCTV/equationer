context("test-evaluate_at")

eq_test <- eq(age = 0.5, bmi = -0.3,
    name    = "eq_test",
    outcome = "kcal/day"
)
eq1_test <- eq(age = 0.5, bmi = -0.3,
    name    = "eq_test",
    outcome = "kcal/day",
    strata = list(sex = "female")
)

evaluated <- evaluate_at(eq_test, age = 38, bmi = 18)
evaluated1 <- evaluate_at(eq_test, age = 38, bmi = 18, weight = 81)
evaluated2 <- evaluate_at(eq1_test, age = 38, bmi = 18)


eq2_test <- eq(age = 0.3, bmi = -0.5,
    name    = "eq2_test",
    outcome = "kcal/day",
    strata = list(sex = "male")
)

eqs_test <- eqs(eq1_test, eq2_test, name = "eqs-test")

evaluateds  <- evaluate_at(eqs_test, age = 38, bmi = 18)
evaluateds1 <- evaluate_at(eqs_test, age = 38, bmi = 18, weight = 81)
evaluateds2 <- evaluate_at(eqs_test, age = 38, bmi = 18, sex = "female")
evaluateds3 <- evaluate_at(eqs_test, age = 38, bmi = 18, .outcome = "kcal/day")
evaluateds4 <- evaluate_at(eqs_test, age = 38, bmi = 18, sex = "female", .outcome = "kcal/day")







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
        c("age", "bmi", "weight", "outcome", "estimation", "eq_name")
    )
    expect_equal(
        names(evaluated2),
        c("age", "bmi", "sex", "outcome", "estimation", "eq_name")
    )


    var_output <- c(
        "age", "bmi", "sex", "outcome", "estimation", "eq_name",
        "eq_group", "reference"
    )
    expect_equal(names(evaluateds), var_output)
    expect_equal(names(evaluateds1), c(
        "age", "bmi", "weight", "sex", "outcome", "estimation", "eq_name",
        "eq_group", "reference"
    ))
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
    expect_equal(evaluated[["estimation"]], 13.6)
    expect_equal(evaluated[["eq_name"]], "eq_test")


    expect_equal(evaluated1[["weight"]], 81)

    expect_equal(evaluated2[["sex"]], "female")

})


test_that("eror works for eq", {
    expect_error(
        evaluate_at(eq_test, age = 38, weight = "heavy"),
        "numeric"
    )

    expect_error(evaluate_at(eq_test, 38), "names")

    expect_error(
        evaluate_at(eq_test, age = 38, bmi = 18, age = 38),
        "duplicated"
    )

    expect_error(
        evaluate_at(eq_test, age = 38),
        "included in the set supplied"
    )
})


test_that("correct evaluation for eqs", {
    expect_equal(evaluateds[["estimation"]],  c(13.6, 2.4))
    expect_equal(evaluateds1[["estimation"]], c(13.6, 2.4))
    expect_equal(evaluateds2[["estimation"]], 13.6)
    expect_equal(evaluateds3[["estimation"]], c(13.6, 2.4))
    expect_equal(evaluateds4[["estimation"]], 13.6)

    expect_equal(evaluateds[["age"]],  c(38, 38))
    expect_equal(evaluateds[["bmi"]],  c(18, 18))
    expect_equal(evaluateds[["sex"]],  factor(c("female", "male")))
    expect_equal(evaluateds[["outcome"]],  c("kcal/day", "kcal/day"))
    expect_equal(evaluateds[["eq_name"]],  c("eq_test", "eq2_test"))
    expect_equal(evaluateds[["eq_group"]],  c("eqs-test", "eqs-test"))
    expect_equal(evaluateds[["reference"]],  c(NA_character_, NA_character_))

})


test_that("errors work for eqs", {
    expect_error(evaluate_at(eqs_test, 38), "names")
    expect_error(
        evaluate_at(eqs_test, age = 38, bmi = 18, age = 38),
        "duplicated"
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
