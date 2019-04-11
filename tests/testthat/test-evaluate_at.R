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
        c("age", "bmi", "weight", "outcome", "estimation", "eq_name")
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
    expect_equal(evaluated[["estimation"]], 13.6)
    expect_equal(evaluated[["eq_name"]], "eq_test")


    expect_equal(evaluated1[["weight"]], 81)

    expect_equal(evaluated2[["sex"]], "male")
    expect_equal(evaluated2[["nyha"]], 1)

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
    expect_equal(evaluateds[["estimation"]],  c(2.4, 13.6, -2.4, -13.6))
    expect_equal(evaluateds1[["estimation"]], c(2.4, 13.6, -2.4, -13.6))
    expect_equal(evaluateds2[["estimation"]], c(13.6, -13.6))
    expect_equal(evaluateds3[["estimation"]], c(2.4, 13.6, -2.4, -13.6))
    expect_equal(evaluateds4[["estimation"]], c(13.6, -13.6))

    expect_equal(evaluateds[["age"]],  rep(38, 4))
    expect_equal(evaluateds[["bmi"]],  rep(18, 4))
    expect_equal(
        evaluateds[["sex"]],
        factor(rep(c("male", "female"), 2))
    )
    expect_equal(evaluateds[["outcome"]],  rep("kcal/day", 4))
    expect_equal(evaluateds[["eq_name"]],  paste0("cl_test_", 1:4))
    expect_equal(evaluateds[["eq_group"]],  rep("eqs-test", 4))
    expect_equal(evaluateds[["reference"]],  rep("ref-1", 4))

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
