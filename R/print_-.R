#' Print equations
#'
#' \code{print} prints its argument and returns it invisibly
#' (via invisible(x))
#'
#' @param x an object used to select a method
#' @param ... further arguments passed to or from other methods
#'
#' @return invisible(x)
#' @name print
NULL

#' @describeIn eq Method to print \code{\link{eq}}uations
#' @inheritParams print
#' @return invisible \code{x}
#' @export
#'
#' @examples
#' eq(age = 0.5, bmi = -0.3, name = "eq_test", outcome = "kcal/day")
print.eq <- function(x, ...) {

    ui_line("")
    ui_todo("Equation {ui_value(get_name(x))}: {get_outcome(x)} = {paste(x, names(x), collapse = ' + ')}")
    purrr::iwalk(get_strata(x), ~{
        ui_line("Strata: {ui_field(.y)} = {ui_value(.x)}")
    })
    ui_line("")

    invisible(x)

}


#' @describeIn eqs Method to print \code{\link{eqs}} groups
#' @inheritParams print
#' @return invisible \code{x}
#' @export
#'
#' @examples
#' eq1 <- eq(age = 0.3, bmi = -0.5,
#'     name    = "cl_test_1",
#'     outcome = "kcal/day",
#'     strata = list(sex = "male", nyha = 1)
#' )
#'
#' eq2 <- eq(age = 0.5, bmi = -0.3,                 # change strata wrt eq1
#'     name = "cl_test_2",
#'     outcome = "kcal/day",
#'     strata = list(sex = "female", nyha = 1)
#' )
#'
#' eqs(eq1, eq2, name = "author19", reference = "A.Uthor et.al 2019")
print.eqs <- function(x, ...) {

    ui_line("")
    ui_line("Equations group {ui_value(get_name(x))}:")
    ui_line("")
    purrr::iwalk(get_strata(x), ~{
        ui_line("Strata {ui_field(.y)} w/ levels: {ui_value(levels(.x))}")
    })
    ui_line("")
    purrr::walk(x, ~print(.x))
    ui_line("")
    ui_line("Main reference: {ui_value(get_reference(x))}")

    invisible(x)

}






#' @describeIn eqs_bag Method to print \code{\link{eqs_bag}} bag
#' @inheritParams print
#' @return invisible \code{x}
#' @export
#'
#' @examples
#' eq1 <- eq(age = 0.3, bmi = -0.5, name = "eq-1", outcome = "kcal/day",
#'     strata = list(sex = "male", nyha = 1)
#' )
#' eq2 <- eq(age = 0.5, bmi = -0.3, name = "eq-2", outcome = "kcal/day",
#'     strata = list(sex = "female", nyha = 1)
#' )
#' eq3 <- eq(age = -0.3, bmi = 0.5, name = "eq-3", outcome = "kcal/day",
#'     strata = list(sex = "male", nyha = 2)
#' )
#' eq4 <- eq(age = -0.5, bmi = 0.3, name = "eq-4", outcome = "kcal/day",
#'     strata = list(sex = "female", nyha = 2)
#' )
#'
#'
#' eq9 <- eq(age = -0.1, weight = 0.2, name = "eq-9", outcome = "kcal/month",
#'     strata = list(sex = "female")
#' )
#' eq10 <- eq(age = -0.2, weight = 0.1, name = "eq-10", outcome = "kcal/month",
#'     strata = list(sex = "male")
#' )
#' eq11 <- eq(age = 0.1, weight = -0.2, name = "eq-11", outcome = "kcal/day",
#'     strata = list(sex = "female")
#' )
#' eq12 <- eq(age = 0.2, weight = -0.2, name = "eq-12", outcome = "kcal/day",
#'     strata = list(sex = "male")
#' )
#'
#'
#' eqs1 <- eqs(eq1, eq2, eq3, eq4, name = "eqs-a", reference = "ref-a")
#' eqs2 <- eqs(eq9, eq10, eq11, eq12, name = "eqs-b", reference = "ref-b")
#'
#' eqs_bag(eqs1, eqs2, name = "ubesp19", reference = "DG et.al 2019")
print.eqs_bag <- function(x, ...) {

    ui_line("")
    ui_line("Equations bag {ui_value(get_name(x))} (last update {ui_code(get_last_update(x))})")
    ui_line("")
    ui_line("Variable included: {ui_value(get_covariates(x))}")
    purrr::iwalk(get_strata(x), ~{
        ui_line("Strata: {ui_field(.y)} w/ levels: {ui_value(.x)}")
    })
    ui_line("Outcome considered: {ui_value(get_outcome(x))}")
    ui_line("Number of equation groups: {ui_value(length(x))}")
    ui_line("Overall numeber of equations: {ui_value(sum(purrr::map_int(x, length)))}")
    ui_line("")
    ui_line("Main reference: {ui_value(get_reference(x))}")

    invisible(x)
}

