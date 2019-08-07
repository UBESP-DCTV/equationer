context("test-get_reference")

test_that("works properly", {
  expect_equal(get_reference(eqs_test), "ref-1")
  expect_equal(get_reference(eqs_noref), NA_character_)

  expect_equal(get_reference(eqs_bag_test), "equationer-test-bag")
})

test_that("error on wrong input", {
    expect_error(get_reference(eq_test), "only on object of class",
            class = "equationer_error"
        )
})

