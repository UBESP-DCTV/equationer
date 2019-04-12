## code to prepare `reer` dataset goes here

library(equationer)

eqs(name = "arciero_93-a", reference = "Arciero, Paul J, Goran, I., Gardner, W., Ades, P. A., Tyzbir, R. S., & Poehlman, E. T. (n.d.). A Practical Equation to Predict Resting Metabolic Rate in Older Men, 8.",

    eq(name = "arciero_93-a", outcome = "rmr",
        intercept = (7.8 + 143.5), height = 4.7, menopausal = -39.5
    )

)



eqs(name = "arciero_93-b", reference = "Arciero, Paul J, Goran, I., Gardner, W., Ades, P. A., Tyzbir, R. S., & Poehlman, E. T. (n.d.). A Practical Equation to Predict Resting Metabolic Rate in Older Men, 8.",

    eq(name = "arciero_93-b", outcome = "rmr", strata = list(),
        intercept = 1060, weight = 9.7, mean_chest_skinfold = -6.1, age = -1.8, lta = 0.1
    )

)



eqs(name = "bernstein_83", reference = "",

    eq(name = "bernstein_83-m", outcome = "rmr", strata = list(sex = "male"),
        intercept = -1032, weight = 11.2, height = 10.23, age = -5.8
    ),

    eq(name = "bernstein_83-f", outcome = "rmr", strata = list(sex = "female"),
        intercept = -1032, weight = 11.2, height = 10.23, age = -5.8
    )

)






eqs(name = "", reference = "", strata = list(),

    eq(name = "", outcome = "",
        intercept = 0,
    )

)


# reer <- eqs_bag(...
#       name = "ubesp-reer",
#       reference = "Gragori et al, Review of Equations of Energy Requirements - 2019"
# )

# usethis::use_data("reer")
