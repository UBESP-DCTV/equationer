context("test-is_applicable_to_covset")

eq_test <- eq(age = 0.1, bmi = -0.3,
    name    = "eq_test",
    outcome = "kcal/day",
    strata = list(sex = "female")
)
eq2_test <- eq(age = 0.1, bmi = -0.3,
    name    = "eq2_test",
    outcome = "kcal/day",
    strata = list(sex = "male")
)

eqs_test <- eqs(eq_test, eq2_test, name = "eqs-test")

test_that("expected results for eq", {
    expect_true(
        is_applicable_to_covset(eq_test, c("age", "bmi"))
    )
    expect_true(
        is_applicable_to_covset(eq_test, c("age", "bmi", "sex"))
    )

    expect_false(is_applicable_to_covset(eq_test, c("age")))
    expect_false(is_applicable_to_covset(eq_test, c("age", "sex")))
})

test_that("expected results for eqs", {
    expect_true(
        is_applicable_to_covset(eq_test, c("age", "bmi"))
    )
    expect_true(
        is_applicable_to_covset(eq_test, c("age", "bmi", "sex"))
    )

    expect_false(is_applicable_to_covset(eq_test, c("age")))
    expect_false(is_applicable_to_covset(eq_test, c("age", "sex")))
})

