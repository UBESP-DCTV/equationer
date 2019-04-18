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
                column(4, checkboxInput("age_tick", "Age (years)", FALSE)),
                column(8, numericInput("age", "", 0, 0))
            ),
            fluidRow(
                column(4, checkboxInput("weight_tick", "Weight (kg)", FALSE)),
                column(8, numericInput("weight", "", 0, 0))
            ),
            fluidRow(
                column(4, checkboxInput("height_tick", "Height (cm)", FALSE)),
                column(8, numericInput("height", "", 0, 0))
            ),
            fluidRow(
                column(4, checkboxInput("bmi_tick", "Body Mass Index (BMI, kg/m^2)", FALSE)),
                column(8, numericInput("bmi", "", 0, 0))
            ),
            # fluidRow(
            #     column(4, checkboxInput("lbm_tick", "Lean Body Mass (LBM, kg)", FALSE)),
            #     column(8, numericInput("lbm", "", 0, 0))
            # ),
            fluidRow(
                column(4,
                    checkboxInput("lta_tick", "Leasure Time Activity (LTA, hours)", FALSE),
                        bsTooltip(id = "lta_tick", title = "To compute LTA see: Taylor HL, Jacobs DR Jr. Schucker B. et al: A questionnaire for the assessment of leisure time physical activities. J Chronic Dis",
                            placement = "right", trigger = "hover"
                        )
                ),
                column(8, numericInput("lta", "", 0, 0))
            ),
            fluidRow(
                column(4, checkboxInput("mean_chest_skinfold_tick", "Chest skinfold (mean, mm)", FALSE)),
                column(8, numericInput("mean_chest_skinfold", "", 0, 0))
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
                column(4, checkboxInput("wrist_circumference_tick", "Wrist circumference (cm)", FALSE)),
                column(8, numericInput("wrist_circumference", "", 0, 0))
            ),
            fluidRow(
                column(4,
                    checkboxInput("adjusted_weight_tick", "Adjusted weight (kg)", FALSE),
                        bsTooltip(id = "adjusted_weight_tick", title = "[(weight - IBW)/4] + IBW. (NOTE: IBW = 45.5 kg + 2.2 kg for each inch over 5 feet of hight if the wrist is 7 inches; if the wrist size is more or less than 7 inches, you add or subtract 10% of IBW respectively).",
                            placement = "right", trigger = "hover"
                        )
                ),
                column(8, numericInput("adjusted_weight", "", 0, 0))
            ),
            fluidRow(
                column(4, checkboxInput("albumin_mg_dl_tick", "Seric albumin (mg/dl)", FALSE)),
                column(8, numericInput("albumin_mg_dl", "", 0, 0))
            ),
            fluidRow(
                column(4, checkboxInput("glucose_g_dl_tick", "Seric glucose (g/dl)", FALSE)),
                column(8, numericInput("glucose_g_dl", "", 0, 0))
            ),
            fluidRow(
                column(4,
                    checkboxInput("menopausal_tick", "Menopausal stage (1-3)", FALSE),
                        bsTooltip(id = "menopausal_tick", title = "1 = Pre-menopausal status; 2 = perimenopausal: vasomotor instability, hot flashes, absence of regular menstruation for 2-12 m; 3 = post-menopausal women: absence of menstruation > 12 m.",
                            placement = "right", trigger = "hover"
                        )
                ),
                column(8, selectInput("menopausal", "", c(1L, 2L, 3L)))
            ),
            fluidRow(
                column(4, checkboxInput("air_humidity_tick", "Air humidity", FALSE)),
                column(8, numericInput("air_humidity", "", 0, 0))
            ),
            fluidRow(
                column(4, checkboxInput("air_temperature_tick", "Air temperature (C)", FALSE)),
                column(8, numericInput("air_temperature", "", 0, 0))
            ),




                    hr(),
                    strong("STRATA (uncheck to do not use the strata, i.e. it does not means 'no'/'false'!)"),

            fluidRow(
                column(4, checkboxInput("sex_tick", "Gender", FALSE)),
                column(8, selectInput("sex", "", get_strata(reer)[["sex"]]))
            ),
            fluidRow(
                column(4,
                    checkboxInput("bmi_class_tick", "BMI class", FALSE),
                        bsTooltip(id = "bmi_class_tick", title = "underweight <= 18.49 < normal weight <= 24.99 < overweight <= 29.99 < obese",
                            placement = "right", trigger = "hover"
                        )
                ),
                column(8, selectInput("bmi_class", "", get_strata(reer)[["bmi_class"]]))
            ),
            fluidRow(
                column(4, checkboxInput("diabetic_tick", "Is diabetic?", FALSE)),
                column(8, selectInput("diabetic", "", get_strata(reer)[["diabetic"]]))
            ),
            fluidRow(
                column(4, checkboxInput("bmi_greater_21_tick", "Is BMI grater than 21?", FALSE)),
                column(8, selectInput("bmi_greater_21", "", get_strata(reer)[["bmi_greater_21"]]))
            ),
            fluidRow(
                column(4, checkboxInput("hf_tick", "Is NYHA > II (i.e. III or IV)?", FALSE)),
                column(8, selectInput("hf", "", get_strata(reer)[["hf"]]))
            ),
            fluidRow(
                column(4, checkboxInput("ethnicity_tick", "Ethnicity", FALSE)),
                column(8, selectInput("ethnicity", "", get_strata(reer)[["ethnicity"]]))
            ),




                    hr(),
                    strong("OUTCOMES"),

            fluidRow(
                column(3, checkboxInput("bee_tick", "BEE: Basal Energy Expenditure (kcal/day)", TRUE)),
                column(3, checkboxInput("eee_tick", "EEE: Estimated Energy Expenditure (kcal/day)", TRUE)),
                column(3, checkboxInput("ree_tick", "REE: Resting Energy Expenditure (kcal/day)", TRUE))
            ),
            fluidRow(
                column(3, checkboxInput("bmr_tick", "BMR: Basal Metabolic Rate (kcal/day)", TRUE)),
                column(3),
                column(3, checkboxInput("rmr_tick", "RMR: Resting Metabolic Rate (kcal/day)", TRUE))
            ),



            hr(),


            actionButton("eval", "Evaluate equations")

        ),


        mainPanel(dataTableOutput("res_tab"))
    )

))
