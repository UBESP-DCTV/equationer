#' get strata
#'
#' Extract the equation(s) strata
#'
#' @param x the object
#'
#' @export
get_strata <- function(x) {
    UseMethod("get_strata", x)
}

#' @describeIn get_strata Extract the strata of the given
#'     \code{eq}uation object.
#'
#' @return (chr) levels' strata for the \code{\link{eq}}uation \code{x}
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
#' get_strata(eq2_test)

get_strata.eq <- function(x) {
    attr(x, "strata")
}




#' @describeIn get_strata Extract the strata of the given
#'     \code{eqs} object.
#' @return (list) of the strata (factors) for the
#'     \code{\link{eq}}uations included in the \code{\link{eqs}}
#'     \code{x}.
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




#' @describeIn get_strata Extract and merge the levels for all the
#'     strata in any \code{\link{eq}}uations of the
#'     \code{\link{eqs_bag}} object.
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
#'     outcome = "kcal/day",
#'     strata = list(sex = "male", nyha = 1)
#' )
#' eq4_test <- eq(age = -0.1, bmi = 0.3,
#'     name    = "eq2_test",
#'     outcome = "kcal/day",
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
#' get_strata(eqs_bag1_test)
get_strata.eqs_bag <- function(x) {
    attr(x, "strata")
}
