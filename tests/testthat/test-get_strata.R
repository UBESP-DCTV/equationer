context("test-strata_name")

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

eq3_test <- eq(age = 0.1, bmi = -0.3,
    name    = "eq2_test",
    outcome = "kcal/day",
    strata = list(sex = "male", mellitus = "yes")
)

eqs_test <- eqs(eq_test, eq2_test, name = "eqs-test")


test_that("works for eq objects", {
  expect_equal(get_strata(eq_test), list(sex = "female"))
  expect_equal(get_strata(eq3_test), list(sex = "male", mellitus = "yes"))
})

test_that("works for eqs objects", {
    expect_equal(
        get_strata(eqs_test),
        list(sex = factor(c("female", "male")))
    )
})

