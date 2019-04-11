#' get stratum
#'
#' Extract the equation(s) stratum
#'
#' @param x the object
#'
#' @return (chr) stratum of the equation \code{x}
#' @export
get_stratum <- function(x) {
    UseMethod("get_stratum", x)
}

#' @describeIn get_stratum Extract the stratum of the given
#'     \code{eq}uation object.
#' @export
#'
#' @examples
#' library(equationer)
#' eq_test <- eq(age = 0.1, bmi = -0.3,
#'     name    = "first eq_test",
#'     outcome = "kcal/day",
#'     stratum = c(sex = "female")
#' )
#' get_outcome(eq_test)
get_stratum.eq <- function(x) {
    attr(x, "stratum")
}
