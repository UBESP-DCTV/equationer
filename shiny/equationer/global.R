library(dplyr)
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
            updateNumericInput(session, name, value = 0, min = 0)
        }
    })
}


activate_selector_if_checked <- function(name, input, output, session) {
    observeEvent(input[[paste0(name, "_tick")]], {
        if (!input[[paste0(name, "_tick")]]) {
            disable(name)
            updateSelectInput(session, name, selected = input[[name]][0])
        } else {
            enable(name)
            updateSelectInput(session, name, selected = input[[name]][1])
        }
    })
}
