library(tidyverse)
library(shinyjs)
library(shinyBS)
library(DT)
library(equationer)
data("reer")



activate_numeric_if_checked <- function(name, input, output, session) {
    observeEvent(input[[paste0(name, "_tick")]], {
        if (!input[[paste0(name, "_tick")]]) {
            disable(name)
            updateNumericInput(session, name, value = numeric())
        } else {
            enable(name)
            updateNumericInput(session, name, value = numeric())
        }
    })
}


activate_selector_if_checked <- function(name, input, output, session) {
    observeEvent(input[[paste0(name, "_tick")]], {
        if (!input[[paste0(name, "_tick")]]) {
            disable(name)
            updateSelectInput(session, name, choices = "not-selected", selected = "not-selected")
        } else {
            enable(name)
            if (name == "menopausal") {
                updateSelectInput(session, name, choices = c("Pre-menopausal", "Perimenopausal", "Post-menopausal"), selected = character())
            } else {
                updateSelectInput(session, name, choices = sort(get_strata(reer)[[name]]), selected = input[[name]][1])
            }
        }
    })
}


activate_bool_if_checked <- function(name, input, output, session) {
    observeEvent(input[[paste0(name, "_tick")]], {
        if (!input[[paste0(name, "_tick")]]) {
            disable(name)
            updateSelectInput(session, name, choices = "not-selected", selected = "not-selected")
        } else {
            enable(name)
            updateSelectInput(session, name, choices = c("FALSE", "TRUE"), selected = character())
        }
    })
}
