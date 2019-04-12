#' get the last update data
#'
#' Extract the last \code{\link{eqs_bag}} date
#'
#' @param x (eqs_bag) the object of class (\code{\link{eqs_bag}})
#'
#' @return (date) last update date
#' @export
get_last_update <- function(x) {
    UseMethod("get_last_update", x)
}

#' @describeIn get_last_update don't work for object different from
#'     \code{\link{eqs_bag}}.
#' @export
get_last_update.default <- function(x) {
    ui_stop(
        "{ui_code('get_last_update()')} works only on object of class {ui_value('eqs_bag')}."
    )
}

#' @describeIn get_strata Extract the last date in which
#'     \code{\link{eqs_bag}} has been updated.
#' @export
get_last_update.eqs_bag <- function(x) {
    attr(x, "last_update")
}
