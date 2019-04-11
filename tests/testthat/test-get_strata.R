context("test-strata_name")

eq_test <- eq(age = 0.1, bmi = -0.3,
    name    = "first eq_test",
    outcome = "kcal/day",
    strata = list(sex = "female")
)

eq2_test <- eq(age = 0.1, bmi = -0.3,
    name    = "first eq_test",
    outcome = "kcal/day",
    strata = list(sex = "female", mellitus = "yes")
)


test_that("works for eq objects", {
  expect_equal(get_strata(eq_test), list(sex = "female"))
  expect_equal(get_strata(eq2_test), list(sex = "female", mellitus = "yes"))
})
