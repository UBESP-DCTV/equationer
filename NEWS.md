# equationer 0.3.1

* fix a bug that prevent the join of the partial tables if full strata
  are provided and some partial results were evaluated without any
  real results (0-row df)
* hotfix wrong coefficient in Muller04-a

# equationer 0.3.0

* updated the Shiny interface
* bugfix converting logical to character in the `reer` data to prevent a
  joining error
* removed computable covariates from shiny (and internally compute and
  use them showing output value if useful)
* bugfix for intercept considered internally as strata 
* implemented and checked all the equaitons (#5)

# equationer (development version)

* Hotfix for menopausal in shiny that still constant

# equationer 0.2.2

* restyle shiny UI 
* update shiny text for usage explanation
* bugfix errors and messages in shiny (#13)

# equationer 0.2.1

* Shiny messages bug fixes

# equationer 0.2.0

* added warning if not sufficient input are supplied (#11)
* remove the needs to provide the intercept
* fix bug found by DB that prevents `evaluate_at()` to work if
  no strata are provided to a bag (#10)
* fix bug that prevents `evaluate_at()` to work if data supplied 
  strata not in the eqs_bag.

# equationer 0.1.3

* fix bug which prevent `evaluate_at()` to works with bag which include
  equations group which differ in variables that match the same regexpr,
  e.g, "weight" and "weight_adjusted" both match the regexpr "weight".

# equationer 0.1.2

* fix a bug which prevents `eqs()` to create a set of equations if
  they have no strata at all.

# equationer 0.1.1

* Updated README 
* print methods.

# equationer 0.1.0

* Support for data frame in put in `evaluate_at.eqs_bag()`
* Added `eqs_bag` class, constructor, extractors, and main methods,
  to collect equations from the same "reference" and evaluate them
  together;
* Updated tests moving all the data in `test/testthat/helper-eq.R`.

# equationer (development version)

* Added `eqs` class including constructor, extractors and main methods,
  to collect equations from the same "reference" and evaluate them
  together;
* Changed strata atributes to list of factors;
* Added support for tidy evaluation (`rlang` pkg main utilities).

# equationer 0.0.0.9001

* Added basic methods for class `eq`; 
* Added extractrs for class `eq`;
* Added `eq()` constructor for object of class `eq`;
* Added ui and utils functions;
* Insert Logo;
* update Travis.

# equationer 0.0.0.9000

* Added basic development support:
  - Contributing, issue template, support, and CoC information;
  - git + GitHub;
  - appVeyor + Travis + codecov;
  - gpl3 license;
  - testthat + roxygen2 + spellcheck;
  - `` magrittr::`%>%` `` + `tibble::tibble`;
  - `README.Rmd` + `README.md`.

* Added a `NEWS.md` file to track changes to the package.
