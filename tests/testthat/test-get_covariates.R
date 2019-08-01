context("test-covariates_name")

test_that("works for eq objects", {
  expect_equal(get_covariates(eq_test), c("age", "bmi"))
})

test_that("works for eqs objects", {
  expect_equal(get_covariates(eqs_test), c("age", "bmi"))
})

test_that("works for eqs_bag objects", {
  expect_equal(get_covariates(eqs_bag_test), c("age", "bmi", "weight"))
})
