library(tidyverse)
library(shinyjs)
library(shinyBS)
library(DT)
library(equationer)
data("reer")



activate_numeric_if_checked <- function(name, input, output, session) {
    observeEvent(input[[paste0(name, "_tick")]], {
        if (!input[[paste0(name, "_tick")]]) {
            # ui_todo("disabling numeric field {ui_field(name)}...")
            disable(name)
            updateNumericInput(session, name, value = numeric())
            ui_oops("field {ui_field(name)} disabled")
        } else {
            # ui_todo("enabling numeric field {ui_field(name)}...")
            enable(name)
            updateNumericInput(session, name, value = numeric())
            ui_done("field {ui_field(name)} enabled")
        }
    })
}


activate_selector_if_checked <- function(name, input, output, session) {
    observeEvent(input[[paste0(name, "_tick")]], {
        if (!input[[paste0(name, "_tick")]]) {
            ui_todo("disabling selector field {ui_field(name)}...")
            disable(name)
            updateSelectInput(session, name,
                choices = list("not-selected"),
                selected = "not-selected"
            )
            ui_oops("field {ui_field(name)} disabled")
        } else {
            ui_todo("enabling selector field {ui_field(name)}...")
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
            ui_done("field {ui_field(name)} enabled")
        }
    })
}


activate_bool_if_checked <- function(name, input, output, session) {
    observeEvent(input[[paste0(name, "_tick")]], {
        if (!input[[paste0(name, "_tick")]]) {
            ui_todo("disabling boolean field {ui_field(name)}...")
            disable(name)
            updateSelectInput(session, name,
                choices = list("not-selected"),
                selected = "not-selected"
            )
            ui_oops("field {ui_field(name)} disabled")
        } else {
            ui_todo("enabling boolean field {ui_field(name)}...")
            enable(name)
            updateSelectInput(session, name,
                choices = c("FALSE", "TRUE"),
                selected = character()
            )
            ui_done("field {ui_field(name)} enabled")
        }
    })
}
