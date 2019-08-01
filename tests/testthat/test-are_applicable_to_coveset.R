context("test-are_applicable_to_coveset")

test_that("known results", {
    expect_equal(
        are_applicable_to_coveset(eqs_bag_test, "age"),
        c(eqs1 = FALSE, eqs2 = FALSE)
    )
    expect_equal(
        are_applicable_to_coveset(eqs_bag_test, c("age", "bmi")),
        c(eqs1 = TRUE, eqs2 = FALSE)
    )
    expect_equal(
        are_applicable_to_coveset(eqs_bag_test, c("age", "bmi", "weight")),
        c(eqs1 = TRUE, eqs2 = TRUE)
    )
    expect_equal(
        are_applicable_to_coveset(eqs_bag_test, c("age", "weight")),
        c(eqs1 = FALSE, eqs2 = TRUE)
    )
})
