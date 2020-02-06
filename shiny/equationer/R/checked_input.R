checked_input <- function(id,
  type = c("num", "fct", "lgl"),
  udm = NULL,
  range = NULL,
  checked = FALSE
) {


# data check and prepare ------------------------------------------
  assertive::assert_is_a_string(id)
  type <- match.arg(type)

  label <- id %>%
    stringr::str_replace_all("[_-]+", " ") %>%
    stringr::str_to_title()

  if (!is.null(udm)) {
    assertive::assert_is_a_string(udm)
    label <- paste0(label, " (", udm, ")")
  }

  if (is.null(range)) {
    range <- c(NA_real_, NA_real_)
  } else {
    assertive::assert_is_numeric(range)
    assertive::assert_is_of_length(range, 2)
    assertive::assert_is_monotonic_increasing(range, strictly = TRUE)
  }

  assertive::assert_is_a_bool(checked)


# main body -------------------------------------------------------
  if (type == "num") {
    checked_num(id, label, numeric(), range, checked)
  } else if (type == "fct") {
    checked_fct(id, label, checked)
  } else if (type == "lgl") {
    checked_lgl(id, label, checked)
  }

}



checked_num <- function(id, label, value, range, checked) {
  tick_id <- paste0(id, "_tick")

  fluidRow(
    column(7, checkboxInput(tick_id, label, checked)),
    column(5, numericInput(id, "", value, range[[1]], range[[2]]))
  )
}


checked_fct <- function(id, label, checked) {
  tick_id <- paste0(id, "_tick")

  fluidRow(
    column(6, checkboxInput(tick_id, label, checked)),
    column(6, selectInput(id, "", get_strata(reer)[[id]]))
  )
}

checked_lgl <- function(id, label, checked) {
  tick_id <- paste0(id, "_tick")

  fluidRow(
    column(6, checkboxInput(tick_id, label, checked)),
    column(6, selectInput(id, "", c("FALSE", "TRUE")))
  )
}
