#' get covariates
#'
#' Extract the equation(s) covariates
#'
#' @param x the object
#'
#' @return (chr) covariates of the equation \code{x}
#' @export
get_covariates <- function(x) {
    UseMethod("get_covariates", x)
}

#' @describeIn get_covariates Extract the covariates of the given
#'     \code{eq}uation object.
#' @export
#'
#' @examples
#' library(equationer)
#' eq_test <- eq(age = 0.1, bmi = -0.3,
#'     name    = "first eq_test",
#'     outcome = "kcal/day",
#'     strata = list(sex = "female")
#' )
#' get_covariates(eq_test)
get_covariates.eq <- function(x) {
    attr(x, "covariates")
}



#' @describeIn get_covariates Extract the covariates of the given
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
#' eq2_test <- eq(age = 0.1, bmi = -0.3,
#'     name    = "eq2_test",
#'     outcome = "kcal/day",
#'     strata = list(sex = "male")
#' )
#'
#' eqs_test <- eqs(eq_test, eq2_test, name = "eqs-test")
#' get_covariates(eqs_test)
get_covariates.eqs <- function(x) {
    attr(x, "covariates")
}
