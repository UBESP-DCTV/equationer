context("test-eqs_bag")

test_that("correct class", {
    expect_is(eqs_bag_test, "eqs_bag")
})

test_that("main list has names", {
    expect_named(eqs_bag_test)
})

test_that("list all covariates", {
    expect_equal(
        attr(eqs_bag_test, "covariates"),
        c("age", "bmi", "weight")
    )
})

test_that("list all strata", {
    expect_equal(
        attr(eqs_bag_test, "strata"),
        list(
            sex = c("female", "male"),
            nyha = c(1L, 2L)
        )
    )
})

test_that("list all outcome", {
    expect_equal(
        attr(eqs_bag_test, "outcome"),
        c("kcal/day", "kcal/month")
    )
})


test_that("list the last update", {
    expect_equal(
        attr(eqs_bag_test, "last_update"),
        lubridate::today()
    )
})

test_that("error if without name", {
    expect_error(eqs_bag(eqs1, eqs2), "is missing")
})

test_that("error if not all eqs", {
    expect_error(eqs_bag(eqs1, eq_test, name = "a"), "are of class")
})

test_that("error if eqs have same names", {
    expect_error(eqs_bag(eqs1, eqs2_samename, name = "a"), "names are duplicated")
})

test_that("error if multiple names", {
    expect_error(
        eqs_bag(eqs1, eqs2, name = c("a", "b")),
        "single string"
    )
    expect_error(
        eqs_bag(eqs1, eqs2, name = 1),
        "single string"
    )
})

test_that("error if multiple ref", {
    expect_error(
        eqs_bag(eqs1, eqs2, name = "a", reference = c("a", "b")),
        "single string"
    )
    expect_error(
        eqs_bag(eqs1, eqs2, name = "a", reference = 1),
        "single string"
    )
})


test_that("error if wrong date", {
    expect_error(
        eqs_bag(eqs1, eqs2,
            name = "a",
            last_update = "01-01-2001"
        ),
        "single date"
    )
    expect_error(
        eqs_bag(eqs1, eqs2,
            name = "a",
            last_update = rep(lubridate::today(), 2)
        ),
        "single date"
    )
})

