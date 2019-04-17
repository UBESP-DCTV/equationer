shinyUI(fluidPage(
    # Use shiny js to disable fields
    useShinyjs(),
    title = "equationer",
    titlePanel("Equations of Energy Requirements"),


    # Sidebar with a slider input for number of bins
    sidebarLayout(
        sidebarPanel(

                    strong("COVARIATES"),

            fluidRow(
                column(4, checkboxInput("adjusted_weight_tick", "Adjusted weight (Kg)", FALSE)),
                column(8, numericInput("adjusted_weight", "", 0, 0))
            ),
            fluidRow(
                column(4, checkboxInput("age_tick", "Age (years)", FALSE)),
                column(8, numericInput("age", "", 0, 0))
            ),
            fluidRow(
                column(4, checkboxInput("air_humidity_tick", "Air humidity", FALSE)),
                column(8, numericInput("air_humidity", "", 0, 0))
            ),
            fluidRow(
                column(4, checkboxInput("air_temperature_tick", "Air temperature (C)", FALSE)),
                column(8, numericInput("air_temperature", "", 0, 0))
            ),
            fluidRow(
                column(4, checkboxInput("albumin_mg_dl_tick", "Albumin (mg/dl)", FALSE)),
                column(8, numericInput("albumin_mg_dl", "", 0, 0))
            ),
            fluidRow(
                column(4, checkboxInput("bmi_tick", "BMI", FALSE)),
                column(8, numericInput("bmi", "", 0, 0))
            ),
            fluidRow(
                column(4, checkboxInput("glucose_g_dl_tick", "Glucose (g/dl)", FALSE)),
                column(8, numericInput("glucose_g_dl", "", 0, 0))
            ),
            fluidRow(
                column(4, checkboxInput("height_tick", "Height (cm)", FALSE)),
                column(8, numericInput("height", "", 0, 0))
            ),
            fluidRow(
                column(4, checkboxInput("lbm_tick", "Lean Body Mass (Kg)", FALSE)),
                column(8, numericInput("lbm", "", 0, 0))
            ),
            fluidRow(
                column(4, checkboxInput("lta_tick", "Leasure Time Activity (hours)", FALSE)),
                column(8, numericInput("lta", "", 0, 0))
            ),
            fluidRow(
                column(4, checkboxInput("mean_chest_skinfold_tick", "Chest skinfold (mean, mm)", FALSE)),
                column(8, numericInput("mean_chest_skinfold", "", 0, 0))
            ),
            fluidRow(
                column(4, checkboxInput("menopausal_tick", "Menopausal stage (1-3)", FALSE)),
                column(8, selectInput("menopausal", "", c(1L, 2L, 3L)))
            ),
            fluidRow(
                column(4, checkboxInput("subscapular_skinfold_tick", "Subscapular skinfold (mean, mm)", FALSE)),
                column(8, numericInput("subscapular_skinfold", "", 0, 0))
            ),
            fluidRow(
                column(4, checkboxInput("surface_area_tick", "Body surface area (cm^2)", FALSE)),
                column(8, numericInput("surface_area", "", 0, 0))
            ),
            fluidRow(
                column(4, checkboxInput("weight_tick", "Weight (Kg)", FALSE)),
                column(8, numericInput("weight", "", 0, 0))
            ),
            fluidRow(
                column(4, checkboxInput("wrist_circumference_tick", "Wrist circumference (cm)", FALSE)),
                column(8, numericInput("wrist_circumference", "", 0, 0))
            ),




                    hr(),
                    strong("STRATA (uncheck to do not use the strata, i.e. it does not means 'no'/'false'!)"),

            fluidRow(
                column(4, checkboxInput("bmi_class_tick", "BMI class", FALSE)),
                column(8, selectInput("bmi_class", "", get_strata(reer)[["bmi_class"]]))
            ),
            fluidRow(
                column(4, checkboxInput("bmi_greater_21_tick", "BMI grater than 21?", FALSE)),
                column(8, selectInput("bmi_greater_21", "", get_strata(reer)[["bmi_greater_21"]]))
            ),
            fluidRow(
                column(4, checkboxInput("diabetic_tick", "Is diabetic?", FALSE)),
                column(8, selectInput("diabetic", "", get_strata(reer)[["diabetic"]]))
            ),
            fluidRow(
                column(4, checkboxInput("ethnicity_tick", "Ethnicity", FALSE)),
                column(8, selectInput("ethnicity", "", get_strata(reer)[["ethnicity"]]))
            ),
            fluidRow(
                column(4, checkboxInput("hf_tick", "is NYHA III or IV?", FALSE)),
                column(8, selectInput("hf", "", get_strata(reer)[["hf"]]))
            ),
            fluidRow(
                column(4, checkboxInput("sex_tick", "Sex", FALSE)),
                column(8, selectInput("sex", "", get_strata(reer)[["sex"]]))
            ),




                    hr(),
                    strong("OUTCOMES"),

            fluidRow(
                column(4, checkboxInput("bee_tick", "BEE", TRUE)),
                column(4, checkboxInput("eee_tick", "EEE", TRUE)),
                column(4, checkboxInput("ree_tick", "REE", TRUE))
            ),
            fluidRow(
                column(4, checkboxInput("bmr_tick", "BMR", TRUE)),
                column(4),
                column(4, checkboxInput("rmr_tick", "RMR", TRUE))
            ),



            hr(),


            actionButton("eval", "Evaluate equations")

        ),


        mainPanel(dataTableOutput("res_tab"))
    )


))
