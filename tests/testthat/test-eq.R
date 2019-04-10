context("test-eq")

eq_x1y2 <- eq(x = 1, y = 2,
    name = "test",
    outcome = "z",
    stratum = c(sex = "female")
)

test_that("correct classes", {
    expect_is(eq_x1y2, "eq")
})

test_that("components names", {
    expect_equal(
        names(eq_x1y2),
        c("eq", "eq_name", "outcome", "stratum", "covariates")
    )
})

test_that("type of objects", {
    expect_is(eq_x1y2[["eq"]], "matrix")
    expect_is(eq_x1y2[["eq_name"]], "character")
    expect_is(eq_x1y2[["outcome"]], "character")

    expect_is(eq_x1y2[["stratum"]], "character")
    expect_named(eq_x1y2[["stratum"]])
    expect_is(eq(x = 1, name = "a", outcome = "b"), "eq")

    expect_is(eq_x1y2[["covariates"]], "character")
})

test_that("must have (unique) names", {
    expect_error(eq(x = 1, 2), "all")
    expect_error(eq(x = 1, y = 2, x = 3), "duplicated")
})

test_that("handle wrong input type", {
    expect_error(
        eq(x = 1, name = c("a", "b"), outcome = "a"),
        "single"
    )
    expect_error(
        eq(x = 1, name = 1, outcome = "a"),
        "string"
    )
    expect_error(
        eq(x = 1, name = "a", outcome = c("a", "b")),
        "single"
    )
    expect_error(
        eq(x = 1, name = "a", outcome = 1),
        "string"
    )
    expect_error(
        eq(
            x = 1,
            name = "a",
            outcome = "a",
            stratum = c(a = "a", a = "b")
        ),
        "single"
    )

    expect_error(
        eq(x = 1, name = "a", outcome = "a", stratum = 1),
        "string"
    )

    expect_error(
        eq(x = 1, name = "a", outcome = "a", stratum = "a"),
        "named"
    )

})