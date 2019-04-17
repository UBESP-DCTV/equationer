#' Bag of multiple equation object
#'
#' Constructor for object of class \code{\link{eqs_bag}} defined as a
#' collection of many \code{\link{eqs}}(s).
#'
#' @param ... (\code{\link{eqs}}, only) sequence of \code{\link{eqs}}
#' @param name (chr) the name of the \code{\link{eqs}}(s)' bag
#' @param reference (chr, default NA) an optional reference for the
#'     bag of \code{\link{eqs}}(s) in the bag.
#' @param last_update (Date, dafault today) the date of the last bag
#'     update.
#'
#' @return an \code{\link{eqs_bag}} object
#' @export
#'
#' @examples
#'
#' eq1 <- eq(age = 0.3, bmi = -0.5,
#'     name    = "cl_test_1",
#'     outcome = "kcal/day",
#'     strata = list(sex = "male", nyha = 1)
#' )
#'
#' eq2 <- eq(age = 0.5, bmi = -0.3,              # change strata wrt eq1
#'     name = "cl_test_2",
#'     outcome = "kcal/day",
#'     strata = list(sex = "female", nyha = 1)
#' )
#'
#' eq3 <- eq(age = -0.3, bmi = 0.5,
#'     name    = "cl_test_3",
#'     outcome = "kcal/day",
#'     strata = list(sex = "male", nyha = 2)
#' )
#' eq4 <- eq(age = -0.5, bmi = 0.3,
#'     name = "cl_test_4",
#'     outcome = "kcal/day",
#'     strata = list(sex = "female", nyha = 2)
#' )
#'
#' eq9 <- eq(age = -0.1, weight = 0.2,              # change var, strata
#'     name = "cl_test_9",
#'     outcome = "kcal/month",
#'     strata = list(sex = "female")
#' )
#'
#' eq10 <- eq(age = -0.2, weight = 0.1,             # change var, strata
#'     name = "cl_test_10",
#'     outcome = "kcal/month",
#'     strata = list(sex = "male")
#' )
#'
#' eq11 <- eq(age = 0.1, weight = -0.2,             # change var, strata
#'     name = "cl_test_11",
#'     outcome = "kcal/day",
#'     strata = list(sex = "female")
#' )
#'
#' eq12 <- eq(age = 0.2, weight = -0.2,             # change var, strata
#'     name = "cl_test_12",
#'     outcome = "kcal/day",
#'     strata = list(sex = "male")
#' )
#'
#' eqs1 <- eqs(eq1, eq2, eq3, eq4,
#'     name = "eqs1",
#'     reference = "ref-a"
#' )
#'
#' eqs2 <- eqs(eq9, eq10, eq11, eq12,
#'     name = "eqs2",
#'     reference = "ref-b"
#' )
#'
#' eqs_bag_test <- eqs_bag(eqs1, eqs2,
#'     name = "overall-bag",
#'     reference = "equationer-test-bag"
#' )
eqs_bag <- function(...,
    name, reference = NA_character_, last_update = lubridate::today()
) {
    xs <- list(...)

    are_eqs <- are_eqs(xs)
    if (!all(are_eqs)) {
        purrr::iwalk(are_eqs, ~if (!.x) ui_fail(
            "object number {ui_field(.y)} is of class {ui_value(class(xs[[.y]]))}"
        ))
        ui_stop(
            "Not all supplied objects are of class {ui_code('eqs')}",
        )
    }

    xs_names <- purrr::map_chr(xs, get_name)

    if (any(duplicated(xs_names))) {
        ui_stop("Some eqs' names are duplicated.")
    }

    if (!is_string(name)) {
        ui_stop("{ui_code('name')} must be a single string")
    }

    if (!is_string(reference)) {
        ui_stop("{ui_code('name')} must be a single string")
    }

    if (!(length(last_update) == 1) || !lubridate::is.Date(last_update)) {
        ui_fail("{ui_field('last_update')} is of class {ui_code(class(last_update))}")
        ui_stop("{ui_code('last_update')} must be a single date")
    }


    strata_lst <- purrr::map(xs, get_strata) %>%
        purrr::flatten()

    strata_names <- if (length(strata_lst)) {
        names(strata_lst) %>%
            unique() %>%
            purrr::set_names()
    } else {
        c("a" = "a")[0]
    }

    strata <- purrr::map(strata_names, ~{
        strata_lst[names(strata_lst) == .x] %>%
            unlist() %>%
            unname() %>%
            unique() %>%
            levels() %>%
            readr::parse_guess(guess_integer = TRUE)
    })


    structure(purrr::set_names(xs, xs_names),

        covariates = unique(unlist(purrr::map(xs, get_covariates))),
        strata = strata,
        outcome = unique(unlist(purrr::map(xs, get_outcome))),

        name = name,
        reference = reference,
        last_update = last_update,

        class = "eqs_bag"
    )
}
