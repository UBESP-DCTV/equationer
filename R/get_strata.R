#' get strata
#'
#' Extract the equation(s) strata
#'
#' @param x the object
#'
#' @return (chr) strata of the equation \code{x}
#' @export
get_strata <- function(x) {
    UseMethod("get_strata", x)
}

#' @describeIn get_strata Extract the strata of the given
#'     \code{eq}uation object.
#' @export
#'
#' @examples
#' library(equationer)
#' eq_test <- eq(age = 0.1, bmi = -0.3,
#'     name    = "eq_test",
#'     outcome = "kcal/day",
#'     strata = list(sex = "female")
#' )
#' get_outcome(eq_test)
#'
#' eq2_test <- eq(age = 0.1, bmi = -0.3,
#'     name    = "eq2_test",
#'     outcome = "kcal/day",
#'     strata = list(sex = "female", nyha = 1)
#' )
#' get_outcome(eq2_test)

get_strata.eq <- function(x) {
    attr(x, "strata")
}




#' @describeIn get_strata Extract the strata of the given
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
#' get_strata(eqs_test)
get_strata.eqs <- function(x) {
    attr(x, "strata")
}

