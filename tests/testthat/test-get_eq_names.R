context("test-get_eq_names")

test_that("works for eq objects", {
  expect_equal(get_eq_names(eqs_test), paste0("cl_test_", 1:4))
})
