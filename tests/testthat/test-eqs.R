context("test-eqs")


test_that("correct class", {
    expect_is(eqs_test, "eqs")
})

test_that("equations must have different names", {
    expect_error(
        eqs(eq1, eq1, name = "same-names"),
        "names are duplicated"
    )
})

test_that("equations must have same covariates and strata", {
    expect_error(
        eqs(eq1, eq5, name = "different-covariates"),
        "same set of covariates"
    )
    expect_error(
        eqs(eq1, eq6, name = "different-strata"),
        "same set of strata"
    )
})



test_that("correct strata", {
    eqs2 <- eqs(eq1, eq2, eq3, eq4, name = "test-strata")

    expect_is(attr(eqs2, "strata"), "list")
    expect_is(attr(eqs2, "strata")[["sex"]], "factor")
    expect_is(attr(eqs2, "strata")[["nyha"]], "factor")
})

test_that("correct covariates", {
    eqs2 <- eqs(eq1, eq2, eq3, eq4, name = "test-strata")

    expect_equal(attr(eqs2, "covariates"), c("age", "bmi"))

})

test_that("same combination of strata and output throw an error", {
    expect_error(
        eqs(eq1, eq7, name = "redundant-strata-and-output"),
        "cannot share same combination of strata and outcome"
    )
    expect_is(
        eqs(eq1, eq8, name = "redundant-strata-not_output"),
        "eqs"
    )
})


test_that("handle wrong input type", {
    expect_error(eqs(2, name = "test"), "class")
    expect_output(try(eqs(2, name = "test")), "1")
    expect_output(try(eqs(2, name = "test")), "numeric")

    expect_error(eqs(eq1, "a", name = "test"), "class")
    expect_output(try(eqs(eq1, "a", name = "test")), "2")
    expect_output(try(eqs(eq1, "a", name = "test")), "character")
})


test_that("eqs works without strata in eq", {
    expect_is(
        eqs(eq(a = 1, b = 2, name = "a", outcome = "b"), name = "c"),
        "eqs"
    )
})
