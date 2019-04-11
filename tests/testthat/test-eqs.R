context("test-eqs")

eq1 <- eq(age = 0.3, bmi = -0.5,
    name    = "cl_test_1",
    outcome = "kcal/day",
    strata = list(sex = "male", nyha = 1)
)

eq2 <- eq(age = 0.5, bmi = -0.3,
    name = "cl_test_2",
    outcome = "kcal/day",
    strata = list(sex = "female", nyha = 1)
)

eq3 <- eq(age = 0.3, bmi = -0.5,
    name    = "cl_test_3",
    outcome = "kcal/day",
    strata = list(sex = "male", nyha = 2)
)
eq4 <- eq(age = 0.5, bmi = -0.3,
    name = "cl_test_4",
    outcome = "kcal/day",
    strata = list(sex = "female", nyha = 2)
)

eq5 <- eq(age = 0.5, bmi = -0.3, weight = 0.1,
    name = "cl_test_5",
    outcome = "kcal/day",
    strata = list(sex = "female", nyha = 2)
)

eq6 <- eq(age = 0.5, bmi = -0.3,
    name = "cl_test_6",
    outcome = "kcal/day",
    strata = list(sex = "female", mellitus = "yes")
)

eq7 <- eq(age = 0.5, bmi = -0.3,
    name = "cl_test_7",
    outcome = "kcal/day",
    strata = list(sex = "male", nyha = 1)
)
eq8 <- eq(age = 0.5, bmi = -0.3,
    name = "cl_test_7",
    outcome = "kcal/month",
    strata = list(sex = "male", nyha = 1)
)

eqs1 <- eqs(eq1, eq2, name = "gendered-1")


test_that("correct class", {
    expect_is(eqs1, "eqs")
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
