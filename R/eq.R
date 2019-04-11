#' Single equation object
#'
#' Costructor for object of class \code{\link{eq}} defined by its
#' (named) coefficients.
#'
#' @param ... sequence of named coefficients
#' @param name (chr) the name of the equation
#' @param outcome (chr) the outcome produced by the equation
#' @param strata (list, default = empty list) if the equation is one of
#'        a set of equations defined each one for a compbination of
#'        level of some strata variables, `strata` is a list for those
#'        levels (named with strata names)
#'
#' @return an \code{\link{eq}} object
#' @export
#'
#' @examples
#' eq1 <- eq(female = 2, age = 0.3, bmi = -0.21,
#'     name = "cl_test_1",
#'     outcome = "kcal/day"
#' )
#'
#' # works with strata
#' eq2 <- eq(age = 0.3, bmi = -0.5,
#'     name = "cl_test_1",
#'     outcome = "kcal/day",
#'     strata = list(sex = "female")
#' )
#' eq3 <- eq(age = 0.5, bmi = -0.3,
#'     name = "cl_test_1",
#'     outcome = "kcal/day",
#'     strata = list(sex = "male")
#' )
#'
#' # works with multiple strata
#' eq4 <- eq(age = 0.3, bmi = -0.5,
#'     name = "cl_test_1",
#'     outcome = "kcal/day",
#'     strata = list(sex = "female", mellitus = 0)
#' )
#' eq5 <- eq(age = 0.5, bmi = -0.3,
#'     name = "cl_test_1",
#'     outcome = "kcal/day",
#'     strata = list(sex = "female", mellitus = 0)
#' )
#' eq6 <- eq(age = 0.3, bmi = -0.3,
#'     name = "cl_test_1",
#'     outcome = "kcal/day",
#'     strata = list(sex = "male", mellitus = 1)
#' )
#' eq7 <- eq(age = 0.5, bmi = -0.5,
#'     name = "cl_test_1",
#'     outcome = "kcal/day",
#'     strata = list(sex = "male", mellitus = 1)
#' )
#'

eq <- function(..., name, outcome, strata = vector("list")) {

    xs <- list(...)

    if (!rlang::is_named(xs)) {
        ui_stop("Not all variable names are valid or non empty names")
    }

    if (any(duplicated(names(xs)))) {
        ui_stop("Some names are duplicated.")
    }

    if (!all(purrr::map_lgl(xs, is.numeric))) {
        ui_stop("All covariates must be numeric.")
    }


    if (!is_string(name)) {
        ui_stop("{ui_code('eq_name')} must be a single string")
    }

    if (!is_string(outcome)) {
        ui_stop("{ui_code('outcome')} must be a single string")
    }

    if (!inherits(strata, "list")) {
        ui_stop("Strata must be a list")
    }

        if ((length(strata) != 0) && !rlang::is_named(strata)) {
        ui_stop("Not all strata names are valid or non empty names")
    }

    if (any(duplicated(names(strata)))) {
        ui_stop("Some strata names are duplicated.")
    }


    structure(unlist(xs),
        eq_name    = name,
        outcome    = outcome,
        strata     = strata,
        covariates = names(xs),
        class = "eq"
    )
}
