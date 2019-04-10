context("test-outocme_name")

eq_test <- eq(age = 0.1, bmi = -0.3,
    name    = "first eq_test",
    outcome = "kcal/day"
)

test_that("works for eq objects", {
  expect_equal(get_outcome(eq_test), "kcal/day")
})
