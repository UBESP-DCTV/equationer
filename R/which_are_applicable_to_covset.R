#' Find equations in eqs_bag for covariates
#'
#' Extract which of the given \code{\link{eqs}} set of
#' \code{\link{eq}}uation(s) (if any) can be applied to the supplied
#' set of covariates
#'
#' @param x (eqs_bag) object
#' @param cov (chr) vector of covariates
#'
#' @return (chr) names of all the \code{\link{eqs}} part of \code{x},
#'     for which the covariates supplied are a subset of the
#'     covariates needed to solve at least one of the equations into it.
#' @export
which_are_applicable_to_covset <- function(x, cov) {
    UseMethod("which_are_applicable_to_covset", x)
}


#' @describeIn which_are_applicable_to_covset Find which of the
#'     \code{\link{eqs}} set in the \code{\link{eqs_bag}} can be
#'     applied to the \code{cov}ariates supplied.
#' @export
which_are_applicable_to_covset.eqs_bag <- function(x, cov) {
    ok <- are_applicable_to_coveset(x, cov)
    names(ok)[ok]
}
