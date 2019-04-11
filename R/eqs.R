#' Multiple equation object
#'
#' Costructor for object of class \code{\link{eqs}} defined by its
#' \code{\link{eq}}s components.
#'
#' @param ... (eq, only) sequence of \code{\link{eq}}uations
#' @param name (chr) the name of the equations' set
#'
#' @return an \code{\link{eqs}} object
#' @export
#'
#' @examples
#' eq1 <- eq(age = 0.3, bmi = -0.5,
#'     name    = "cl_test_1",
#'     outcome = "kcal/day",
#'     strata  = list(sex = "male")
#' )
#' eq2 <- eq(age = 0.5, bmi = -0.3,
#'     name = "cl_test_2",
#'     outcome = "kcal/day",
#'     strata  = list(sex = "female")
#' )
#'
#' eqs1 <- eqs(eq1, eq2, name = "gendered-1")
#'
#'
#'
#' # works with multiple strata
#' eq4 <- eq(age = 0.3, bmi = -0.5,
#'     name = "cl_test_4",
#'     outcome = "kcal/day",
#'     strata = list(sex = "female", mellitus = 0)
#' )
#' eq5 <- eq(age = 0.5, bmi = -0.3,
#'     name = "cl_test_5",
#'     outcome = "kcal/day",
#'     strata = list(sex = "female", mellitus = 0)
#' )
#' eq6 <- eq(age = 0.3, bmi = -0.3,
#'     name = "cl_test_6",
#'     outcome = "kcal/day",
#'     strata = list(sex = "male", mellitus = 1)
#' )
#' eq7 <- eq(age = 0.5, bmi = -0.5,
#'     name = "cl_test_7",
#'     outcome = "kcal/day",
#'     strata = list(sex = "male", mellitus = 1)
#' )
#'
#' eqs2 <- eqs(eq4, eq5, eq6, eq7, name = "multistrata-1")
eqs <- function(..., name) {

    xs <- list(...)

    are_eq <- are_equations(xs)
    if (!all(are_eq)) {
        purrr::iwalk(are_eq, ~if (!.x) ui_fail(
            "object number {ui_field(.y)} is of class {ui_value(class(xs[[.y]]))}"
        ))
        ui_stop(
            "Not all supplied objects are of class {ui_code('eq')}",
        )
    }

    xs_names <- purrr::map_chr(xs, get_name)

    if (any(duplicated(xs_names))) {
        ui_stop("Some equations' names are duplicated.")
    }


    if (!is_string(name)) {
        ui_stop("{ui_code('eq_name')} must be a single string")
    }

    outcome <- purrr::map_chr(xs, get_outcome) %>%
        unique()

    strata_lst <- purrr::map(xs, get_strata) %>%
        purrr::flatten()

    strata_names <- names(strata_lst) %>%
        unique() %>%
        purrr::set_names()

    strata <- purrr::map(strata_names, ~{
        strata_lst[names(strata_lst) == .x] %>%
            unlist() %>%
            unname() %>%
            factor()
    })


    structure(purrr::set_names(xs, xs_names),
        name    = name,
        outcome = outcome,
        strata  = strata,
        class = "eqs"
    )
}
