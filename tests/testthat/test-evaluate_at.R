context("test-evaluate_at")

eq_test <- eq(age = 0.1, bmi = -0.3,
    name    = "first eq_test",
    outcome = "out"
)

test_that("correct evaluation", {
    expect_equal(
        eq_test %>%
            evaluate_at(age = 38, bmi = 18),
        c(out = -1.6)
    )

    expect_equal(
        eq_test %>%
            evaluate_at(age = 38, sex = 1, bmi = 18),
        c(out = -1.6)
    )

})


test_that("eror works", {
    expect_error(
        evaluate_at(eq_test, age = 38, sex = "female"),
        "numeric"
    )

    expect_error(evaluate_at(eq_test, 38), "names")

    expect_error(
        evaluate_at(eq_test, age = 38, bmi = 18, age = 38),
        "duplicated"
    )

    expect_error(evaluate_at(eq_test, age = 38), "included")
})
