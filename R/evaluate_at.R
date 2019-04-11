#' Evaluate equation
#'
#' Evaluate (i.e., solve for the outcome) the supplied equation at the
#' supplied values of the covariates
#'
#' @param x equation(s set/bag) object
#' @param ... sequence of named coefficients's values
#'
#' @return a one row [tibble][tibble::tibble-package] with one column
#'     each covariate supplied, one column for possible strata
#'     considered, one column with the outcome, one column with
#'     the value of the outcome that solve the equation when
#'     its the covariates assume the values supplied, and one last
#'     column wiht the name of the eqaution used
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
#' eq2_test <- eq(age = 0.1, bmi = -0.3,
#'     name    = "first eq_test",
#'     outcome = "out",
#'     strata = list(sex = "female")
#' )
#'
#' evaluate_at(eq_test, age = 38, bmi = 18)
#' evaluate_at(eq_test, age = 38, sex = 1, bmi = 18)
#' evaluate_at(eq2_test, age = 38, bmi = 18)
#'
#' \dontrun{
#'     # ERRORS
#'     evaluate_at(eq_test, age = 38, bmi = 18, sex = "female")
#'     evaluate_at(eq_test, age = 38)
#' }
evaluate_at.eq <- function(x, ...) {

    vs <- list(...)

    if (!rlang::is_named(vs)) {
        ui_stop("Not all variable names are valid or non empty names")
    }

    if (any(duplicated(names(vs)))) {
        ui_stop("Some variable names are duplicated.")
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
            "Not all equation's covariates are included in the set supplied.",
            ui_fail("Covariate(s) missing: {ui_value(missing_covs)}")
        ))
    }

    res <- unlist(vs[eq_cov]) %*% x %>%
        drop() %>%
        purrr::set_names(get_outcome(x))

    dplyr::as_tibble(c(
        vs,
        get_strata(x),
        list(
            outcome = get_outcome(x),
            estimation = res,
            eq_name = get_name(x)
        )
    ))
}







#' @describeIn evaluate_at Evaluate (i.e., solve for the outcome)
#'     all the \code{\link{eq}}uations in the \code{\link{eqs}} object
#'     at the supplied values of the covariates.
#'
#' @param .outcome (chr, default NULL) an optional declaration of which
#'     outcome(s) the computation has to consider
#' @export
#'
#' @examples
#' library(equationer)
#' eq_test <- eq(age = 0.5, bmi = -0.3,
#'     name    = "eq_test",
#'     outcome = "kcal/day",
#'     strata = list(sex = "female")
#' )
#' eq2_test <- eq(age = 0.3, bmi = -0.5,
#'     name    = "eq2_test",
#'     outcome = "kcal/day",
#'     strata = list(sex = "male")
#' )
#'
#' eqs_test <- eqs(eq_test, eq2_test, name = "eqs-test")
#'
#' evaluate_at(eqs_test, age = 38, bmi = 18, sex = "female")
#' evaluate_at(eqs_test, age = 38, bmi = 18, sex = "male")
#'
#' \dontrun{
#'     # ERRORS
#'     evaluate_at(eq_test, age = 38, bmi = 18, mellitus = "yes"))
#'     evaluate_at(eqs_test, age = 38, bmi = 18, sex = "unknown")
#'     evaluate_at(eq_test, age = 38)
#' }
evaluate_at.eqs <- function(x, ..., .outcome = NULL) {
    vs <- list(...)

    if (!rlang::is_named(vs)) {
        ui_stop("Not all variable/strata names are valid or non empty names.")
    }

    vs_names <- names(vs)
    if (any(duplicated(vs_names))) {
        ui_stop("Some variable/strata names are duplicated.")
    }

    x_strata <- get_strata(x)
    x_strata_names <- names(x_strata)

    # are_strata_supplied <- x_strata_names %in% vs_names
    # strata_supplied <- x_strata[are_strata_supplied]
    # strata_not_supplied <- x_strata[!are_strata_supplied]

    vs_strata_values <- vs[vs_names %in% x_strata_names]
    are_values_in_levels <- purrr::imap_lgl(vs_strata_values, ~{
        .x %in% levels(x_strata[[.y]])
    })
    if (!all(are_values_in_levels)) {
        purrr::iwalk(vs_strata_values[!are_values_in_levels], ~{
            ui_fail("Values {ui_value(.x)} is not present in the {ui_field(.y)}'s strata possible levels.")
            ui_todo("Possible values for {ui_field(.y)} are: {ui_value(levels(x_strata[[.y]]))}.")
        })
            ui_warn("Some strata's levels requested are not included in the equations in {ui_field(get_name(x))}. They won't be evaluated.")
    }

    .outcome <- .outcome %||% get_outcome(x)

    are_possible_outcome <- .outcome %in% get_outcome(x)

    if (!all(are_possible_outcome)) {
        purrr::walk(.outcome[!are_possible_outcome], ~{
            ui_fail("Outcome {ui_value(.x)} is not present in the equations {ui_field(get_name(x))}")
            ui_todo("Possible outcomes are: {ui_value(unique(get_outcome(x)))}.")
        })
        ui_warn("Only equations with possible outcome (if any) will be considered.")
    }

    strata_df <- c(
            id = list(seq_along(x)),
            x_strata,
            outcome = list(get_outcome(x))
        ) %>%
        dplyr::as_tibble() %>%
        dplyr::filter(!!rlang::sym("outcome") %in% .outcome)

    purrr::iwalk(vs_strata_values, ~{
        strata_name <- sym(.y)

        strata_df <<- strata_df %>%
            dplyr::filter(!!strata_name == .x)
    })

    equation_to_use <- strata_df[["id"]]

    vs_covs_values <- vs[!vs_names %in% x_strata_names]

    res <- purrr::map_df(equation_to_use,
        ~do.call(evaluate_at, c(list(x = x[[.x]]), vs_covs_values))
    )

    if (!nrow(res)) {
        res <- dplyr::as_tibble(
            c(
                purrr::map(vs_covs_values, ~.x[0]),
                purrr::map(x_strata, ~.x[0]),
                list(
                    outcome = character(),
                    estimation = numeric(),
                    eq_name = character()
                )
            ),
            .rows = 0
        )
    }

    res <- dplyr::mutate_at(res, x_strata_names, as.factor)

    dplyr::as_tibble(c(
        res,
        list(
            eq_group = get_name(x),
            reference = get_reference(x)
        )
    ))

}

