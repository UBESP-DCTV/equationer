#' get reference
#'
#' Extract the equation(s) reference
#'
#' @param x (eqs) the object of class (\code{\link{eqs}})
#'
#' @return (chr) reference of the equations' set \code{x}
#' @export
get_reference <- function(x) {
    UseMethod("get_reference", x)
}


#' @describeIn get_strata Extract the strata of the given
#'     \code{eq}uation object.
#' @export
get_reference.default <- function(x) {
    ui_stop(
        "{ui_code('get_reference()')} works only on object of class {ui_value('eqs')})}"
    )
}

#' @describeIn get_strata Extract the strata of the given
#'     \code{eq}uation object.
#' @export
get_reference.eqs <- function(x) {
    attr(x, "reference")
}
