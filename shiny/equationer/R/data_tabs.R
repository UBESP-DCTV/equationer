anthropometric_tab <- function() {
  tabPanel(strong("Anthropometric"), icon = icon("file-medical"), flowLayout(
    checked_input("age", "num", "years", c(18, 122)),
    checked_input("sex", "fct"),
    checked_input("race", "fct"),
    checked_input("ethnicity", "fct"),
    checked_input("meal", "fct"),
    checked_input("smoke", "lgl"),
    fluidRow(
      column(
        12,
        checkboxInput("menopausal_tick", "Menopausal stage", FALSE),
        bsTooltip(
          id = "menopausal_tick", title = "Perimenopausal: vasomotor instability, hot flashes, absence of regular menstruation for 2-12 month; Post-menopausal: absence of menstruation > 12 month.",
          placement = "right", trigger = "hover"
        )
      ),
      column(12, selectInput("menopausal", "", c("Pre-menopausal", "Perimenopausal", "Post-menopausal")))
    )
  ))
}




measurements_tab <- function() {
  tabPanel(strong("Measurements"), icon = icon("file-medical"), flowLayout(
    checked_input("weight", "num", "kg", c(27, 635)),
    checked_input("height", "num", "cm", c(62.8, 272)),
    checked_input("hip_circumference", "num", "cm"),
    checked_input("abdomen_circ", "num", "cm"),
    checked_input("wrist_circumference", "num", "cm"),
    checked_input("arm_span", "num", "cm"),
    checked_input("mean_chest_skinfold", "num", "cm"),
    checked_input("midarm_circumference", "num", "cm"),
    checked_input("subscapular_skinfold", "num", "cm"),
    checked_input("body_surface_area", "num", "cm^2")
  ))
}




conditions_tab <- function() {
  tabPanel(strong("Conditions"), icon = icon("file-medical"), flowLayout(
    checked_input("diabetic", "lgl"),
    checked_input("hf", "lgl", "NHYA >= III"),
    checked_input("inpatients", "lgl"),
    checked_input("rheumatoid_arthritis", "lgl"),
    checked_input("copd", "lgl", "Chronic Obstructive Pulmonary Disease")
  ))
}




lab_tests_tab <- function() {
  tabPanel(strong("Lab tests"), icon = icon("file-medical"), flowLayout(
    checked_input("albumin_mg_dl", "num", "mg/dl"),
    checked_input("glucose_g_dl", "num", "g/dl"),
    checked_input("fasting_plasma_glucose", "num", "mg/dl"),
    checked_input("crp_mg_l", "num", "mg/l")
  ))
}




physical_activity_tab <- function() {
  tabPanel(strong("Physical activity"), icon = icon("file-medical"), flowLayout(
    checked_input("pal", "fct", "Physical Activity Level"),
    checked_input("activity_intensity", "fct"),
    checked_input("athletic", "lgl"),
    fluidRow(
      column(
        7,
        checkboxInput("lta_tick", "Leasure Time Activity (LTA, kcal/day)", FALSE),
        bsTooltip(
          id = "lta_tick", title = "To compute LTA see: Taylor HL, Jacobs DR Jr. Schucker B. et al: A questionnaire for the assessment of leisure time physical activities. J Chronic Dis",
          placement = "right", trigger = "hover"
        )
      ),
      column(5, numericInput("lta", "", numeric(), 0))
    )
  ))
}





environment_tab <- function() {
  tabPanel(strong("Environment"), icon = icon("file-medical"), flowLayout(
    checked_input("air_humidity", "num", "%"),
    checked_input("air_temperature", "num", "C", c(-257.15, 257.15)),
    checked_input("hour", "num", "HH", c(0, 24))
  ))
}




vital_parameters_tab <- function() {
  tabPanel(strong("Vital parameters"), icon = icon("file-medical"), flowLayout(
    checked_input("blood_pressure_gradient", "num", "mmHg"),
    checked_input("pulse", "num", "bpm", c(0, 300)),
    checked_input("body_temperature", "num", "C", c(0, 100))
  ))
}




outcomes_tab <- function() {
  tabPanel(strong("Outcome of interest"), icon = icon("bullseye"), verticalLayout(
    fluidRow(
      column(3, checkboxInput("beebmr_tick", "BEE/BMR: Basal Energy Expenditure / Metabolic Rate (kcal/day)", TRUE)),
      column(3, checkboxInput("reermr_tick", "REE/RMR: Resting Energy Expenditure / Metabolic Rate (kcal/day)", TRUE)),
      column(3, checkboxInput("eeeeer_tick", "EEE/EER: Estimated Energy Expenditure/Requirement (kcal/day)", TRUE))
    )
  ))
}
