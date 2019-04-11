#' Evaluate equation
#'
#' Evaluate (i.e., solve for the outcome) the supplied equation at the
#' supplied values of the covariates
#'
#' @param x equation(s set/bag) object
#' @param ... sequence of named coefficients's values
#'
#' @return (named dbl) the value of the outcome that solve the equation when
#'     its the covariates assume the values supplied
#' @export
evaluate_at <- function(x, ...) {
    UseMethod("evaluate_at", x)
}

#' @describeIn evaluate_at Evaluate (i.e., solve for the outcome) the
#'     supplied equation at the supplied values of the covariates.
#' @export
#'
#' @examples
#' library(equationer)
#' eq_test <- eq(age = 0.1, bmi = -0.3,
#'     name    = "first eq_test",
#'     outcome = "out"
#' )
#'
#' evaluate_at(eq_test, age = 38, bmi = 18) # c(out = -1.6)
#' evaluate_at(eq_test, age = 38, sex = 1, bmi = 18) # c(out = -1.6)
#'
#' \dontrun{
#'     # ERRORS
#'     evaluate_at(eq_test, age = 38, bmi = 18, sex = "female"))
#'     evaluate_at(eq_test, age = 38)
#' }
evaluate_at.eq <- function(x, ...) {

    vs <- list(...)

    if (!rlang::is_named(vs)) {
        ui_stop("Not all variable names are valid or non empty names")
    }

    if (any(duplicated(names(vs)))) {
        ui_stop("Some variables' names are duplicated.")
    }

    are_cov_num <- purrr::map_lgl(vs, is.numeric)
    if (!all(are_cov_num)) {
        not_num <- vs[!are_cov_num]
        ui_stop(c(
            "All covariates values must be numeric.",
            ui_fail("Not numeric values: {ui_value(not_num)}")
        ))
    }

    eq_cov <- get_covariates(x)
    cov_val_name <- names(vs)

    if (!is_applicable_to_covset(x, cov_val_name)) {
        missing_covs <- eq_cov %>%
            setdiff(cov_val_name)

        ui_stop(c(
            "Not all equation's covariates included in the set of value in {ui_field('cov_value')}.",
            ui_fail("Covariate(s) missing: {ui_value(missing_covs)}")
        ))
    }

    unlist(vs[eq_cov]) %*% x %>%
        drop() %>%
        purrr::set_names(get_outcome(x))
}
