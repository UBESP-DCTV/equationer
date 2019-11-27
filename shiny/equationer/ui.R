shinyUI(fluidPage(
    # Use shiny js to disable fields
    useShinyjs(),
    title = "equationer",
    titlePanel("Equations of Energy Requirements in Elderly Patients"),
    glue::glue("Last update: {get_last_update(reer)}"),
    hr(),
    p("Please, select the variables (i.e., covariates, filters, and outcomes) needed for the computation of the energy requirement estimation(s). It is not necessary to fill all the fields."),
    p(strong("Covariates"), "(e.g., height, or weight):  all the relevant equations that can be evaluated using some subset of the covariates selected will be evaluated. The more covariates are included, the more equations will be evaluated and appear in the results."),
    p(strong("Filters"), "(e.g., categorical variables like gender, or ethnicity): if selected will identify -among the equations retrieved through the covariates- the ones which employ the selected filters. Equations that do not consider the selected filters at all will be evaluated as well. On the other hand, equations that consider unselected filters will show the results of each category of the unselected filters. The more filters are selected, the fewer equations will appear in the results."),
    p(strong("Outcomes"), " (the definition of the caloric intake, like rmr, or ree): vary depending on the validated equations. If you wish to consider only equations with a specific definition of the outcome, please unchecked the other ones. The more outcomes remain selected, the more results will be displayed."),
    hr(),
    # actionButton("eval", "Evaluate equations", icon = icon("refresh")),
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
                        column(7, checkboxInput("body_surface_area_tick", "Body surface area (cm^2)", FALSE)),
                        column(5, numericInput("body_surface_area", "", numeric(), 10, 1000))
                    ),
                    fluidRow(
                        column(7, checkboxInput("arm_span_tick", "Arm span (cm)", FALSE)),
                        column(5, numericInput("arm_span", "", numeric(), 10, 1000))
                    ),
                    fluidRow(
                        column(7, checkboxInput("wrist_circumference_tick", "Wrist circumference (cm)", FALSE)),
                        column(5, numericInput("wrist_circumference", "", numeric(), 10, 1000))
                    ),
                    fluidRow(
                        column(7, checkboxInput("hip_circumference_tick", "Hip circumference (cm)", FALSE)),
                        column(5, numericInput("hip_circumference", "", numeric(), 10, 1000))
                    ),
                    fluidRow(
                        column(7, checkboxInput("abdomen_circ_tick", "Abdominal circumference (cm)", FALSE)),
                        column(5, numericInput("abdomen_circ", "", numeric(), 10, 1000))
                    ),
                    fluidRow(
                        column(7, checkboxInput("midarm_circumference_tick", "Midarm circumference (cm)", FALSE)),
                        column(5, numericInput("midarm_circumference", "", numeric(), 10, 1000))
                    ),
                    fluidRow(
                        column(7, checkboxInput("blood_pressure_gradient_tick", "Blood pressure gradient (mmHg)", FALSE)),
                        column(5, numericInput("blood_pressure_gradient", "", numeric(), 0, 1000))
                    ),
                    fluidRow(
                        column(7, checkboxInput("pulse_tick", "Heart rate (bbp)", FALSE)),
                        column(5, numericInput("pulse", "", numeric(), 0, 300))
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
                        column(7, checkboxInput("fasting_plasma_glucose_tick", "Fasting plasma glucose (mg/dl)", FALSE)),
                        column(5, numericInput("fasting_plasma_glucose", "", numeric(), 0, 1000))
                    ),
                    fluidRow(
                        column(7, checkboxInput("crp_mg_l_tick", "C-reactive protein (mg/l)", FALSE)),
                        column(5, numericInput("crp_mg_l", "", numeric(), 0, 10000))
                    ),
                    fluidRow(
                        column(7, checkboxInput("body_temperature_tick", "Body temperature (C)", FALSE)),
                        column(5, numericInput("body_temperature", "", numeric(), 0, 100))
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
                        column(7, checkboxInput("hour_tick", "Hour (HH)", FALSE)),
                        column(5, numericInput("hour", "", numeric(), 0, 24))
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
                        column(6, checkboxInput("activity_intensity_tick", "Activity intensity", FALSE)),
                        column(6, selectInput("activity_intensity", "", get_strata(reer)[["activity_intensity"]]))
                    ),
                    fluidRow(
                        column(6, checkboxInput("athletic_tick", "Is athletic?", FALSE)),
                        column(6, selectInput("athletic", "", c("FALSE", "TRUE")))
                    ),
                    fluidRow(
                        column(6, checkboxInput("smoke_tick", "Is a smoker?", FALSE)),
                        column(6, selectInput("smoke", "", c("FALSE", "TRUE")))
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
                        column(3, checkboxInput("ree_tick", "REE: Resting Energy Expenditure (kcal/day)", TRUE)),
                        column(3, checkboxInput("eee_tick", "EEE: Estimated Energy Expenditure (kcal/day)", TRUE))
                    ),
                    fluidRow(
                        column(3, checkboxInput("bmr_tick", "BMR: Basal Metabolic Rate (kcal/day)", TRUE)),
                        column(3, checkboxInput("rmr_tick", "RMR: Resting Metabolic Rate (kcal/day)", TRUE)),
                        column(3, checkboxInput("eer_tick", "EER: Estimated Energy Requirement (kcal/day)", TRUE))
                    )
                ))
            )
        ),

        mainPanel(tabsetPanel(
            tabPanel("Plot", icon = icon("chart-bar"), shiny::plotOutput("res_plot")),
            tabPanel("Table", icon = icon("grip-horizontal"), dataTableOutput("res_tab"))
        ))
    ),

    actionButton("eval", "Evaluate equations", icon = icon("refresh")),
    p("All the equations for which there will be enough information will be evaluated.")
))
