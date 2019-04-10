context("test-covariates_name")

eq_test <- eq(age = 0.1, bmi = -0.3,
    name    = "first eq_test",
    outcome = "kcal/day",
    stratum = c(sex = "female")
)

test_that("works for eq objects", {
  expect_equal(get_covariates(eq_test), c("age", "bmi"))
})
