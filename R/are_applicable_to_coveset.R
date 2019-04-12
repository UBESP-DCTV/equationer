#' Vectorized check equation for covariates
#'
#' check which of the given \code{\link{eqs}} set of
#' \code{\link{eq}}uation(s) (if any) can be applied to the supplied
#' set of covariates
#'
#' @param x (eqs_bag) object
#' @param cov (chr) vector of covariates
#'
#' @return (lgl) for all the \code{\link{eqs}} part of \code{x},
#'     TRUE if the covariates supplied are a subset of the
#'     covariates needed to solve at least one of the equations in
#'     \code{x}.
#' @export
are_applicable_to_coveset <- function(x, cov) {
    UseMethod("are_applicable_to_coveset", x)
}


#' @describeIn are_applicable_to_coveset Check which of the
#'     \code{\link{eqs}} set in the \code{\link{eqs_bag}} can be
#'     applied to the \code{cov}ariates supplied.
#' @export
are_applicable_to_coveset.eqs_bag <- function(x, cov) {
    purrr::map_lgl(x, is_applicable_to_covset, cov = cov)
}
