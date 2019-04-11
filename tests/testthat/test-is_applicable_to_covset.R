context("test-is_applicable_to_covset")

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

