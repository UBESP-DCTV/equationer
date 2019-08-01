#' get equations' names for a set of them
#'
#' Extract the equation(s) name(s) from bags of equations (objects of
#' class \code{\link{eqs}})
#'
#' @param x the object
#'
#' @return (chr) set of names for the equations in \code{x}
#' @export
get_eq_names <- function(x) {
    UseMethod("get_eq_names", x)
}


#' @describeIn get_eq_names Extract the equations's names of the given
#'     \code{eqs} object.
#' @export
#'
#' @examples
#' library(equationer)
#' eq_test <- eq(age = 0.1, bmi = -0.3,
#'     name    = "eq_test",
#'     outcome = "kcal/day",
#'     strata = list(sex = "female")
#' )
#' eq2_test <- eq(age = 0.1, bmi = -0.3,
#'     name    = "eq2_test",
#'     outcome = "kcal/day",
#'     strata = list(sex = "male")
#' )
#'
#' eqs_test <- eqs(eq_test, eq2_test, name = "eqs-test")
#' get_eq_names(eqs_test)
get_eq_names.eqs <- function(x) {
    names(x)
}
