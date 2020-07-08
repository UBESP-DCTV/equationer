fun_median <- function(x){
  tibble(
    y = median(x, na.rm = TRUE),
    label = glue::glue("median = {y}")
  )
}

fun_min <- function(x){
  tibble(
    y = min(x, na.rm = TRUE),
    label = glue::glue("min = {y}")
  )
}

fun_max <- function(x){
  tibble(
    y = max(x, na.rm = TRUE),
    label = glue::glue("max = {y}")
  )
}
