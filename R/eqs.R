#' Multiple equation object
#'
#' Constructor for object of class \code{\link{eqs}} defined by its
#' \code{\link{eq}}s components.
#'
#' @details All the \code{\link{eq}}uations included in the
#'     \code{\link{eqs}} object must share the same covariates and
#'     the same strata (with different combinations!)
#'
#' @param ... (eq, only) sequence of \code{\link{eq}}uations
#' @param name (chr) the name of the equations' set
#' @param reference (chr, default NA) an optional reference for the
#'     set of the equations in the bag.
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
#'     strata = list(sex = "male", mellitus = 0)
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
#'     strata = list(sex = "female", mellitus = 1)
#' )
#'
#' eqs2 <- eqs(eq4, eq5, eq6, eq7, name = "multistrata-1")
eqs <- function(..., name, reference = NA_character_) {

    xs <- list(...)

    are_eq <- are_eq(xs)
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
        ui_stop("In {ui_code(name)}, some equations' names are duplicated.")
    }


    if (!is_string(name)) {
        ui_stop("{ui_code('name')} must be a single string")
    }

    if (!is_string(reference)) {
        ui_stop("In {ui_code(name)}, {ui_code('reference')} must be a single string")
    }

    strata_lst <- purrr::map(xs, get_strata)

    strata_vars <- purrr::map(strata_lst, names)
    if (any(
        purrr::map_lgl(seq_len(length(strata_vars) - 1),
            ~!setequal(strata_vars[[.x]], strata_vars[[.x + 1]])
        )
    )) {
        ui_stop("In {ui_code(name)} all the equations must share the same set of strata, and they don't!")
    }

    outcome <- purrr::map_chr(xs, get_outcome)
    strata_lst <- purrr::flatten(strata_lst)

    if (is.null(names(strata_lst))) {
        strata <- list()
    } else {
        strata_names <- names(strata_lst) %>%
            unique() %>%
            purrr::set_names()

        strata <- purrr::map(strata_names, ~{
            strata_lst[names(strata_lst) == .x] %>%
                unlist() %>%
                unname() %>%
                factor()
        })

        strata_df <- dplyr::as_tibble(c(strata, outcome = list(outcome))) %>%
            dplyr::distinct()

        if (nrow(strata_df) < length(strata[[1]])) {
            ui_stop(
                "In {ui_code(name)} the equations cannot share same combination of strata and outcome"
            )
        }
    }

    covariates <- purrr::map(xs, get_covariates)
    if (any(
        purrr::map_lgl(seq_len(length(covariates) - 1),
            ~!setequal(covariates[[.x]], covariates[[.x + 1]])
        )
    )) {
        ui_stop("In {ui_code(name)} all the equations must have the same set of covariates")
    }



    structure(purrr::set_names(xs, xs_names),

        covariates = covariates[[1]],
        strata = strata,
        outcome = outcome,

        name = name,
        reference = reference,

        class = "eqs"
    )
}
