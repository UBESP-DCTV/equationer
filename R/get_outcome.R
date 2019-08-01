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


#' @describeIn get_outcome Extract the outcome of the given
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
#' get_outcome(eqs_test)
get_outcome.eqs <- function(x) {
    attr(x, "outcome")
}



#' @describeIn get_outcome Extract all the possible outcomes for some
#'     \code{\link{eq}}ation in the \code{\link{eqs_bag}}.
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
#' eq3_test <- eq(age = -0.1, bmi = 0.3,
#'     name    = "eq_test",
#'     outcome = "kcal/month",
#'     strata = list(sex = "male", nyha = 1)
#' )
#' eq4_test <- eq(age = -0.1, bmi = 0.3,
#'     name    = "eq2_test",
#'     outcome = "kcal/month",
#'     strata = list(sex = "unknown", nyha = 2)
#' )
#'
#' eqs_test <- eqs(eq_test, eq2_test, name = "eqs-test")
#' eqs2_test <- eqs(eq3_test, eq4_test, name = "eqs2-test")
#'
#' eqs_bag1_test <- eqs_bag(eqs_test, eqs2_test,
#'     name = "a",
#'     reference = "b"
#' )
#' get_outcome(eqs_bag1_test)
get_outcome.eqs_bag <- function(x) {
    attr(x, "outcome")
}
