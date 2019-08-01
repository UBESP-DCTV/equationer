context("test-outocme_name")

test_that("works for eq objects", {
  expect_equal(get_outcome(eq_test), "kcal/day")
})


test_that("works for eqs objects", {
  expect_equal(get_outcome(eqs_test), rep("kcal/day", 4))
})

test_that("works for eqs_bag objects", {
  expect_equal(get_outcome(eqs_bag_test), c("kcal/day", "kcal/month"))
})
