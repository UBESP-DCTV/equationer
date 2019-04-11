context("test-outocme_name")

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

test_that("works for eq objects", {
  expect_equal(get_outcome(eq_test), "kcal/day")
})


test_that("works for eq objects", {
  expect_equal(get_outcome(eqs_test), c("kcal/day", "kcal/day"))
})
