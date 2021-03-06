% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/eqs_bag.R, R/print_-.R
\name{eqs_bag}
\alias{eqs_bag}
\alias{print.eqs_bag}
\title{Bag of multiple equation object}
\usage{
eqs_bag(..., name, reference = NA_character_, last_update = lubridate::today())

\method{print}{eqs_bag}(x, ...)
}
\arguments{
\item{...}{(\code{\link{eqs}}, only) sequence of \code{\link{eqs}}}

\item{name}{(chr) the name of the \code{\link{eqs}}(s)' bag}

\item{reference}{(chr, default NA) an optional reference for the
bag of \code{\link{eqs}}(s) in the bag.}

\item{last_update}{(Date, default today) the date of the last bag
update.}

\item{x}{an object used to select a method}
}
\value{
an \code{\link{eqs_bag}} object

invisible \code{x}
}
\description{
Constructor for object of class \code{\link{eqs_bag}} defined as a
collection of many \code{\link{eqs}}(s).
}
\section{Methods (by generic)}{
\itemize{
\item \code{print}: Method to print \code{\link{eqs_bag}} bag
}}

\examples{

eq1 <- eq(age = 0.3, bmi = -0.5,
    name    = "cl_test_1",
    outcome = "kcal/day",
    strata = list(sex = "male", nyha = 1)
)

eq2 <- eq(age = 0.5, bmi = -0.3,              # change strata wrt eq1
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

eq9 <- eq(age = -0.1, weight = 0.2,              # change var, strata
    name = "cl_test_9",
    outcome = "kcal/month",
    strata = list(sex = "female")
)

eq10 <- eq(age = -0.2, weight = 0.1,             # change var, strata
    name = "cl_test_10",
    outcome = "kcal/month",
    strata = list(sex = "male")
)

eq11 <- eq(age = 0.1, weight = -0.2,             # change var, strata
    name = "cl_test_11",
    outcome = "kcal/day",
    strata = list(sex = "female")
)

eq12 <- eq(age = 0.2, weight = -0.2,             # change var, strata
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
eq1 <- eq(age = 0.3, bmi = -0.5, name = "eq-1", outcome = "kcal/day",
    strata = list(sex = "male", nyha = 1)
)
eq2 <- eq(age = 0.5, bmi = -0.3, name = "eq-2", outcome = "kcal/day",
    strata = list(sex = "female", nyha = 1)
)
eq3 <- eq(age = -0.3, bmi = 0.5, name = "eq-3", outcome = "kcal/day",
    strata = list(sex = "male", nyha = 2)
)
eq4 <- eq(age = -0.5, bmi = 0.3, name = "eq-4", outcome = "kcal/day",
    strata = list(sex = "female", nyha = 2)
)


eq9 <- eq(age = -0.1, weight = 0.2, name = "eq-9", outcome = "kcal/month",
    strata = list(sex = "female")
)
eq10 <- eq(age = -0.2, weight = 0.1, name = "eq-10", outcome = "kcal/month",
    strata = list(sex = "male")
)
eq11 <- eq(age = 0.1, weight = -0.2, name = "eq-11", outcome = "kcal/day",
    strata = list(sex = "female")
)
eq12 <- eq(age = 0.2, weight = -0.2, name = "eq-12", outcome = "kcal/day",
    strata = list(sex = "male")
)


eqs1 <- eqs(eq1, eq2, eq3, eq4, name = "eqs-a", reference = "ref-a")
eqs2 <- eqs(eq9, eq10, eq11, eq12, name = "eqs-b", reference = "ref-b")

eqs_bag(eqs1, eqs2, name = "ubesp19", reference = "DG et.al 2019")
}
