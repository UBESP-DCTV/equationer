# equationer 0.1.2

* fix a bug which prevent to `eqs()` to create a set of equations if
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
