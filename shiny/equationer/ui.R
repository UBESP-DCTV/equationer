shinyUI(fluidPage(
    # Use shiny js to disable fields
    useShinyjs(),
    title = "equationer",
    titlePanel("Equations of Energy Requirements in Elderly Patients"),
    glue::glue("Last update: {get_last_update(reer)}"),
    hr(),
    p("Please select the information to use for the energy requirement estimation(s):"),
    p(strong("Covariates"), ": personal information (must be numeric). They will be used to evaluate the equations", strong("The more covariates you include, the more equations will be evaluated.")),
    p(strong("Filters"), ": for the equations provided with categorical variables (e.g., gender = male/female), select a value for a category will evaluate these equations considering only that value. All the equations which do not consider the category at all will be evaluated as well. If a category is not selected (i.e., without tick) the equations which consider it will be evaluated for all the possible values of the category.", strong("The more filters you select, the less equations will be evaluated.")),
    p(strong("Outcomes"), ": only the equations which provide estimation for the selected outcome will be evaluated", strong("The more outcomes you select, the more equations will be evaluated.")),
    hr(),
    actionButton("eval", "Evaluate equations", icon = icon("refresh")),
    p("All the equations for which there will be enough information will be evaluated."),

   # textOutput("test_text"),

   # Sidebar with a slider input for number of bins

    sidebarLayout(
        sidebarPanel(
            tabsetPanel(
                tabPanel(strong("Covariates"), icon = icon("file-medical"), flowLayout(
                    fluidRow(
                        column(7, checkboxInput("age_tick", "Age (years)", FALSE)),
                        column(5, numericInput("age", "", numeric(), 18, 122))
                    ),
                    fluidRow(
                        column(7, checkboxInput("weight_tick", "Weight (kg)", FALSE)),
                        column(5, numericInput("weight", "", numeric(), 27, 635))
                    ),
                    fluidRow(
                        column(7, checkboxInput("height_tick", "Height (cm)", FALSE)),
                        column(5, numericInput("height", "", numeric(), 62.8, 272))
                    ),
                    fluidRow(
                        column(7,
                            checkboxInput("lta_tick", "Leasure Time Activity (LTA, kcal/day)", FALSE),
                                bsTooltip(id = "lta_tick", title = "To compute LTA see: Taylor HL, Jacobs DR Jr. Schucker B. et al: A questionnaire for the assessment of leisure time physical activities. J Chronic Dis",
                                    placement = "right", trigger = "hover"
                                )
                        ),
                        column(5, numericInput("lta", "", numeric(), 0))
                    ),
                    fluidRow(
                        column(7, checkboxInput("mean_chest_skinfold_tick", "Chest skinfold (mean, mm)", FALSE)),
                        column(5, numericInput("mean_chest_skinfold", "", numeric(), 1, 1000))
                    ),
                    fluidRow(
                        column(7, checkboxInput("subscapular_skinfold_tick", "Subscapular skinfold (mean, mm)", FALSE)),
                        column(5, numericInput("subscapular_skinfold", "", numeric(), 1, 1000))
                    ),
                    fluidRow(
                        column(7, checkboxInput("surface_area_tick", "Body surface area (cm^2)", FALSE)),
                        column(5, numericInput("surface_area", "", numeric(), 10, 1000))
                    ),
                    fluidRow(
                        column(7, checkboxInput("wrist_circumference_tick", "Wrist circumference (cm)", FALSE)),
                        column(5, numericInput("wrist_circumference", "", numeric(), 10, 1000))
                    ),
                    fluidRow(
                        column(7,
                            checkboxInput("adjusted_weight_tick", "Adjusted weight (kg)", FALSE),
                                bsTooltip(id = "adjusted_weight_tick", title = "[(weight - IBW)/4] + IBW. (NOTE: IBW = 45.5 kg + 2.2 kg for each inch over 5 feet of hight if the wrist is 7 inches; if the wrist size is more or less than 7 inches, you add or subtract 10% of IBW respectively).",
                                    placement = "right", trigger = "hover"
                                )
                        ),
                        column(5, numericInput("adjusted_weight", "", numeric(), 27, 600))
                    ),
                    fluidRow(
                        column(7, checkboxInput("albumin_mg_dl_tick", "Seric albumin (mg/dl)", FALSE)),
                        column(5, numericInput("albumin_mg_dl", "", numeric(), 0, 1000))
                    ),
                    fluidRow(
                        column(7, checkboxInput("glucose_g_dl_tick", "Seric glucose (g/dl)", FALSE)),
                        column(5, numericInput("glucose_g_dl", "", numeric(), 0, 1000))
                    ),
                    fluidRow(
                        column(7, checkboxInput("crp_mg_l_tick", "C-reactive protein (mg/l)", FALSE)),
                        column(5, numericInput("crp_mg_l", "", numeric(), 0, 10000))
                    ),
                   fluidRow(
                        column(7, checkboxInput("air_humidity_tick", "Air humidity (%)", FALSE)),
                        column(5, numericInput("air_humidity", "", numeric(), 0, 100))
                    ),
                    fluidRow(
                        column(7, checkboxInput("air_temperature_tick", "Air temp. (C)", FALSE)),
                        column(5, numericInput("air_temperature", "", numeric(), -257.15, 257.15))
                    ),
                    fluidRow(
                        column(12,
                            checkboxInput("menopausal_tick", "Menopausal stage", FALSE),
                                bsTooltip(id = "menopausal_tick", title = "Perimenopausal: vasomotor instability, hot flashes, absence of regular menstruation for 2-12 month; Post-menopausal: absence of menstruation > 12 month.",
                                    placement = "right", trigger = "hover"
                                )
                        ),
                        column(12, selectInput("menopausal", "", c("Pre-menopausal", "Perimenopausal", "Post-menopausal")))
                    )
                 )),

                tabPanel(strong("Filters"), icon = icon("filter"), verticalLayout(
                    fluidRow(
                        column(6, checkboxInput("sex_tick", "Gender", FALSE)),
                        column(6, selectInput("sex", "", get_strata(reer)[["sex"]]))
                    ),
                    fluidRow(
                        column(6, checkboxInput("diabetic_tick", "Is diabetic?", FALSE)),
                        column(6, selectInput("diabetic", "", c("FALSE", "TRUE")))
                    ),
                    fluidRow(
                        column(6, checkboxInput("pal_tick", "Physical Activity Level (PAL)", FALSE)),
                        column(6, selectInput("pal", "", get_strata(reer)[["pal"]]))
                    ),
                    fluidRow(
                        column(6, checkboxInput("inpatients_tick", "Is inpatients?", FALSE)),
                        column(6, selectInput("inpatients", "", c("FALSE", "TRUE")))
                    ),
                    fluidRow(
                        column(6, checkboxInput("rheumatoid_arthritis_tick", "Has rheumatoid arthritis?", FALSE)),
                        column(6, selectInput("rheumatoid_arthritis", "", c("FALSE", "TRUE")))
                    ),
                    fluidRow(
                        column(6, checkboxInput("hf_tick", "Has heart failure (NHYA >= III)?", FALSE)),
                        column(6, selectInput("hf", "", c("FALSE", "TRUE")))
                    ),
                    fluidRow(
                        column(6, checkboxInput("copd_tick", "Has Chronic Obstructive Pulmonary Disease (COPD)?", FALSE)),
                        column(6, selectInput("copd", "", c("FALSE", "TRUE")))
                    ),
                    fluidRow(
                        column(6, checkboxInput("ethnicity_tick", "Ethnicity", FALSE)),
                        column(6, selectInput("ethnicity", "", sort(get_strata(reer)[["ethnicity"]])))
                    )
                )),

                tabPanel(strong("Outcome"), icon = icon("bullseye"), verticalLayout(
                    fluidRow(
                        column(3, checkboxInput("bee_tick", "BEE: Basal Energy Expenditure (kcal/day)", TRUE)),
                        column(3, checkboxInput("eee_tick", "EEE: Estimated Energy Expenditure (kcal/day)", TRUE)),
                        column(3, checkboxInput("ree_tick", "REE: Resting Energy Expenditure (kcal/day)", TRUE))
                    ),
                    fluidRow(
                        column(3, checkboxInput("bmr_tick", "BMR: Basal Metabolic Rate (kcal/day)", TRUE)),
                        column(3),
                        column(3, checkboxInput("rmr_tick", "RMR: Resting Metabolic Rate (kcal/day)", TRUE))
                    )
                ))
            )
        ),

        mainPanel(tabsetPanel(
            tabPanel("Plot", icon = icon("chart-bar"), shiny::plotOutput("res_plot")),
            tabPanel("Table", icon = icon("grip-horizontal"), dataTableOutput("res_tab"))
        ))
    )
))
