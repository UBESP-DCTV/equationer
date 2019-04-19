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
    eq_cov <- get_covariates(x)

    vs <- vs[names(vs) %in% eq_cov]

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

    vs[["intercept"]] <- 1L

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

    res <- dplyr::as_tibble(c(
        vs,
        get_strata(x),
        list(
            outcome = get_outcome(x),
            estimation = res,
            eq_name = get_name(x)
        )
    ))

    res[["intercept"]] <- NULL # not select in case it not exists
    res
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

    vs[["intercept"]] <- 1L
    vs_names <- names(vs)
    if (any(duplicated(vs_names))) {
        ui_stop("Some variable/strata names are duplicated.")
    }

    x_strata <- get_strata(x)
    x_strata_names <- names(x_strata)


    vs_strata_values <- vs[vs_names %in% x_strata_names]
    are_values_in_levels <- purrr::imap_lgl(vs_strata_values, ~{
        .x %in% levels(x_strata[[.y]])
    })
    if (!all(are_values_in_levels)) {
        ui_warn("Some strata's levels requested are not included in the equations in {ui_field(get_name(x))}. They won't be evaluated.")
        purrr::iwalk(vs_strata_values[!are_values_in_levels], ~{
            ui_fail("Values {ui_value(.x)} is not present in the {ui_field(.y)}'s strata possible levels.")
            ui_todo("Possible values for {ui_field(.y)} are: {ui_value(levels(x_strata[[.y]]))}.")
        })
    }

    .outcome <- .outcome %||% get_outcome(x)

    are_possible_outcome <- .outcome %in% get_outcome(x)

    if (!all(are_possible_outcome)) {
        ui_warn("Only equations with possible outcome (if any) will be considered for {ui_value(get_name(x))}.")
        purrr::walk(.outcome[!are_possible_outcome], ~{
            ui_fail("Outcome {ui_value(.x)} is not present in the equations {ui_field(get_name(x))}")
            ui_todo("Possible outcomes are: {ui_value(unique(get_outcome(x)))}.")
        })
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

    res <- dplyr::as_tibble(c(
        res,
        list(
            eq_group = get_name(x),
            reference = get_reference(x)
        )
    ))
    res[["intercept"]] <- NULL
    res

}









#' @describeIn evaluate_at Evaluate (i.e., solve for the outcome)
#'     all the \code{\link{eq}}uations in all the possible
#'     \code{\link{eqs}} at the supplied values of the covariates.
#'
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
#' eq2 <- eq(age = 0.5, bmi = -0.3,                 # change strata wrt eq1
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
#' eq9 <- eq(age = -0.1, weight = 0.2,                # change var, strata
#'     name = "cl_test_9",
#'     outcome = "kcal/month",
#'     strata = list(sex = "female")
#' )
#'
#' eq10 <- eq(age = -0.2, weight = 0.1,                # change var, strata
#'     name = "cl_test_10",
#'     outcome = "kcal/month",
#'     strata = list(sex = "male")
#' )
#'
#' eq11 <- eq(age = 0.1, weight = -0.2,                # change var, strata
#'     name = "cl_test_11",
#'     outcome = "kcal/day",
#'     strata = list(sex = "female")
#' )
#'
#' eq12 <- eq(age = 0.2, weight = -0.2,                # change var, strata
#'     name = "cl_test_12",
#'     outcome = "kcal/day",
#'     strata = list(sex = "male")
#' )
#'
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
#'
#' eqs_bag_test <- eqs_bag(eqs1, eqs2,
#'     name = "overall-bag",
#'     reference = "equationer-test-bag"
#' )
#'
#'
#' evaluate_at(eqs_bag_test, age = 35)
#' evaluate_at(eqs_bag_test, age = 35, bmi = 18)
#' evaluate_at(eqs_bag_test, age = 35, bmi = 18, weight = 81)
#' evaluate_at(eqs_bag_test, age = 35, bmi = 18, sex = "female")
#' evaluate_at(eqs_bag_test, age = 35, bmi = 18, weight = 81, sex = "female")
#' evaluate_at(eqs_bag_test, age = 35, bmi = 18, weight = 81, nyha = 1)
#' evaluate_at(eqs_bag_test, age = 35, bmi = 18, weight = 81, .outcome = "kcal/day")
#' evaluate_at(eqs_bag_test, age = 35, bmi = 18, weight = 81, sex = "female", .outcome = "kcal/day")
#'
#' one_patient <- dplyr::tribble(
#'     ~id, ~age, ~bmi, ~weight,     ~sex,
#'       1,   35,   18,      81,  "female"
#' )
#'
#' more_patients <- dplyr::tribble(
#'     ~id, ~age, ~bmi, ~weight,     ~sex,
#'       1,   35,   18,      81,  "female",
#'       2,   27,   20,      93,    "male"
#' )
#'
#' evaluate_at(eqs_bag_test, one_patient)
#' evaluate_at(eqs_bag_test, more_patients)
evaluate_at.eqs_bag <- function(x, ..., .outcome = NULL) {
    vs <- list(...)

    if (length(vs) == 1) {

        single_vs <- vs[[1]]

        if (inherits(single_vs, "data.frame") && nrow(single_vs) < 2) {
            var_lst <- as.list(single_vs)
            res <- do.call(evaluate_at,
                c(var_lst, list(x = x, .outcome = .outcome))
            )
            return(res)
        }

        if (inherits(single_vs, "data.frame")) {
            res_dfs <- purrr::map(seq_len(nrow(single_vs)), ~{
                evaluate_at(
                    x = x,
                    single_vs[.x, , drop = FALSE],
                    .outcome = .outcome
                ) %>%
                    dplyr::mutate(.source_row = .x)
            })
            res <- suppressMessages(
                purrr::reduce(res_dfs, dplyr::full_join)
            )
            return(res)
        }
    }



    if (!rlang::is_named(vs)) {
        ui_stop("Not all variable/strata names are valid or non empty names.")
    }

    vs[["intercept"]] <- 1L
    vs_names <- names(vs)
    if (any(duplicated(vs_names))) {
        ui_stop("Some variable/strata names are duplicated.")
    }

    x_strata <- get_strata(x)
    x_strata_names <- names(x_strata)

    vs_strata_values <- vs[vs_names %in% x_strata_names]

    are_values_in_levels <- purrr::imap_lgl(vs_strata_values, ~{
        .x %in% x_strata[[.y]]
    })

    if (!all(are_values_in_levels)) {
        missing_strata <- vs_strata_values[!are_values_in_levels]
        ui_warn("Some strata's levels requested are not included in the equations in {ui_field(get_name(x))}.\n Only equation without {ui_field(names(missing_strata))} strata will be evaluated.")
        purrr::iwalk(missing_strata, ~{
            ui_fail("Values {ui_value(.x)} is not present in the levels of {ui_field(.y)} for equations in {ui_value(get_name(x))}.")
            ui_todo("Possible values for {ui_field(.y)} are: {ui_value(x_strata[[.y]])}.")
        })
    }

    .outcome <- .outcome %||% get_outcome(x)
    are_possible_outcome <- .outcome %in% get_outcome(x)

    if (!all(are_possible_outcome)) {
        ui_warn("(Some) outcome requested is not evaluated using equations in {ui_value(get_name(x))}. They will be excluded")
        purrr::walk(.outcome[!are_possible_outcome], ~{
            ui_fail("Outcome {ui_value(.x)} is not present in the equations of the group {ui_field(get_name(x))}")
            ui_todo("Possible outcomes for {ui_field(get_name(x))} are: {ui_value(unique(get_outcome(x)))}.")
        })
    }

    vs_covs_values <- vs[!vs_names %in% x_strata_names]
    vs_covs_names  <- names(vs_covs_values)

    vs_strata_values <- vs_strata_values[are_values_in_levels]

    .outcome <- .outcome[are_possible_outcome]

    eqs_to_consider <- which_are_applicable_to_covset(x, vs_covs_names)

    if (!length(eqs_to_consider)) {
        res <- dplyr::as_tibble(
            c(
                purrr::map(vs_covs_values, ~.x[0]),
                purrr::map(x_strata, ~.x[0]),
                list(
                    outcome = character(),
                    estimation = numeric(),
                    eq_name = character(),
                    eq_group = character(),
                    reference = character()
                )
            ),
            .rows = 0
        )
        res[["intercept"]] <- NULL
        return(res)
    }

    reduced_bag <- do.call(eqs_bag,
        c(
            x[eqs_to_consider],
            list(
                name = get_name(x),
                reference = get_reference(x),
                last_update = get_last_update(x)
            )
        )
    )

    res_lst <- purrr::map(reduced_bag,
        ~do.call(evaluate_at, c(
            vs_covs_values,
            vs_strata_values,
            list(
                x = .x,
                .outcome = .outcome
            )
        ))
    )

    if (length(res_lst) == 1) {
        res_lst[[1]][["intercept"]] <- NULL
        return(res_lst[[1]])
    }

    suppressMessages(
        res <- purrr::reduce(res_lst, dplyr::full_join)
    )
    res[["intercept"]] <- NULL
    res
}

