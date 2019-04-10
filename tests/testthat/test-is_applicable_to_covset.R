context("test-is_applicable_to_covset")

eq_test <- eq(age = 0.1, bmi = -0.3,
    name    = "first eq_test",
    outcome = "kcal/day"
)

test_that("expected results", {
    expect_true(
        is_applicable_to_covset(eq_test, c("age", "bmi"))
    )
    expect_true(
        is_applicable_to_covset(eq_test, c("age", "bmi", "sex"))
    )

    expect_false(is_applicable_to_covset(eq_test, c("age")))
    expect_false(is_applicable_to_covset(eq_test, c("age", "sex")))
})



#'
#' is_applicable_to_covset(eq_test, c("age", "bmi", "sex")) # TRUE
#' is_applicable_to_covset(eq_test, c("age")) # FALSE
#' is_applicable_to_covset(eq_test, c("age", "sex")) # FALSE
