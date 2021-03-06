context("test-get_name")

test_that("works for eq objects", {
  expect_equal(get_name(eq_test), "eq_test")
})

test_that("works for eqs objects", {
  expect_equal(get_name(eqs_test), c("eqs-test"))
})

test_that("works for eqs_bag objects", {
  expect_equal(get_name(eqs_bag_test), c("overall-bag"))
})
