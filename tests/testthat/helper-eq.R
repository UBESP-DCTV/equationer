
# Equations -------------------------------------------------------


eq_test <- eq(age = 0.5, bmi = -0.3,
    name    = "eq_test",
    outcome = "kcal/day"
)


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

eq5 <- eq(age = 0.3, bmi = -0.3, weight = 0.1,     # add one cov wrt eq1
    name = "cl_test_5",
    outcome = "kcal/day",
    strata = list(sex = "female", nyha = 2)
)

eq6 <- eq(age = 0.5, bmi = -0.5,                 # change strata wrt eq1
    name = "cl_test_6",
    outcome = "kcal/day",
    strata = list(sex = "male", mellitus = "yes")
)

eq7 <- eq(age = -0.3, bmi = 0.3,                   # change name wrt eq1
    name = "cl_test_7",
    outcome = "kcal/day",
    strata = list(sex = "male", nyha = 1)
)

eq8 <- eq(age = -0.5, bmi = 0.5,                # change outcome wrt eq1
    name = "cl_test_8",
    outcome = "kcal/month",
    strata = list(sex = "male", nyha = 1)
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


# Equations groups ------------------------------------------------


eqs_test <- eqs(eq1, eq2, eq3, eq4,
    name = "eqs-test",
    reference = "ref-1"
)

eqs_noref <- eqs(eq1, eq2, eq3, eq4, name = "eqs-test")

eqs1 <- eqs(eq1, eq2, eq3, eq4,
    name = "eqs1",
    reference = "ref-a"
)

eqs2 <- eqs(eq9, eq10, eq11, eq12,
    name = "eqs2",
    reference = "ref-b"
)

eqs2_samename <- eqs(eq9, eq10, eq11, eq12,          # same name as eqs1
    name = "eqs1",
    reference = "ref-b"
)



# Evaluations -----------------------------------------------------

var_output <- c(
    "age", "bmi", "sex", "nyha", "outcome", "estimation", "eq_name",
    "eq_group", "reference"
)
var_output_weight <- c(
    "age", "bmi", "weight", "sex", "nyha", "outcome", "estimation",
    "eq_name", "eq_group", "reference"
)

evaluated  <- evaluate_at(eq_test, age = 38, bmi = 18)
evaluated1 <- evaluate_at(eq_test, age = 38, bmi = 18, weight = 81)

evaluated2 <- evaluate_at(eq1, age = 38, bmi = 18)

evaluateds  <- evaluate_at(eqs_test, age = 38, bmi = 18)
evaluateds1 <- evaluate_at(eqs_test, age = 38, bmi = 18, weight = 81)
evaluateds2 <- evaluate_at(eqs_test, age = 38, bmi = 18, sex = "female")
evaluateds3 <- evaluate_at(eqs_test, age = 38, bmi = 18, .outcome = "kcal/day")
evaluateds4 <- evaluate_at(eqs_test, age = 38, bmi = 18, sex = "female", .outcome = "kcal/day")



# Bag of set of equations -----------------------------------------

eqs_bag_test <- eqs_bag(eqs1, eqs2,
    name = "overall-bag",
    reference = "equationer-test-bag"
)
