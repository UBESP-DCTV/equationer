context("test-stratum_name")

eq_test <- eq(age = 0.1, bmi = -0.3,
    name    = "first eq_test",
    outcome = "kcal/day",
    stratum = c(sex = "female")
)

test_that("works for eq objects", {
  expect_equal(get_stratum(eq_test), c(sex = "female"))
})
