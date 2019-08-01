context("test-eq")

test_that("correct classes", {
    expect_is(eq1, "eq")
})

test_that("attributes' names", {
    expect_equal(
        names(attributes(eq1)),
        c(
            "names",
            "covariates", "strata", "outcome",
            "eq_name",
            "class"
        )
    )
})

test_that("type of objects", {
    expect_is(eq1, "eq")
    expect_is(eq1[[1]], "numeric")

    expect_is(attr(eq1, "eq_name"), "character")
    expect_is(attr(eq1, "outcome"), "character")

    expect_is(attr(eq1, "strata"), "list")
    expect_named(attr(eq1, "strata"))
    expect_is(eq(x = 1, name = "a", outcome = "b"), "eq")

    expect_is(attr(eq1, "covariates"), "character")
})

test_that("must have (unique) names", {
    expect_error(eq(x = 1, 2), "all")
    expect_error(eq(x = 1, y = 2, x = 3), "duplicated")
})

test_that("handle wrong input type", {
    expect_error(eq(name = "a", outcome = "a"), "valid")

    expect_error(eq(x = "1", name = "a", outcome = "b"), "numeric")

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
            strata = list(a = "a", a = "b")
        ),
        "duplicated"
    )

    expect_error(
        eq(x = 1, name = "a", outcome = "a", strata = list(1)),
        "empty names"
    )

    expect_error(
        eq(x = 1, name = "a", outcome = "a", strata = list("a")),
        "empty names"
    )

    expect_error(
        eq(x = 1, name = "a", outcome = "a", strata = c(a = "a")),
        "list"
    )

})
