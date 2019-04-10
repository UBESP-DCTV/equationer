#' get name
#'
#' Extract the equation(s) name(s)
#'
#' @param x the object
#'
#' @return (chr) name of \code{x}
#' @export
get_name <- function(x) {
    UseMethod("get_name", x)
}

#' @describeIn get_name Extract the name of the given
#'     \code{eq}uation object.
#' @export
#'
#' @examples
#' library(equationer)
#' eq_test <- eq(age = 0.1, bmi = -0.3,
#'     name    = "first eq_test",
#'     outcome = "kcal/day"
#' )
#' get_name(eq_test)
get_name.eq <- function(x) {
    x[["eq_name"]]
}
