#' Check equation for covariates
#'
#' Check if any of the given equation(s) can be applied to the supplied
#' set of covariates
#'
#' @param x equation(s set/bag) object
#' @param cov (chr) vector of covariates
#'
#' @return (lgl) TRUE if the covariates supplied are a subset of the
#'     covariates needed to solve at least one of the equations in
#'     \code{x}.
#' @export
is_applicable_to_covset <- function(x, cov) {
    UseMethod("is_applicable_to_covset", x)
}

#' @describeIn is_applicable_to_covset Check if the \code{eq}uation can
#'     be applied to the \code{cov}ariates supplied.
#' @export
#'
#' @examples
#' library(equationer)
#' eq_test <- eq(age = 0.1, bmi = -0.3,
#'     name    = "first eq_test",
#'     outcome = "kcal/day"
#' )
#' is_applicable_to_covset(eq_test, c("age", "bmi")) # TRUE
#' is_applicable_to_covset(eq_test, c("age", "bmi", "sex")) # TRUE
#' is_applicable_to_covset(eq_test, c("age")) # FALSE
#' is_applicable_to_covset(eq_test, c("age", "sex")) # FALSE
is_applicable_to_covset.eq <- function(x, cov) {
    get_covariates(x) %>%
        purrr::map_lgl(
            ~any(stringr::str_detect(.x, pattern = cov))
        ) %>%
        all()
}



#' @describeIn is_applicable_to_covset Check if (all) the
#'     \code{\link{eq}}uations in the \code{\link{eqs}} object can be
#'     applied to the \code{cov}ariates supplied.
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
#'
#' is_applicable_to_covset(eqs_test, c("age", "bmi")) # TRUE
#' is_applicable_to_covset(eqs_test, c("age", "bmi", "sex")) # TRUE
#' is_applicable_to_covset(eqs_test, c("age")) # FALSE
#' is_applicable_to_covset(eqs_test, c("age", "sex")) # FALSE
is_applicable_to_covset.eqs <- function(x, cov) {
    get_covariates(x) %>%
        purrr::map_lgl(
            ~any(stringr::str_detect(.x, pattern = cov))
        ) %>%
        all()
}
