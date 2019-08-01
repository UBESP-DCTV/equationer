context("test-which_are_applicable_to_covset")

test_that("known results", {
    expect_equal(
        which_are_applicable_to_covset(eqs_bag_test, "age"),
        character()
    )
    expect_equal(
        which_are_applicable_to_covset(eqs_bag_test, c("age", "bmi")),
        "eqs1"
    )
    expect_equal(
        which_are_applicable_to_covset(eqs_bag_test, c("age", "bmi", "weight")),
        c("eqs1", "eqs2")
    )
    expect_equal(
        which_are_applicable_to_covset(eqs_bag_test, c("age", "weight")),
        "eqs2"
    )
})
