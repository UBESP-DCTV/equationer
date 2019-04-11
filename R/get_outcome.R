#' get outcome
#'
#' Extract the equation(s) outcome(s)
#'
#' @param x the object
#'
#' @return (chr) outcomes of the equation \code{x} (dependent variable)
#' @export
get_outcome <- function(x) {
    UseMethod("get_outcome", x)
}

#' @describeIn get_outcome Extract the outcome of the given
#'     \code{eq}uation object.
#' @export
#'
#' @examples
#' library(equationer)
#' eq_test <- eq(age = 0.1, bmi = -0.3,
#'     name    = "first eq_test",
#'     outcome = "kcal/day"
#' )
#' get_outcome(eq_test)
get_outcome.eq <- function(x) {
    attr(x, "outcome")
}
