#' Equation
#'
#' Costructor for object of class \code{\link{eq}} defined by its
#' (named) coefficients.
#'
#' @param ... sequence of named coefficients
#' @param name (chr) the name of the equation
#' @param outcome (chr) the outcome produced by the equation
#' @param stratum (chr, default = NA) if the equation is one of a set
#'        of equations defined each one for a level of a strata variable
#'        `stratum` is the name of the reference level for this equation
#'
#' @return an \code{\link{eq}} object
#' @export
#'
#' @examples
#' eq1 <- eq(sex = 2, age = 0.3, bmi = -0.21,
#'     name = "cl_test_1",
#'     outcome = "kcal/day"
#' )
eq <- function(..., name, outcome, stratum = NA_character_) {

    xs <- list(...)

    if (!rlang::is_named(xs)) {
        ui_stop("Not all variable names are valid or non empty names")
    }

    if (any(duplicated(names(xs)))) {
        ui_stop("Some names are duplicated.")
    }

    if (!is_string(name)) {
        ui_stop("{ui_code('eq_name')} must be a single string")
    }

    if (!is_string(outcome)) {
        ui_stop("{ui_code('outcome')} must be a single string")
    }

    if (!is_string(stratum)) {
        ui_stop("{ui_code('stratum')} must be a single string")
    }

    nxs <- names(xs)

    res <- list(eq = as.matrix(xs),
        eq_names   = name,
        outcome    = outcome,
        stratum    = stratum,
        covariates = nxs
    )

    structure(res, class = "eq")
}
