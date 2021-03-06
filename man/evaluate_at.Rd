% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/evaluate_at.R
\name{evaluate_at}
\alias{evaluate_at}
\alias{evaluate_at.eq}
\alias{evaluate_at.eqs}
\alias{evaluate_at.eqs_bag}
\title{Evaluate equation}
\usage{
evaluate_at(x, ...)

\method{evaluate_at}{eq}(x, ...)

\method{evaluate_at}{eqs}(x, ..., .outcome = NULL)

\method{evaluate_at}{eqs_bag}(x, ..., .outcome = NULL)
}
\arguments{
\item{x}{equation(s set/bag) object}

\item{...}{sequence of named coefficients' values}

\item{.outcome}{(chr, default NULL) an optional declaration of which
outcome(s) the computation has to consider}
}
\value{
a one row \link[tibble:tibble-package]{tibble} with one column
each covariate supplied, one column for possible strata
considered, one column with the outcome, one column with
the value of the outcome that solve the equation when
its the covariates assume the values supplied, and one last
column with the name of the equation used
}
\description{
Evaluate (i.e., solve for the outcome) the supplied equation at the
supplied values of the covariates
}
\section{Methods (by class)}{
\itemize{
\item \code{eq}: Evaluate (i.e., solve for the outcome) the
supplied equation at the supplied values of the covariates.

\item \code{eqs}: Evaluate (i.e., solve for the outcome)
all the \code{\link{eq}}uations in the \code{\link{eqs}} object
at the supplied values of the covariates.

\item \code{eqs_bag}: Evaluate (i.e., solve for the outcome)
all the \code{\link{eq}}uations in all the possible
\code{\link{eqs}} at the supplied values of the covariates.
}}

\examples{
library(equationer)
eq_test <- eq(age = 0.1, bmi = -0.3,
    name    = "first eq_test",
    outcome = "out"
)
eq2_test <- eq(age = 0.1, bmi = -0.3,
    name    = "first eq_test",
    outcome = "out",
    strata = list(sex = "female")
)

evaluate_at(eq_test, age = 38, bmi = 18)
evaluate_at(eq_test, age = 38, sex = 1, bmi = 18)
evaluate_at(eq2_test, age = 38, bmi = 18)

\dontrun{
    # ERRORS
    evaluate_at(eq_test, age = 38, bmi = 18, sex = "female")
    evaluate_at(eq_test, age = 38)
}
library(equationer)
eq_test <- eq(age = 0.5, bmi = -0.3,
    name    = "eq_test",
    outcome = "kcal/day",
    strata = list(sex = "female")
)
eq2_test <- eq(age = 0.3, bmi = -0.5,
    name    = "eq2_test",
    outcome = "kcal/day",
    strata = list(sex = "male")
)

eqs_test <- eqs(eq_test, eq2_test, name = "eqs-test")

evaluate_at(eqs_test, age = 38, bmi = 18, sex = "female")
evaluate_at(eqs_test, age = 38, bmi = 18, sex = "male")

\dontrun{
    # ERRORS
    evaluate_at(eq_test, age = 38, bmi = 18, mellitus = "yes"))
    evaluate_at(eqs_test, age = 38, bmi = 18, sex = "unknown")
    evaluate_at(eq_test, age = 38)
}

eq1 <- eq(age = 0.3, bmi = -0.5,
    name    = "cl_test_1",
    outcome = "kcal/day",
    strata = list(sex = "male", nyha = 1)
)

eq2 <- eq(age = 0.5, bmi = -0.3,                 # change strata wrt eq1
    name = "cl_test_2",
    outcome = "kcal/day",
    strata = list(sex = "female", nyha = 1)
)

eq3 <- eq(age = -0.3, bmi = 0.5,
    name    = "cl_test_3",
    outcome = "kcal/day",
    strata = list(sex = "male", nyha = 2)
)
eq4 <- eq(age = -0.5, bmi = 0.3,
    name = "cl_test_4",
    outcome = "kcal/day",
    strata = list(sex = "female", nyha = 2)
)

eq9 <- eq(age = -0.1, weight = 0.2,                # change var, strata
    name = "cl_test_9",
    outcome = "kcal/month",
    strata = list(sex = "female")
)

eq10 <- eq(age = -0.2, weight = 0.1,                # change var, strata
    name = "cl_test_10",
    outcome = "kcal/month",
    strata = list(sex = "male")
)

eq11 <- eq(age = 0.1, weight = -0.2,                # change var, strata
    name = "cl_test_11",
    outcome = "kcal/day",
    strata = list(sex = "female")
)

eq12 <- eq(age = 0.2, weight = -0.2,                # change var, strata
    name = "cl_test_12",
    outcome = "kcal/day",
    strata = list(sex = "male")
)


eqs1 <- eqs(eq1, eq2, eq3, eq4,
    name = "eqs1",
    reference = "ref-a"
)

eqs2 <- eqs(eq9, eq10, eq11, eq12,
    name = "eqs2",
    reference = "ref-b"
)


eqs_bag_test <- eqs_bag(eqs1, eqs2,
    name = "overall-bag",
    reference = "equationer-test-bag"
)


evaluate_at(eqs_bag_test, age = 35)
evaluate_at(eqs_bag_test, age = 35, bmi = 18)
evaluate_at(eqs_bag_test, age = 35, bmi = 18, weight = 81)
evaluate_at(eqs_bag_test, age = 35, bmi = 18, sex = "female")
evaluate_at(eqs_bag_test, age = 35, bmi = 18, weight = 81, sex = "female")
evaluate_at(eqs_bag_test, age = 35, bmi = 18, weight = 81, nyha = 1)
evaluate_at(eqs_bag_test, age = 35, bmi = 18, weight = 81, .outcome = "kcal/day")
evaluate_at(eqs_bag_test, age = 35, bmi = 18, weight = 81, sex = "female", .outcome = "kcal/day")

one_patient <- dplyr::tribble(
    ~id, ~age, ~bmi, ~weight,     ~sex,
      1,   35,   18,      81,  "female"
)

more_patients <- dplyr::tribble(
    ~id, ~age, ~bmi, ~weight,     ~sex,
      1,   35,   18,      81,  "female",
      2,   27,   20,      93,    "male"
)

evaluate_at(eqs_bag_test, one_patient)
evaluate_at(eqs_bag_test, more_patients)
}
