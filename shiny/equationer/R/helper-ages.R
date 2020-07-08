init_age_val <- function() {
  age_18_65 <<- age_18_74 <<-
    # older_18 <<-
    older_29 <<- age_50_69 <<-
    # older_59 <<-
    older_60 <<- age_60_70 <<- older_70 <<-
    age_60_74 <<- older_74 <<- "FALSE"
}

init_age_tick <- function(value) {
  age_18_65_tick <<- age_18_74_tick <<-
    # older_18_tick <<-
    older_29_tick <<- age_50_69_tick <<-
    # older_59_tick <<-
    older_60_tick <<- age_60_70_tick <<- older_70_tick <<-
    age_60_74_tick <<- older_74_tick <<- value
}


update_ages <- function(age) {
  # the execution order is important: some variables are re-defined more
  # than ones!
  #

  if (age >= 18) age_18_65 <<- age_18_74 <<- "TRUE"
  if (age >  29) older_29  <<- "TRUE"
  if (age >= 50) age_50_69 <<- "TRUE"
  if (age >  59) age_60_70 <<- age_60_74 <<- "TRUE"
  if (age >  60) older_60  <<- "TRUE"
  if (age >  65) age_18_65 <<- "FALSE"
  if (age >  69) age_50_69 <<- "FALSE"
  if (age >  70) {
                 older_70  <<- "TRUE"
                 age_60_70 <<- "FALSE"
  }
  if (age >  74) {
                 older_74  <<- "TRUE"
                 age_60_74 <<- age_18_74 <<- "FALSE"
  }
}
