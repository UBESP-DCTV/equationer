shinyUI(fluidPage(

  # Use shiny js to disable fields
  useShinyjs(),

  title_text(),
  instructions_text(),

  sidebarLayout(

    sidebarPanel(
      tabsetPanel(
        anthropometric_tab(), measurements_tab(), conditions_tab(),
        lab_tests_tab(), physical_activity_tab(), environment_tab(),
        vital_parameters_tab(), outcomes_tab()
      ),
      actionButton("eval", "Evaluate equations", icon = icon("refresh"))
    ),

    mainPanel(tabsetPanel(
      tabPanel("Plots", icon = icon("chart-bar"),
        verticalLayout(
          shiny::plotOutput("res_plot"),
          hr(),
          shiny::plotOutput("bar_plot")
        )
      ),
      tabPanel("Table", icon = icon("grip-horizontal"), dataTableOutput("res_tab"))
    ))

  )

))
