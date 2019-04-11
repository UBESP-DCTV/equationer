context("test-strata_name")

test_that("works for eq objects", {
  expect_equal(get_strata(eq_test), vector("list"))
  expect_equal(get_strata(eq1), list(sex = "male", nyha = 1))
  expect_equal(get_strata(eq6), list(sex = "male", mellitus = "yes"))
})

test_that("works for eqs objects", {
    expect_equal(
        get_strata(eqs_test),
        list(
          sex  = factor(rep(c("male", "female"), 2)),
          nyha = factor(c(1, 1, 2, 2))
        )
    )
})

