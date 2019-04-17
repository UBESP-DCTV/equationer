
<!-- README.md is generated from README.Rmd. Please edit that file -->

# equationer <img src="man/figures/logo.png" align="right" height=140/>

[![Build
Status](https://travis-ci.com/UBESP-DCTV/equationer.svg?branch=master)](https://travis-ci.com/UBESP-DCTV/equationer)
[![Coverage
status](https://codecov.io/gh/UBESP-DCTV/equationer/branch/master/graph/badge.svg)](https://codecov.io/github/UBESP-DCTV/equationer?branch=master)

[![lifecycle](https://img.shields.io/badge/lifecycle-maturing-blue.svg)](https://www.tidyverse.org/lifecycle/#maturing)
[![CRAN
status](https://www.r-pkg.org/badges/version/equationer)](https://cran.r-project.org/package=equationer)

The goal of the package `equationer` is to implement an environment to
consistently generate the estimations from the equations reported in the
paper “Review of Equations of Energy Requirements” by the *Unit of
Biostatistics, Epidemiology and Public Health* of the University of
Padova.

## Installation

You can install the development version of `equationer` from
[GitHub](https://github.com/) with the following procedure:

``` r
# install.packages("devtools")
devtools::install_github("UBESP-DCTV/equationer")
```

## Hot to use it

``` r
library(equationer)
```

First of all define some equations. Please note that equations must be
named and that equations’ names must be different each other. Moreover,
you have to supply strata as a named list defining in each equation
which level of the strata it consider. Note that strata levels can be of
different class inside an equation (e.g. character, numeric, …) but,
obviously, you cannot provide multiple strata with the same name or a
strata with more thn one level in each equation.

``` r
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
```

When you visualize an equation the manin characteristics will be
highlighted

``` r
eq1
#> 
#> <U+25CF> Equation 'eq-1': kcal/day = 0.3 age + -0.5 bmi
#> Strata: sex = 'male'
#> Strata: nyha = 1
eq2
#> 
#> <U+25CF> Equation 'eq-2': kcal/day = 0.5 age + -0.3 bmi
#> Strata: sex = 'female'
#> Strata: nyha = 1
eq3
#> 
#> <U+25CF> Equation 'eq-3': kcal/day = -0.3 age + 0.5 bmi
#> Strata: sex = 'male'
#> Strata: nyha = 2

eq9
#> 
#> <U+25CF> Equation 'eq-9': kcal/month = -0.1 age + 0.2 weight
#> Strata: sex = 'female'
```

We can evaluate an equation providing (in a nutral non quoted language)
the values for each covariates. Please note that we have to provide “at
least” the covariate included in the equation (or we get an error that
tell us which ones we have missed). If we provide more covariates than
the ones included in the equation it does not matter for the resulting
estimation and its value will be returned in the output data frame too.

``` r
evaluate_at(eq1, age = 35)
#> <U+2716> Covariate(s) missing: 'bmi'
#> Error: Not all equation's covariates are included in the set supplied.
evaluate_at(eq1, age = 35, bmi = 18)
#> # A tibble: 1 x 7
#>     age   bmi sex    nyha outcome  estimation eq_name
#>   <dbl> <dbl> <chr> <dbl> <chr>         <dbl> <chr>  
#> 1    35    18 male      1 kcal/day        1.5 eq-1
evaluate_at(eq9, age = 35, bmi = 18, weight = 84)
#> # A tibble: 1 x 7
#>     age   bmi weight sex    outcome    estimation eq_name
#>   <dbl> <dbl>  <dbl> <chr>  <chr>           <dbl> <chr>  
#> 1    35    18     84 female kcal/month       13.3 eq-9
```

Equations must be aggregated in group, basicaly because the strata which
cannot suit well in maths: i.e. each different combination of strata
(i.e. cathegorical level) there is an equation. For consistency, even
single equation with no strat must be grouped in a group (singleton).
Even for the grous of equations we have to provide (distinct) names for
each group. Moreover, you can optionally associate a reference (i.e. a
single character string) to groups.

When we print a group, a summary of the characteristics were shown
including each equation itself

``` r
eqs1 <- eqs(eq1, eq2, eq3, eq4, name = "eqs-a", reference = "ref-a")
eqs2 <- eqs(eq9, eq10, eq11, eq12, name = "eqs-b", reference = "ref-b")

eqs1
#> 
#> Equations group 'eqs-a':
#> 
#> Strata sex w/ levels: 'female', 'male'
#> Strata nyha w/ levels: '1', '2'
#> 
#> 
#> <U+25CF> Equation 'eq-1': kcal/day = 0.3 age + -0.5 bmi
#> Strata: sex = 'male'
#> Strata: nyha = 1
#> 
#> 
#> <U+25CF> Equation 'eq-2': kcal/day = 0.5 age + -0.3 bmi
#> Strata: sex = 'female'
#> Strata: nyha = 1
#> 
#> 
#> <U+25CF> Equation 'eq-3': kcal/day = -0.3 age + 0.5 bmi
#> Strata: sex = 'male'
#> Strata: nyha = 2
#> 
#> 
#> <U+25CF> Equation 'eq-4': kcal/day = -0.5 age + 0.3 bmi
#> Strata: sex = 'female'
#> Strata: nyha = 2
#> 
#> 
#> Main reference: 'ref-a'
```

We can evaluate a group of equation all togeter as it is a single one.
We will get a data frame of results with one row each possible equation.
Possible equation were decided with respect to the outcome requested
(default all the possible one), i.e. if some equation in a group cannot
provide an outcome, clearly those equation will not evaluate it. At the
same time we can considered for the evaluation only eqautions which
assume particoular level of some strata. In this case if we ask for a
statum to assume a level it does not have nothing will be computed
(anyway the resulting object still a data frame of zero rows, for
consistency of the outut class). On the other hand if we ask for a
strata that does not exist at all in the equation in the group it will
be ignored in the computation and the level selected will be reported in
the output data frame.

``` r
# not enough values
evaluate_at(eqs1, age = 38)
#> <U+2716> Covariate(s) missing: 'bmi'
#> Error: Not all equation's covariates are included in the set supplied.

# enough values, no filter
evaluate_at(eqs1, age = 38, bmi = 18)
#> # A tibble: 4 x 9
#>     age   bmi sex     nyha outcome  estimation eq_name eq_group reference
#>   <dbl> <dbl> <chr>  <dbl> <chr>         <dbl> <chr>   <chr>    <chr>    
#> 1    38    18 male       1 kcal/day        2.4 eq-1    eqs-a    ref-a    
#> 2    38    18 female     1 kcal/day       13.6 eq-2    eqs-a    ref-a    
#> 3    38    18 male       2 kcal/day       -2.4 eq-3    eqs-a    ref-a    
#> 4    38    18 female     2 kcal/day      -13.6 eq-4    eqs-a    ref-a

# more values, no filter
evaluate_at(eqs1, age = 38, bmi = 18, weight = 81, height = 184)
#> # A tibble: 4 x 11
#>     age   bmi weight height sex    nyha outcome estimation eq_name eq_group
#>   <dbl> <dbl>  <dbl>  <dbl> <chr> <dbl> <chr>        <dbl> <chr>   <chr>   
#> 1    38    18     81    184 male      1 kcal/d~        2.4 eq-1    eqs-a   
#> 2    38    18     81    184 fema~     1 kcal/d~       13.6 eq-2    eqs-a   
#> 3    38    18     81    184 male      2 kcal/d~       -2.4 eq-3    eqs-a   
#> 4    38    18     81    184 fema~     2 kcal/d~      -13.6 eq-4    eqs-a   
#> # ... with 1 more variable: reference <chr>

# filter by a strata level
evaluate_at(eqs1, age = 38, bmi = 18, sex = "female")
#> # A tibble: 2 x 9
#>     age   bmi sex     nyha outcome  estimation eq_name eq_group reference
#>   <dbl> <dbl> <chr>  <dbl> <chr>         <dbl> <chr>   <chr>    <chr>    
#> 1    38    18 female     1 kcal/day       13.6 eq-2    eqs-a    ref-a    
#> 2    38    18 female     2 kcal/day      -13.6 eq-4    eqs-a    ref-a

# filter by a strata inexistent level
evaluate_at(eqs1, age = 38, bmi = 18, sex = "unknown")
#> Warning: Some strata's levels requested are not included in the equations
#> in eqs-a. They won't be evaluated.
#> <U+2716> Values 'unknown' is not present in the sex's strata possible levels.
#> <U+25CF> Possible values for sex are: 'female', 'male'.
#> # A tibble: 0 x 9
#> # ... with 9 variables: age <dbl>, bmi <dbl>, sex <fct>, nyha <fct>,
#> #   outcome <chr>, estimation <dbl>, eq_name <chr>, eq_group <chr>,
#> #   reference <chr>

# Ask only for a specific outcome (please note the DOT)
evaluate_at(eqs2, age = 38, weight = 81, .outcome = "kcal/day")
#> # A tibble: 2 x 8
#>     age weight sex    outcome  estimation eq_name eq_group reference
#>   <dbl>  <dbl> <chr>  <chr>         <dbl> <chr>   <chr>    <chr>    
#> 1    38     81 female kcal/day     -12.4  eq-11   eqs-b    ref-b    
#> 2    38     81 male   kcal/day      -8.60 eq-12   eqs-b    ref-b

# Ask only for a specific inexistent outcome
evaluate_at(eqs2, age = 38, weight = 81, .outcome = "kcal")
#> Warning: Only equations with possible outcome (if any) will be considered
#> for 'eqs-b'.
#> <U+2716> Outcome 'kcal' is not present in the equations eqs-b
#> <U+25CF> Possible outcomes are: 'kcal/month', 'kcal/day'.
#> # A tibble: 0 x 8
#> # ... with 8 variables: age <dbl>, weight <dbl>, sex <fct>, outcome <chr>,
#> #   estimation <dbl>, eq_name <chr>, eq_group <chr>, reference <chr>
```

Finally, a bag of (grouped) equations can be created to have a complete
bag\!

``` r
bag1 <- eqs_bag(eqs1, eqs2, name = "ubesp19",
    reference = "DG et.al 2019"
)

bag1
#> 
#> Equations bag 'ubesp19' (last update `2019-04-17`)
#> 
#> Variable included: 'age', 'bmi', 'weight'
#> Strata: sex w/ levels: 'female', 'male'
#> Strata: nyha w/ levels: 1, 2
#> Outcome considered: 'kcal/day', 'kcal/month'
#> Number of equation groups: 2
#> Overall numeber of equations: 8
#> 
#> Main reference: 'DG et.al 2019'
```

For a complete bag (which is supposed to be quite huge) we can ask an
estimation both by providing directly the covariates value (i.e. one
patient by one patient), and by passing the information (of one or more
patients) using a data frame\! In the latter case, a column which keep
track of the original row in the sourced dataframe will be added

``` r
evaluate_at(bag1,
    age = 35, bmi = 18, weight = 81, sex = "female"
)
#> Warning: Only equations with possible outcome (if any) will be considered
#> for 'eqs-a'.
#> <U+2716> Outcome 'kcal/month' is not present in the equations eqs-a
#> <U+25CF> Possible outcomes are: 'kcal/day'.
#> # A tibble: 4 x 10
#>     age   bmi weight sex    nyha outcome estimation eq_name eq_group
#>   <dbl> <dbl>  <dbl> <chr> <dbl> <chr>        <dbl> <chr>   <chr>   
#> 1    35    18     81 fema~     1 kcal/d~       12.1 eq-2    eqs-a   
#> 2    35    18     81 fema~     2 kcal/d~      -12.1 eq-4    eqs-a   
#> 3    35    18     81 fema~    NA kcal/m~       12.7 eq-9    eqs-b   
#> 4    35    18     81 fema~    NA kcal/d~      -12.7 eq-11   eqs-b   
#> # ... with 1 more variable: reference <chr>

one_patient <- dplyr::tribble(
    ~age, ~bmi, ~weight,     ~sex,
      35,   18,      81,  "female"
)

evaluate_at(bag1, one_patient)
#> Warning: Only equations with possible outcome (if any) will be considered
#> for 'eqs-a'.
#> <U+2716> Outcome 'kcal/month' is not present in the equations eqs-a
#> <U+25CF> Possible outcomes are: 'kcal/day'.
#> # A tibble: 4 x 10
#>     age   bmi weight sex    nyha outcome estimation eq_name eq_group
#>   <dbl> <dbl>  <dbl> <chr> <dbl> <chr>        <dbl> <chr>   <chr>   
#> 1    35    18     81 fema~     1 kcal/d~       12.1 eq-2    eqs-a   
#> 2    35    18     81 fema~     2 kcal/d~      -12.1 eq-4    eqs-a   
#> 3    35    18     81 fema~    NA kcal/m~       12.7 eq-9    eqs-b   
#> 4    35    18     81 fema~    NA kcal/d~      -12.7 eq-11   eqs-b   
#> # ... with 1 more variable: reference <chr>



more_patients <- dplyr::tribble(
    ~age, ~bmi, ~weight,     ~sex,
      35,   18,      81,  "female",
      27,   20,      93,    "male"
)

evaluate_at(bag1, more_patients)
#> Warning: Only equations with possible outcome (if any) will be considered
#> for 'eqs-a'.
#> <U+2716> Outcome 'kcal/month' is not present in the equations eqs-a
#> <U+25CF> Possible outcomes are: 'kcal/day'.
#> Warning: Only equations with possible outcome (if any) will be considered
#> for 'eqs-a'.
#> <U+2716> Outcome 'kcal/month' is not present in the equations eqs-a
#> <U+25CF> Possible outcomes are: 'kcal/day'.
#> # A tibble: 8 x 11
#>     age   bmi weight sex    nyha outcome estimation eq_name eq_group
#>   <dbl> <dbl>  <dbl> <chr> <dbl> <chr>        <dbl> <chr>   <chr>   
#> 1    35    18     81 fema~     1 kcal/d~       12.1 eq-2    eqs-a   
#> 2    35    18     81 fema~     2 kcal/d~      -12.1 eq-4    eqs-a   
#> 3    35    18     81 fema~    NA kcal/m~       12.7 eq-9    eqs-b   
#> 4    35    18     81 fema~    NA kcal/d~      -12.7 eq-11   eqs-b   
#> 5    27    20     93 male      1 kcal/d~       -1.9 eq-1    eqs-a   
#> 6    27    20     93 male      2 kcal/d~        1.9 eq-3    eqs-a   
#> 7    27    20     93 male     NA kcal/m~        3.9 eq-10   eqs-b   
#> 8    27    20     93 male     NA kcal/d~      -13.2 eq-12   eqs-b   
#> # ... with 2 more variables: reference <chr>, .source_row <int>
```

## Code of Conduct

Please note that the `equationer` project is released with a
[Contributor Code of Conduct](.github/CODE_OF_CONDUCT.md). By
contributing to this project, you agree to abide by its terms.
