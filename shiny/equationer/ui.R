shinyUI(fluidPage(
  # Use shiny js to disable fields
  useShinyjs(),
  title = "equationer",
  titlePanel("Equationer: Calculator for energy requirements in elderly patients"),
  glue::glue("Last update (data): {get_last_update(reer)}"),
  p(),
  glue::glue("Last update (interface): {as.Date(file.info('ui.R')[['mtime']])}"),
  hr(),
  instructions_text(),

  sidebarLayout(

    sidebarPanel(
      tabsetPanel(
        anthropometric_tab(),
        measurements_tab(),
        conditions_tab(),
        lab_tests_tab(),
        physical_activity_tab(),
        environment_tab(),
        vital_parameters_tab(),
        outcomes_tab()
      ),
      actionButton("eval", "Evaluate equations", icon = icon("refresh"))
    ),

    mainPanel(tabsetPanel(
      tabPanel("Plots", icon = icon("chart-bar"), verticalLayout(
        shiny::plotOutput("res_plot"),
        p(""),
        hr(),
        p(""),
        shiny::plotOutput("bar_plot")
      )),
      tabPanel("Table", icon = icon("grip-horizontal"), dataTableOutput("res_tab"))
    ))

  )

))
