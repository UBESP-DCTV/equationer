activate_numeric_if_checked <- function(name, input, output, session) {
  observeEvent(input[[paste0(name, "_tick")]], {
    if (!input[[paste0(name, "_tick")]]) {
      # usethis::ui_todo("disabling numeric field {usethis::ui_field(name)}...")
      disable(name)
      updateNumericInput(session, name, value = numeric())
      usethis::ui_oops("field {usethis::ui_field(name)} disabled")
    } else {
      # usethis::ui_todo("enabling numeric field {usethis::ui_field(name)}...")
      enable(name)
      updateNumericInput(session, name, value = numeric())
      usethis::ui_done("field {usethis::ui_field(name)} enabled")
    }
  })
}


activate_selector_if_checked <- function(name, input, output, session) {
  observeEvent(input[[paste0(name, "_tick")]], {
    if (!input[[paste0(name, "_tick")]]) {
      usethis::ui_todo("disabling selector field {usethis::ui_field(name)}...")
      disable(name)
      updateSelectInput(session, name,
                        choices = list("not-selected"),
                        selected = "not-selected"
      )
      usethis::ui_oops("field {usethis::ui_field(name)} disabled")
    } else {
      usethis::ui_todo("enabling selector field {usethis::ui_field(name)}...")
      enable(name)
      if (name == "menopausal") {
        updateSelectInput(session, name,
                          choices = c(
                            "Pre-menopausal",
                            "Perimenopausal",
                            "Post-menopausal"
                          ),
                          selected = character()
        )
      } else {
        updateSelectInput(session, name,
                          choices = sort(get_strata(reer)[[name]]),
                          selected = input[[name]][1]
        )
      }
      usethis::ui_done("field {usethis::ui_field(name)} enabled")
    }
  })
}


activate_bool_if_checked <- function(name, input, output, session) {
  observeEvent(input[[paste0(name, "_tick")]], {
    if (!input[[paste0(name, "_tick")]]) {
      usethis::ui_todo("disabling boolean field {usethis::ui_field(name)}...")
      disable(name)
      updateSelectInput(session, name,
                        choices = list("not-selected"),
                        selected = "not-selected"
      )
      usethis::ui_oops("field {usethis::ui_field(name)} disabled")
    } else {
      usethis::ui_todo("enabling boolean field {usethis::ui_field(name)}...")
      enable(name)
      updateSelectInput(session, name,
                        choices = c("FALSE", "TRUE"),
                        selected = character()
      )
      usethis::ui_done("field {usethis::ui_field(name)} enabled")
    }
  })
}

