context("test-get_reference")

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

eqs_test <- eqs(eq_test, eq2_test,
    name = "eqs-test",
    reference = "ref-1"
)
eqs2_test <- eqs(eq_test, eq2_test,
    name = "eqs-test"
)


test_that("works for eqs objects", {
  expect_equal(get_reference(eqs_test), "ref-1")
  expect_equal(get_reference(eqs2_test), NA_character_)
})

test_that("error on wrong input", {
  expect_error(get_reference(eq_test), "only on object of class")
})

