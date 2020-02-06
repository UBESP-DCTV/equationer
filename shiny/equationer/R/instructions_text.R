instructions_text <- function() {
  p(
    p("Equationer is a graphical tool to estimate distributions of daily energy requirement per day according to the characteristics of a subject."),
    p("Equationer will show all the equations available in literature for elderly patients according to the values provided too."),
    hr(),
    p("Please make sure to check all the boxes selecting the variables to use, and then provide a value/answer for them."),
    p(strong("It is not necessary to fill all the fields.")),
    p("The outcomes available are divided as follows:"),
    tags$li("Basal Energy Expenditure (BEE)"),
    tags$li("Basal Metabolic Rate (BMR)"),
    tags$li("Resting Energy Expenditure (REE)"),
    tags$li("Resting Metabolic Rate (RMR)"),
    tags$li("Estimated Energy Expenditure (EEE)"),
    tags$li("Estimated Energy Requirement (EER)"),
    p(""),
    p("If you wish to consider only equations with a specific definition of the outcome, please unchecked the other ones."),
    p(strong("The more outcomes remain selected, the more results will be displayed.")),
    p("Outcomes are provided in Kcal/day."),
    hr(),
    p("Please be aware that the amount of equations resulting from equationer depends on the selected variables."),
    p("Selecting a choiche for categorical variables like, e.g., gender or ethnicity, will result in a lower number of equations estimated (i.e., only the ones involving that level, and the ones which do not involve the factor at all)."),
    p("Set a value for numerical variables, like, e.g., height or weight, instead will result in a higher amount of equations estimated (i.e., all the one able to use that information)."),
    hr(),
    p(strong("All the equations for which there will be enough information will be evaluated."))
  )
}
