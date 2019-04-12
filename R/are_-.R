is_eq <- function(x) {
    inherits(x, "eq")
}

is_eqs <- function(x) {
    inherits(x, "eqs")
}

are_eq <- function(x) {
    if (rlang::is_null(x)) {
        return(FALSE)
    }

    purrr::map_lgl(x, is_eq)
}

are_eqs <- function(x) {
    if (rlang::is_null(x)) {
        return(FALSE)
    }

    purrr::map_lgl(x, is_eqs)
}


