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
    attr(x, "eq_name")
}


#' @describeIn get_name Extract the name of the given
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
#' get_name(eqs_test)
get_name.eqs <- function(x) {
    attr(x, "name")
}


#' @describeIn get_name Extract the name of the given
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
#' get_name(eqs_bag1_test)
get_name.eqs_bag <- function(x) {
    attr(x, "name")
}
