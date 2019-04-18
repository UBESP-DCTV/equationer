## code to prepare `reer` dataset goes here

library(equationer)


mj2kcal   <- 239.006
kj2kcal   <- 0.239006
mcal2kcal <- 1000
cal2kcal  <- 1/1000




reer <- eqs_bag(name = "reer", reference = "Gregori et.al 2019",


    # Arciero 1993 a ---------------------------------------------------

    eqs(name = "arciero_93-a", reference = "Arciero, P. J., Goran, M. I., Gardner, A. M., Ades, P. A., Tyzbir, R. S., & Poehlman, E. T. (1993). A practical equation to predict resting metabolic rate in older females. Journal of the American Geriatrics Society, 41(4), 389-395.",

        eq(name = "arciero_93-a", outcome = "rmr", strata = list(),
            intercept = (7.8 + 143.5), height = 4.7, menopausal = -39.5
        )

    ),


    # Arciero 1993 b ---------------------------------------------------

    eqs(name = "arciero_93-b", reference = "Arciero, Paul J, Goran, I., Gardner, W., Ades, P. A., Tyzbir, R. S., & Poehlman, E. T. (n.d.). A Practical Equation to Predict Resting Metabolic Rate in Older Men, 8.",

        eq(name = "arciero_93-b", outcome = "rmr", strata = list(),
            intercept = 1060, weight = 9.7, mean_chest_skinfold = -6.1, age = -1.8, lta = 0.1
        )

    ),


    # Bernstein 1983 a ---------------------------------------------------

    eqs(name = "bernstein_83-a", reference = "Bernstein, R. S., Thornton, J. C., Yang, M. U., Wang, J., Redmond, A. M., Pierson Jr, R. N., ... & Van Itallie, T. B. (1983). Prediction of the resting metabolic rate in obese patients. The American journal of clinical nutrition, 37(4), 595-602.",

        eq(name = "bernstein_83-a-m", outcome = "rmr", strata = list(sex = "male"),
            intercept = -1032, weight = 11.2, height = 10.23, age = -5.8
        ),

        eq(name = "bernstein_83-a-f", outcome = "rmr", strata = list(sex = "female"),
            intercept = -1032, weight = 11.2, height = 10.23, age = -5.8
        )

    ),

    # Bernstein 1983 b ---------------------------------------------------

    eqs(name = "bernstein_83-b", reference = "Bernstein, R. S., Thornton, J. C., Yang, M. U., Wang, J., Redmond, A. M., Pierson Jr, R. N., ... & Van Itallie, T. B. (1983). Prediction of the resting metabolic rate in obese patients. The American journal of clinical nutrition, 37(4), 595-602.",

        eq(name = "bernstein_83-b-m-sa", outcome = "rmr", strata = list(sex = "male"),
           intercept = -1079, age = +6.2, surface_area = 1372
        ),

        eq(name = "bernstein_83-b-f-sa", outcome = "rmr", strata = list(sex = "female"),
           intercept = -53,   age = -2.3, surface_area = 758
        )

    ),

    # Camps 2016 -------------------------------------------------------

    eqs(name = "camps_16", reference = "Camps, S. G., Wang, N. X., Tan, W. S. K., & Henry, C. J. (2016). Estimation of basal metabolic rate in Chinese: are the current prediction equations applicable? Nutrition Journal, 15(1), 79. https://doi.org/10.1186/s12937-016-0197-2",

        eq(name = "camps_16-m", outcome = "bmr", strata = list(sex = "male"),
            intercept = (1960 + 828) / 4.184, weight = 52.6 / 4.184
        ),

        eq(name = "camps_16-f", outcome = "bmr", strata = list(sex = "female"),
            intercept = 1960 / 4.184,         weight = 52.6 / 4.184
        )

    ),


    # Carrasco 2002 (age >= 30) ----------------------------------------

    eqs(name = "carrasco_02 (age > = 30)", reference = "Carrasco, F., Reyes, E., Nunez, C., Riedemann, K., Rimler, O., Sanchez, G., & Sarrat, G. (2002). [Resting energy expenditure in obese and non-obese Chilean subjects: comparison with predictive equations for the Chilean population]. Revista medica de Chile, 130(1), 51–60.",

        eq(name = "carrasco_02_30-m", outcome = "bmr", strata = list(sex = "male"),
            intercept = 753, weight = 11.2
        ),

        eq(name = "carrasco_02_30-f", outcome = "bmr", strata = list(sex = "female"),
            intercept = 593, weight = 10.9
        )

    ),


    # Carrasco 2002 (age 18-74)----------------------------------------------------

    eqs(name = "carrasco_02 (age 18-74)", reference = "Carrasco, F., Reyes, E., Nunez, C., Riedemann, K., Rimler, O., Sanchez, G., & Sarrat, G. (2002). [Resting energy expenditure in obese and non-obese Chilean subjects: comparison with predictive equations for the Chilean population]. Revista medica de Chile, 130(1), 51–60.",

        eq(name = "carrasco_02-m", outcome = "bmr", strata = list(sex = "male"),
            intercept = 864, weight = 11.1, age = -2.5
        ),

        eq(name = "carrasco_02-f", outcome = "bmr", strata = list(sex = "female"),
            intercept = 716, weight = 10.9, age = -2.85
        )

    ),


    # Cunningham 1980 (no age)  ------------------------------------------

    eqs(name = "cunningham_80-noage", reference = "Cunningham, J. J. (1980). A reanalysis of the factors influencing basal metabolic rate in normal adults. The American journal of clinical nutrition, 33(11), 2372-2374.",

        eq(name = "cunningham_80-noage", outcome = "bmr", strata = list(),
            intercept = 500*1000, lbm = 22*1000
        )

    ),
## in questa calcolare il LBM male LBM = (79.5 - 0.24 M - 0.15 A) x M -=- 73.2

##female LBM = (69.8 - 0.26 M - 0.12 A) x M + 73.2

    # Cunningham 1980 ---------------------------------------------------

    eqs(name = "cunningham_80", reference = "Cunningham, J. J. (1980). A reanalysis of the factors influencing basal metabolic rate in normal adults. The American journal of clinical nutrition, 33(11), 2372-2374.",

        eq(name = "cunningham_80", outcome = "bmr", strata = list(),
            intercept = 601.2*1000, lbm = 21*1000, age = -2.6*1000
        )

    ),

## in questa calcolare il LBM male LBM = (79.5 - 0.24 M - 0.15 A) x M -=- 73.2

##female LBM = (69.8 - 0.26 M - 0.12 A) x M + 73.2


    # European Communities 1993 (age 60-74) ----------------------------

    eqs(name = "eu_93 (age 60-74)", reference = "SCF (Scientific Committee for Food). (1993). Nutrient and energy intakes for the European Community. Reports of the Scientific Committee for Food, 31st Series, 248.",

        eq(name = "eu_93_60-74-m", outcome = "bmr", strata = list(sex = "male"),
            intercept = 2930 / 4.184, weight = 49.9 / 4.184
        ),

        eq(name = "eu_93_60-74-f", outcome = "bmr", strata = list(sex = "female"),
            intercept = 2880 / 4.184, weight = 38.6 / 4.184
        )

    ),


    # European Communities 1993 (age >= 75) ----------------------------

    eqs(name = "eu_93 (age >= 75)", reference = "",

        eq(name = "eu_93_75-m", outcome = "bmr", strata = list(sex = "male"),
            intercept = 3430 / 4.184, weight = 35 / 4.184
        ),

        eq(name = "eu_93_75-f", outcome = "bmr", strata = list(sex = "female"),
            intercept = 2610 / 4.184, weight = 41 / 4.184
        )

    ),


    # Frankenfield 2003 ------------------------------------------------

    eqs(name = "frankenfield_03", reference = "Frankenfield, D. C., Rowe, W. A., Smith, J. S., & Cooney, R. N. (2003). Validation of several established equations for resting metabolic rate in obese and nonobese people. Journal of the American Dietetic Association, 103(9), 1152-1159.",

        eq(name = "frankenfield_m", outcome = "rmr", strata = list(sex = "male", bmi_class = "obese"),
            intercept = 66 , adjusted_weight = 13.75, height = 5,    age = 6.76
        ),

        eq(name = "frankenfield_f", outcome = "rmr", strata = list(sex = "female", bmi_class = "obese"),
            intercept = 655, adjusted_weight = 9.56,  height = 1.85, age = 4.68
        )

    ),

## adjusted weight lo calcolo Adjusted_weight= [(actual body weight - ideal weight)x0.25]+ideal weight
## deal Body Weight (in kilograms) = 45.5 kg + 2.2 kg for each inch over 5 feet. If the wrist is 7 inches,
## the IBW remains the way it is. However, if the wrist size is more or less than 7 inches, you add or
## subtract 10% of ideal body weight respectively.

  #Frankenfield 2013-a ------------------------------------------------

    eqs(name = "frankenfield_13-a", reference = "Frankenfield, D. C. (2013). Bias and accuracy of resting metabolic rate equations in non-obese and obese adults. Clinical nutrition, 32(6), 976-982.",

        eq(name = "frankenfield_13-a-m-o", outcome = "rmr", strata = list(sex = "male", bmi_class = "obese"),
            intercept = 440 + 244, weight = 10, height = 3, age = -5
        ),
        eq(name = "frankenfield_13-a-m-no", outcome = "rmr", strata = list(sex = "male", bmi_class = "normal weight"),
            intercept = 454 + 207, weight = 10, height = 3, age = -5
        )
    ),
#Frankenfield 2013-b ------------------------------------------------

    eqs(name = "frankenfield_13-b", reference = "Frankenfield, D. C. (2013). Bias and accuracy of resting metabolic rate equations in non-obese and obese adults. Clinical nutrition, 32(6), 976-982.",


        eq(name = "frankenfield_13-b-m-no", outcome = "rmr", strata = list(sex = "male", bmi_class = "obese"),
            intercept = 838 + 230, weight = 11, age = -6
        ),
        eq(name = "frankenfield_13-b-m-o", outcome = "rmr", strata = list(sex = "male",  bmi_class = "normal weight"),
            intercept = 865 + 27,  weight = 10, age = -5
        )

    ),


    # Fredrix 1990 -----------------------------------------------------

    eqs(name = "fredrix_90", reference = "Fredrix, E. W., Soeters, P. B., Deerenberg, I. M., Kester, A. D., von Meyenfeldt, M. F., & Saris, W. H. (1990). Resting and sleeping energy expenditure in the elderly. European Journal of Clinical Nutrition, 44(10), 741–747.",

        eq(name = "fredrix_90-f", outcome = "ree", strata = list(sex = "male"),
            intercept = (1641 - 203), weight = 10.7, age = -9
        ),

        eq(name = "fredrix_90-m", outcome = "ree", strata = list(sex = "female"),
            intercept = (1641 - 2*203),   weight = 10.7, age = -9
        )

    ),

    # Gaillard 2008-a -----------------------------------------------------

    eqs(name = "gaillard_08-a (BMI > 21)", reference = "Gaillard, C., Alix, E., Sallé, A., Berrut, G., & Ritz, P. (2008). A practical approach to estimate resting energy expenditure in frail elderly people. The Journal of Nutrition Health and Aging, 12(4), 277.",

        eq(name = "gaillard_08-a-bmig21", outcome = "ree", strata = list(bmi_greater_21 = TRUE),
           intercept = 0, weight = 18.84
        ),
        eq(name = "gaillard_08-a-nbmig21", outcome = "ree", strata = list(bmi_greater_21 = FALSE),
           intercept = 0, weight = 22.29
        )
    ),

    # # Gaillard 2008-b -----------------------------------------------------
    # questa è scritta giusta così! però mi dà dei risultati bassissimi, nel paper sembra dare risultati corretti
    # Model 2a 82.6 - 9.5 x weight (kg) + 6,5 x height (cm) - 6.1 x age
    # eqs(name = "gaillard_08-b", reference = "Gaillard, C., Alix, E., Sallé, A., Berrut, G., & Ritz, P. (2008). A practical approach to estimate resting energy expenditure in frail elderly people. The Journal of Nutrition Health and Aging, 12(4), 277.",
    #
    #     eq(name = "gaillard_08-b", outcome = "ree", strata = list(),
    #        intercept = 82.6, weight = -9.5, height = 6.5, age = -6.1
    #     )
    #
    # ),

    # Gaillard 2008-c -----------------------------------------------------

    eqs(name = "gaillard_08-c", reference = "Gaillard, C., Alix, E., Sallé, A., Berrut, G., & Ritz, P. (2008). A practical approach to estimate resting energy expenditure in frail elderly people. The Journal of Nutrition Health and Aging, 12(4), 277.",

        eq(name = "gaillard_08-c", outcome = "ree", strata = list(),
           intercept = 497, weight = 11.6
        )

    ),

    # Ganpule 2007 ------------------------------------------------------

    eqs(name = "ganpule_07", reference = "Ganpule, A. A., Tanaka, S., Ishikawa-Takata, K., & Tabata, I. (2007). Interindividual variability in sleeping metabolic rate in Japanese subjects. European Journal of Clinical Nutrition, 61(11), 1256.",

        eq(name = "ganpule_07-m", outcome = "rmr", strata = list(sex = "male"),
           intercept = (0123.8 - 547.3) / 4.184,   weight = 48.1 / 4.184, height = 23.4 / 4.184, age = -013.8 / 4.184
        ),
        eq(name = "ganpule_07-f", outcome = "rmr", strata = list(sex = "female"),
           intercept = (123.8 - 2*547.3) / 4.184, weight = 48.1 / 4.184, height = 23.4 / 4.184, age = -13.8 / 4.184
        )

    ),

    # Author Henry 2005 (age > 60 years) ------------------------------------------------------

    eqs(name = "henry_05-a (age > 60 years)", reference = "Henry, C. J. K. (2005). Basal metabolic rate studies in humans: measurement and development of new equations. Public health nutrition, 8(7a), 1133-1152.",

        eq(name = "henry_05-a-m", outcome = "rmr", strata = list(sex = "male"),
           intercept = -256, weight = 11.4, height = 541
        ),
        eq(name = "henry_05-a-f", outcome = "rmr", strata = list(sex = "female"),
           intercept = 10.7, weight = 8.52, height = 421
        )
    ),


    # Author Henry 2005 (60-70 years) ------------------------------------------------------

    eqs(name = "henry_05-b (60-70 years)", reference = "Henry, C. J. K. (2005). Basal metabolic rate studies in humans: measurement and development of new equations. Public health nutrition, 8(7a), 1133-1152.",

        eq(name = "henry_05-b-m", outcome = "rmr", strata = list(sex = "male"),
           intercept = -1070 / 4.184, weight = 0.0543 / 4.184, height = 22.6 / 4.184
        ),
        eq(name = "henry_05-b-f", outcome = "rmr", strata = list(sex = "female"),
           intercept = 45 / 4.184,    weight = 35.6 / 4.184,   height = 17.6 / 4.184
        )
    ),




  #   # Heymsfield 2006-a (???60 years)------------------------------------------------------
  #
  #   eqs(name = "heymsfield_06-a (???60 years)", reference = "Heymsfield, S. B., Harp, J. B., Rowell, P. N., Nguyen, A. M., & Pietrobelli, A. (2006). How much may I eat? Calorie estimates based upon energy expenditure prediction equations. obesity reviews, 7(4), 361-370.",
  #
  #       eq(name = "heymsfield_06_60-a-m", outcome = "ree", strata = list(sex = "male", age_greater_60 = TRUE),
  #          intercept = 587.7, weight = 11.711
  #       ),
  #
  #       eq(name = "heymsfield_06_60-a-f", outcome = "ree", strata = list(sex = "female", age_greater_60 = TRUE),
  #          intercept = 658.5, weight = 9.082
  #       )
  #
  #   ),
  #
  #
  # # Heymsfield 2006-b (???60 years) ------------------------------------------------------
  #
  #     eqs(name = "heymsfield_06-b (???60 years)", reference = "Heymsfield, S. B., Harp, J. B., Rowell, P. N., Nguyen, A. M., & Pietrobelli, A. (2006). How much may I eat? Calorie estimates based upon energy expenditure prediction equations. obesity reviews, 7(4), 361-370.",
  #
  #         eq(name = "heymsfield_06_60-b-m", outcome = "ree", strata = list(sex = "male", age_greater_60 = TRUE),
  #            intercept = 293, weight = 10.12, age = -3.8,  height = 456.4
  #         ),
  #
  #         eq(name = "heymsfield_06_60-b-f", outcome = "ree", strata = list(sex = "female", age_greater_60 = TRUE),
  #            intercept = 247, weight = 8.6,   age = -2.67, height = 401.4
  #         )
  #
  #     ),


    # Huang 2014 ------------------------------------------------------

    eqs(name = "huang_14", reference = "Huang, K. C., Kormas, N., Steinbeck, K., Loughnan, G., & Caterson, I. D. (2004). Resting metabolic rate in severely obese diabetic and nondiabetic subjects. Obesity research, 12(5), 840-845.",

        eq(name = "huang_14-m-d", outcome = "rmr", strata = list(sex = "male", diabetic = TRUE),
           intercept = (71.767 + 257.293 + 145.959), age = -2.337, height = 4.132, weight = 9.996
        ),

        eq(name = "huang_14-m-nd", outcome = "rmr", strata = list(sex = "male", diabetic = FALSE),
           intercept = (71.767 + 257.293),           age = -2.337, height = 4.132, weight = 9.996
        ),

        eq(name = "huang_14-f-nd", outcome = "rmr", strata = list(sex = "female", diabetic = FALSE),
           intercept = (71.767 + 257.293),           age = -2.337, height = 4.132, weight = 9.996
        ),

        eq(name = "huang_14-f-d", outcome = "rmr", strata = list(sex = "female", diabetic = TRUE),
           intercept = (71.767 + 257.293 + 145.959), age = -2.337, height = 4.132, weight = 9.996
        )

    ),



    # Ikeda 2013 ------------------------------------------------------

    eqs(name = "ikeda_13", reference = "Ikeda, K., Fujimoto, S., Goto, M., Yamada, C., Hamasaki, A., Ida, M., ... & Inagaki, N. (2013). A new equation to estimate basal energy expenditure of patients with diabetes. Clinical nutrition, 32(5), 777-782.",

        eq(name = "ikeda_13-m", outcome = "bee", strata = list(sex = "male"),
           intercept = (750 + 125), weight = 10, age = -3
        ),

        eq(name = "ikeda_13-f", outcome = "bee", strata = list(sex = "female"),
           intercept = 750,         weight = 10, age = -3
        )

    ),


    # IOM 2005 ------------------------------------------------------
    ## in questa capire come mettere il PAL====================================== NON SI PUÒ AL MOMENTO (poi... non so cosa sia pal...)

    # ##PAL = 1 if sedentary, 1.11 if low active, 1.25 if active, and 1.48 if very active
    # eqs(name = "iom_05-m-normopeso", reference = "",
    #
    #     eq(name = "iom_05-m-n", outcome = "eer", strata = list(sex = "male", normopeso = TRUE),
    #        intercept = 661.8, age = -9.53, weight = 15.91*PAL, height = 5.396
    #     ),
    #
    #     eq(name = "iom_05-m-n", outcome = "eer", strata = list(sex = "female", normopeso = TRUE),
    #        intercept = 354.1, age = -6.91, weight = 9.36*PAL, height = 7.26
    #     ),
    #
    #     eq(name = "iom_05-m-s", outcome = "eer", strata = list(sex = "male", sovrapeso = TRUE),
    #            intercept = 1085.6, age = -10.08, weight = 13.7*PAL, height = 4.16
    #         ),
    #
    #     eq(name = "iom_05-m-n", outcome = "eer", strata = list(sex = "female", sovrapeso = TRUE),
    #            intercept = 354.1, age = -7.95, weight = 11.4*PAL, height = 6.19
    #         )
    #
    # ),

    # Ireton-Jones 1989 ------------------------------------------------------

    eqs(name = "ireton_89", reference = "Ireton-Jones, C. S. (1989). Invited Review: Evaluation of Energy Expenditures in Obese Patients. Nutrition in Clinical Practice, 4(4), 127-129.",

        eq(name = "ireton_89-o", outcome = "eee", strata = list(bmi_class = "obese"),
           intercept = (629 - 609), age = -11, weight = 25
        ),
        eq(name = "ireton_89-no", outcome = "eee", strata = list(bmi_class = "normal weight"),
           intercept = 629,         age = -11, weight = 25
        )

    ),



    # Jia 1999 ------------------------------------------------------

    eqs(name = "jia_99-a", reference = "",

        eq(name = "jia_99-a-kcal-m", outcome = "bee", strata = list(sex = "male"),
           intercept = 696,  weight = 13.6, age = -6
        ),
        eq(name = "jia_99-a-kcal/d-m", outcome = "bmr", strata = list(sex = "male"),
           intercept = 2912 / 4.184, weight = 56.9 / 4.184, age = -25.1 / 4.184
        )
    ),



    # Jia 1999 ------------------------------------------------------

    eqs(name = "jia_99-b", reference = "",

        eq(name = "jia_99-b-f-bee", outcome = "bee", strata = list(sex = "female"),
           intercept = 714,  weight = 6.8
        ),
        eq(name = "jia_99-b-f-bmr", outcome = "bmr", strata = list(sex = "female"),
           intercept = 2987 / 4.184, weight = 28.4 / 4.184
        )
    ),



    # Kashiwazaki 1988 ------------------------------------------------------

    eqs(name = "kashiwazaki_88", reference = "KASHIWAZAKI, H., SUZUKI, T., & INAOKA, T. (1988). Postprandial resting metabolic rate and body composition in the moderately obese and normal-weight adult subjects at sitting posture. Journal of nutritional science and vitaminology, 34(4), 399-411.",

        eq(name = "kashiwazaki_88", outcome = "rmr", strata = list(),
           intercept = 350.6, weight = 22.7, subscapular_skinfold = 13.6
        )

    ),

    # Korth 2007 ------------------------------------------------------

    eqs(name = "korth_07-a", reference = "Korth, O., Bosy-Westphal, A., Zschoche, P., Gl?er, C. C., Heller, M., & M?ller, M. J. (2007). Influence of methods used in body composition analysis on the prediction of resting energy expenditure. European journal of clinical nutrition, 61(5), 582.",

        eq(name = "korth_07-a-m", outcome = "ree", strata = list(sex = "male"),
           intercept = (-1731.2 + 1107.4), weight = 41.5, age = -19.1, height = 35.0
        ),
        eq(name = "korth_07-a-f", outcome = "ree", strata = list(sex = "female"),
           intercept = (-1731.2),          weight = 41.5, age = -19.1, height = 35.0
        )
    ),

    # Korth 2007 ------------------------------------------------------

    eqs(name = "korth_07-b", reference = "Korth, O., Bosy-Westphal, A., Zschoche, P., Gl?er, C. C., Heller, M., & M?ller, M. J. (2007). Influence of methods used in body composition analysis on the prediction of resting energy expenditure. European journal of clinical nutrition, 61(5), 582.",

        eq(name = "korth_07-b", outcome = "ree", strata = list(),
           intercept = 2284, weight = 65.6
        )

    ),


    # Kruizenga 2016 ------------------------------------------------------

    eqs(name = "kruizenga_16", reference = "Kruizenga, H. M., Hofsteenge, G. H., & Weijs, P. J. (2016). Predicting resting energy expenditure in underweight, normal weight, overweight, and obese adult hospital patients. Nutrition & metabolism, 13(1), 85.",

        eq(name = "kruizenga_16-m", outcome = "ree", strata = list(sex = "male", bmi_class = "normal weight"),
           intercept = (-137.475 + 132.265), weight = 11.35, height = 7.224, age = -4.469
        ),

        eq(name = "kruizenga_16-f", outcome = "ree", strata = list(sex = "female", bmi_class = "normal weight"),
           intercept = (-137.475),           weight = 11.35, height = 7.224, age = -4.469
        )

    ),



    # Lam 2014 ------------------------------------------------------

    eqs(name = "lam_14-m", reference = "Lam, Y. Y., Redman, L. M., Smith, S. R., Bray, G. A., Greenway, F. L., Johannsen, D., & Ravussin, E. (2014). Determinants of sedentary 24-h energy expenditure: equations for energy prescription and adjustment in a respiratory chamber. The American journal of clinical nutrition, 99(4), 834-842.",

        eq(name = "lam_14-m-a", outcome = "eee", strata = list(sex = "male", ethnicity = "african american"),
            intercept = (-235 + 217 - 52), weight = 11.6, height = 8.03, age = -3.45
        ),

        eq(name = "lam_14-m-w", outcome = "eee", strata = list(sex = "male", ethnicity = "white"),
            intercept = (-235 + 217),      weight = 11.6, height = 8.03, age = -3.45
        ),

        eq(name = "lam_14-f-a", outcome = "eee", strata = list(sex = "female", ethnicity = "african american"),
            intercept = (-235 - 52),       weight = 11.6, height = 8.03, age = -3.45
        ),

        eq(name = "lam_14-f-w", outcome = "eee", strata = list(sex = "female", ethnicity = "white"),
            intercept = -235,              weight = 11.6, height = 8.03, age = -3.45
        )
    ),


    # Lazzer 2007-a ------------------------------------------------------

    eqs(name = "lazzer_07-a", reference = "Lazzer, S., Agosti, F., Resnik, M., Marazzi, N., Mornati, D., & Sartorio, A. (2007). Prediction of resting energy expenditure in severely obese Italian males. Journal of endocrinological investigation, 30(9), 754-761.",

        eq(name = "lazzer_07-a-kcal", outcome = "ree", strata = list(),
           intercept = -3.605 * 239.006, weight = 0.048 * 239.006, height = 4.655 * 239.006, age = -0.020 * 239.006
        )
    ),



    # Lazzer 2007-b ------------------------------------------------------
# ree=weight*0.042+height*3.619-2.678

    eqs(name = "lazzer_07-b", reference = "Lazzer, S., Agosti, F., Resnik, M., Marazzi, N., Mornati, D., & Sartorio, A. (2007). Prediction of resting energy expenditure in severely obese Italian males. Journal of endocrinological investigation, 30(9), 754-761.",

        eq(name = "lazzer_07-b", outcome = "ree", strata = list(sex = "female", bmi = "obese"),
           intercept = -2.678 * 239.006, weight = 0.042 * 239.006, height = 3.619 * 239.006
        )
    ),



    # Lazzer 2010 ------------------------------------------------------

    eqs(name = "lazzer_07-c", reference = "Lazzer, S., Agosti, F., Silvestri, P., Derumeaux-Burel, H., & Sartorio, A. (2007). Prediction of resting energy expenditure in severely obese Italian women. Journal of endocrinological investigation, 30(1), 20-27.",

        eq(name = "lazzer_07-c-m", outcome = "bmr", strata = list(sex = "male"),
           intercept = (1.140 + 3.252) * 239.006, weight = 0.046 * 239.006, height = 3.619 * 239.006, age = -0.014 * 239.006
        ),

        eq(name = "lazzer_07-c-f", outcome = "bmr", strata = list(sex = "female"),
           intercept = 1.140 * 239.006,          weight = 0.046 * 239.006, height = 3.619 * 239.006, age = -0.014 * 239.006
        )
    ),



    # Leung 2000 ------------------------------------------------------

    eqs(name = "leung_00", reference = "Leung, R., Woo, J., Chan, D., & Tang, N. (2000). Validation of prediction equations for basal metabolic rate in Chinese subjects. European journal of clinical nutrition, 54(7), 551.",

        eq(name = "leung_00", outcome = "ree", strata = list(),
           intercept = 3350.2 / 4.184, weight = 57.562 / 4.184, age = -26.795 / 4.184
        )

    ),



    # Liu 1995-a ------------------------------------------------------

    eqs(name = "liu_95-a-weight-age", reference = "Liu, H. Y., Lu, Y. F., & Chen, W. J. (1995). Predictive equations for basal metabolic rate in Chinese adults: a cross-validation study. Journal of the American Dietetic Association, 95(12), 1403–1408. https://doi.org/10.1016/S0002-8223(95)00369-X",

        eq(name = "liu_95-a-m", outcome = "bmr", strata = list(sex = "male"),
           intercept = (54.34),          weight = 13.88, height =  4.16, age = -3.43
        ),
        eq(name = "liu_95-a-f", outcome = "bmr", strata = list(sex = "female"),
           intercept = (54.34 + 112.40), weight = 13.88, height =  4.16, age = -3.43
        )

    ),



    # Liu 1995-b ------------------------------------------------------

    eqs(name = "liu_95-b-weight", reference = "Liu, H. Y., Lu, Y. F., & Chen, W. J. (1995). Predictive equations for basal metabolic rate in Chinese adults: a cross-validation study. Journal of the American Dietetic Association, 95(12), 1403–1408. https://doi.org/10.1016/S0002-8223(95)00369-X",

        eq(name = "liu_95-b", outcome = "bmr", strata = list(ethnicity = "chinese"),
           intercept = 29.34, weight = 20.29
        )

    ),



    # Liu 1995-c ------------------------------------------------------

    eqs(name = "liu_95-c", reference = "Liu, H. Y., Lu, Y. F., & Chen, W. J. (1995). Predictive equations for basal metabolic rate in Chinese adults: a cross-validation study. Journal of the American Dietetic Association, 95(12), 1403–1408. https://doi.org/10.1016/S0002-8223(95)00369-X",

        eq(name = "liu_95-c", outcome = "bmr", strata = list(),
           intercept = -1506.60, weight = 13.51, height = 11.93
        )

    ),



    # Liu 1995-c ------------------------------------------------------

    eqs(name = "liu_95-d", reference = "Liu, H. Y., Lu, Y. F., & Chen, W. J. (1995). Predictive equations for basal metabolic rate in Chinese adults: a cross-validation study. Journal of the American Dietetic Association, 95(12), 1403–1408. https://doi.org/10.1016/S0002-8223(95)00369-X",

        eq(name = "liu_95-d-m", outcome = "bmr", strata = list(sex = "male"),
           intercept = 755.30,            weight = 14.73, height =  4.16, age = -3.87
        ),
        eq(name = "liu_95-d-f", outcome = "bmr", strata = list(sex = "female"),
           intercept = (755.30 - 150.90), weight = 14.73, height =  4.16, age = -3.87
        )


    ),



    # Livingston & Kohlstadt 2005-a  ----------------------------------------

    eqs(name = "livingston_05-a", reference = "Livingston, E. H., & Kohlstadt, I. (2005). Simplified resting metabolic rate—predicting formulas for normal‐sized and obese individuals. Obesity research, 13(7), 1255-1262.",

        eq(name = "livingston_05-a-f", outcome = "rmr", strata = list(sex = "female"),
           intercept = 0, weight = 248^0.4356 , age = -5.09
        ),

        eq(name = "livingston_05-a-m", outcome = "rmr", strata = list(sex = "male"),
           intercept = 0, weight = 293^0.4330 , age = -5.92
        )

    ),



    # Livingston & Kohlstadt 2005-b  ----------------------------------------

    eqs(name = "livingston_05-b", reference = "Livingston, E. H., & Kohlstadt, I. (2005). Simplified resting metabolic rate—predicting formulas for normal‐sized and obese individuals. Obesity research, 13(7), 1255-1262.",

        eq(name = "livingston_05-b-f", outcome = "rmr", strata = list(sex = "female"),
           intercept = 0, weight = 196^0.4613
        ),

        eq(name = "livingston_05-b-m", outcome = "rmr", strata = list(sex = "male"),
           intercept = 0, weight = 246^0.4473
        )

    ),


    # Livingston & Kohlstadt 2005-c  ----------------------------------------

    eqs(name = "livingston_05-c", reference = "Livingston, E. H., & Kohlstadt, I. (2005). Simplified resting metabolic rate—predicting formulas for normal‐sized and obese individuals. Obesity research, 13(7), 1255-1262.",

        eq(name = "livingston_05-c", outcome = "rmr", strata = list(),
           intercept = 0, weight = 202^0.4722
        )

    ),



    # Livingston & Kohlstadt 2005-d  ----------------------------------------

    eqs(name = "livingston_05-d", reference = "Livingston, E. H., & Kohlstadt, I. (2005). Simplified resting metabolic rate—predicting formulas for normal‐sized and obese individuals. Obesity research, 13(7), 1255-1262.",

        eq(name = "livingston_05-d", outcome = "rmr", strata = list(),
           intercept = 0, weight = 261^0.4456, age = -6.52
        )

    ),



    # Lührmann 2002-a ------------------------------------------------------

    eqs(name = "lührmann_02-a", reference = "Lührmann, P. M., Herbert, B. M., Krems, C., & Neuhäuser-Berthold, M. (2002). A new equation especially developed for predicting resting metabolic rate in the elderly for easy use in practice. European Journal of Nutrition, 41(3), 108–113. https://doi.org/10.1007/s003940200016",

        eq(name = "lührmann_02-a", outcome = "rmr", strata = list(),
           intercept = 1238 / 4.184, weight = 66.4 / 4.184
        )

    ),




    # Lührmann 2002-b ------------------------------------------------------

    eqs(name = "lührmann_02-b", reference = "Lührmann, P. M., Herbert, B. M., Krems, C., & Neuhäuser-Berthold, M. (2002). A new equation especially developed for predicting resting metabolic rate in the elderly for easy use in practice. European Journal of Nutrition, 41(3), 108–113. https://doi.org/10.1007/s003940200016",

        eq(name = "lührmann_02-b-m", outcome = "rmr", strata = list(sex = "male"),
           intercept = (3169 + 746) / 4.184, weight = 50.0 / 4.184, age = -15.3 / 4.184
        ),

        eq(name = "lührmann_02-a-f", outcome = "rmr", strata = list(sex = "female"),
           intercept = 3169 / 4.184,         weight = 50.0 / 4.184, age = -15.3 / 4.184
        )

    ),



    # Lührmann 2002-c ------------------------------------------------------

    eqs(name = "lührmann_02-c", reference = "Lührmann, P. M., Herbert, B. M., Krems, C., & Neuhäuser-Berthold, M. (2002). A new equation especially developed for predicting resting metabolic rate in the elderly for easy use in practice. European Journal of Nutrition, 41(3), 108–113. https://doi.org/10.1007/s003940200016",

        eq(name = "lührmann_02-c-m", outcome = "rmr", strata = list(sex = "male"),
           intercept = (2078 + 751) / 4.184, weight = 50.8 / 4.184
        ),

        eq(name = "lührmann_02-c-f", outcome = "rmr", strata = list(sex = "female"),
           intercept = 2078 / 4.184,         weight = 50.8 / 4.184
        )

    ),




# # Metsios 2008 ------------------------------------------------------
# ## controlalare che sia scritta giusta, sono tutte moltiplicazioni!
#     eqs(name = "metsios_08", reference = "Metsios, G. S., Stavropoulos-Kalinoglou, A., Panoulas, V. F., Koutedakis, Y., Nevill, A. M., Douglas, K. M., ... & Kitas, G. D. (2008). New resting energy expenditure prediction equations for patients with rheumatoid arthritis. Rheumatology, 47(4), 500-506.",
#
#         eq(name = "metsios_08", outcome = "ree", strata = list(),
#            intercept = 0, weight =  598.8^0.47(age^(-0.29))(crp^0.066)
#         )
#
#     ),




    # Mifflin 1990-a ------------------------------------------------------

    eqs(name = "mifflin_90-a", reference = "Mifflin, M. D., St Jeor, S. T., Hill, L. A., Scott, B. J., Daugherty, S. A., & Koh, Y. O. (1990). A new predictive equation for resting energy expenditure in healthy individuals. The American journal of clinical nutrition, 51(2), 241-247.",

        eq(name = "mifflin_90-a-m", outcome = "rmr", strata = list(sex = "male"),
           intercept = (5 + 166), weight = 9.99, height = 6.25,  age = -4.92
        ),

        eq(name = "mifflin_90-a-f", outcome = "rmr", strata = list(sex = "female"),
           intercept = 5,         weight = 9.99, height =  6.25, age = -4.92
        )

    ),



    # Mifflin 1990-b ------------------------------------------------------

    eqs(name = "mifflin_90-b", reference = "Mifflin, M. D., St Jeor, S. T., Hill, L. A., Scott, B. J., Daugherty, S. A., & Koh, Y. O. (1990). A new predictive equation for resting energy expenditure in healthy individuals. The American journal of clinical nutrition, 51(2), 241-247.",

        eq(name = "mifflin_90-b-m", outcome = "rmr", strata = list(sex = "male"),
           intercept = 5,    weight = 10, height = 6.25, age = -5
        ),

        eq(name = "mifflin_90-b-f", outcome = "rmr", strata = list(sex = "female"),
           intercept = -161, weight = 10, height = 6.25, age = -5
        )

    ),



    # Mifflin 1990-c ------------------------------------------------------

    eqs(name = "mifflin_90-c", reference = "Mifflin, M. D., St Jeor, S. T., Hill, L. A., Scott, B. J., Daugherty, S. A., & Koh, Y. O. (1990). A new predictive equation for resting energy expenditure in healthy individuals. The American journal of clinical nutrition, 51(2), 241-247.",

        eq(name = "mifflin_90-c-f", outcome = "bmr", strata = list(sex = "female"),
           intercept = -674 / 4.184, weight = 41.8 / 4.184, height =  26.2 / 4.184, age = -20.6 / 4.184
        ),
        eq(name = "mifflin_90-c-m", outcome = "bmr", strata = list(sex = "male"),
           intercept = 21 / 4.184,   weight = 41.8 / 4.184, height =  26.2 / 4.184, age = -20.6 / 4.184
        )

    ),

    # Miller 2014 ------------------------------------------------------

    eqs(name = "miller_14", reference = "Miller equation (Ng Z., Yaxley A., Miller M., 2014, unpublishedresults)",
        eq(name = "miller_14-m", outcome = "ree", strata = list(sex = "male"),
           intercept = 282.630 / 4.184,             age = -15.124 / 4.184, height = 24.481 / 4.184, weight = 31.870 / 4.184
        ),
        eq(name = "miller_14-f", outcome = "ree", strata = list(sex = "female"),
           intercept = (282.630 + 243.226) / 4.184, age = -15.124 / 4.184, height = 24.481 / 4.184, weight = 31.870 / 4.184
        )
    ),



    # Moore & Angelillo 1988 ------------------------------------------------------

    eqs(name = "moore_88", reference = "Moore, J. A., & Angelillo, V. A. (1988). Equations for the prediction of resting energy expenditure in chronic obstructive lung disease. Chest, 94(6), 1260-1263.",

        eq(name = "moore_88-m", outcome = "ree", strata = list(sex = "male"),
           intercept = 952, weight = 11.5
        ),
        eq(name = "moore_88-f", outcome = "ree", strata = list(sex = "female"),
           intercept = 515, weight = 14.1
        )

    ),



    # Muller 2004-a ------------------------------------------------------

    eqs(name = "muller_04-a", reference = "Manfred J Müller, Anja Bosy-Westphal, Susanne Klaus, Georg Kreymann, Petra M Lührmann, Monika Neuhäuser-Berthold, Rudolf Noack, Karl M Pirke, Petra Platte, Oliver Selberg, Jochen Steiniger, World Health Organization equations have shortcomings for predicting resting energy expenditure in persons from a modern, affluent population: generation of a new reference standard from a retrospective analysis of a German database of resting energy expenditure, The American Journal of Clinical Nutrition, Volume 80, Issue 5, November 2004, Pages 1379–1390, https://doi.org/10.1093/ajcn/80.5.1379",

        eq(name = "muller_04-a-m", outcome = "ree", strata = list(sex = "male"),
           intercept = (3210 + 1009) / 4.184, weight = 47 / 4.184, age = -14.52 / 4.184
        ),

        eq(name = "muller_04-a-f", outcome = "ree", strata = list(sex = "female"),
           intercept = 3210 / 4.184,           weight = 47 / 4.184, age = -14.52 / 4.184
        )
    ),


    # Muller 2004-b ------------------------------------------------------

    eqs(name = "muller_04-b", reference = "Manfred J Müller, Anja Bosy-Westphal, Susanne Klaus, Georg Kreymann, Petra M Lührmann, Monika Neuhäuser-Berthold, Rudolf Noack, Karl M Pirke, Petra Platte, Oliver Selberg, Jochen Steiniger, World Health Organization equations have shortcomings for predicting resting energy expenditure in persons from a modern, affluent population: generation of a new reference standard from a retrospective analysis of a German database of resting energy expenditure, The American Journal of Clinical Nutrition, Volume 80, Issue 5, November 2004, Pages 1379–1390, https://doi.org/10.1093/ajcn/80.5.1379",

        eq(name = "muller_04-b-m-nw", outcome = "ree", strata = list(sex = "male", bmi_class = "normal weight"),
           intercept = (1233 +  884) / 4.184,  weight = 22.19 / 4.184, age = -21.49 / 4.184, height = 21.18 / 4.184
        ),

        eq(name = "muller_04-b-f-nw", outcome = "ree", strata = list(sex = "female", bmi_class = "normal weight"),
           intercept = 1233 / 4.184,             weight = 22.19 / 4.184, age = -21.49 / 4.184, height = 21.18 / 4.184
        )
    ),


    # Muller 2004-b ------------------------------------------------------

    eqs(name = "muller_04-c", reference = "Manfred J Müller, Anja Bosy-Westphal, Susanne Klaus, Georg Kreymann, Petra M Lührmann, Monika Neuhäuser-Berthold, Rudolf Noack, Karl M Pirke, Petra Platte, Oliver Selberg, Jochen Steiniger, World Health Organization equations have shortcomings for predicting resting energy expenditure in persons from a modern, affluent population: generation of a new reference standard from a retrospective analysis of a German database of resting energy expenditure, The American Journal of Clinical Nutrition, Volume 80, Issue 5, November 2004, Pages 1379–1390, https://doi.org/10.1093/ajcn/80.5.1379",

        eq(name = "muller_04-c-m-uw", outcome = "ree", strata = list(sex = "male", bmi_class = "underweight"),
           intercept = (731 + 820) / 4.184,    weight = 71.22 / 4.184, age = -21.49 / 4.184
        ),

        eq(name = "muller_04-c-f-uw", outcome = "ree", strata = list(sex = "female", bmi_class = "underweight"),
           intercept = 731 / 4.184,             weight = 47 / 4.184,   age = -21.49 / 4.184
        ),
        eq(name = "muller_04-c-m-ow", outcome = "ree", strata = list(sex = "male", bmi_class = "overweight"),
           intercept = (407 +  1006) / 4.184,  weight = 45.07 / 4.184, age = -15.53 / 4.184
        ),

        eq(name = "muller_04-c-f-ow", outcome = "ree", strata = list(sex = "female", bmi_class = "overweight"),
           intercept = 3407 / 4.184,             weight = 45.07 / 4.184, age = -15.53 / 4.184
        ),
        eq(name = "muller_04-c-m-o", outcome = "ree", strata = list(sex = "male", bmi_class = "obese"),
           intercept = (2924 +  1103 ) / 4.184, weight = 50 / 4.184,    age = -15.86 / 4.184
        ),
        eq(name = "muller_04-c-f-o", outcome = "ree", strata = list(sex = "female", bmi_class = "obese"),
           intercept = 2924 / 4.184,              weight = 50 / 4.184,   age = -15.86 / 4.184
        )
    ),


    # Obisesan 1997 ------------------------------------------------------
    # nyha controllare
    eqs(name = "obisesan_97", reference = "Obisesan, T. O., Toth, M. J., & Poehlman, E. T. (1997). Prediction of resting energy needs in older men with heart failure. European Journal of Clinical Nutrition, 51(10), 678-681. https://doi.org/10.1038/sj.ejcn.1600462",

        eq(name = "obisesan_97-hf", outcome = "rmr", strata = list(hf = FALSE),
           intercept = 755,       weight = 12.2, glucose_g_dl = 1.6, albumin_mg_dl = -144
        ),
        eq(name = "obisesan_97-nhf", outcome = "rmr", strata = list(hf = TRUE),
           intercept = 755 + 103, weight = 12.2, glucose_g_dl = 1.6, albumin_mg_dl = -144
        )

    ),



    # Owen 1987-a ------------------------------------------------------

    eqs(name = "owen_87-a", reference = "Owen, O. E., Holup, J. L., D’Alessio, D. A., Craig, E. S., Polansky, M., Smalley, K. J., ... & Mozzoli, M. A. (1987). A reappraisal of the caloric requirements of men. The American journal of clinical nutrition, 46(6), 875-885.",

        eq(name = "owen_87-a", outcome = "rmr", strata = list(),
           intercept = 879, weight = 10.2
        )

    ),



    # Owen 1987-b (age 18-82) ------------------------------------------------------

    eqs(name = "owen_87-b", reference = "Owen, O. E., Holup, J. L., D’Alessio, D. A., Craig, E. S., Polansky, M., Smalley, K. J., ... & Mozzoli, M. A. (1987). A reappraisal of the caloric requirements of men. The American journal of clinical nutrition, 46(6), 875-885.",

        eq(name = "owen_87-b", outcome = "rmr", strata = list(sex = "male", athletes = FALSE),
           intercept = 879, weight = 10.2
        )

    ),



    # # Pavlidou 2018-a ------------------------------------------------------
    #
    # eqs(name = "pavlidou_18-a (kcal/weight/day)", reference = "Pavlidou, E., Petridis, D., Tolia, M., Tsoukalas, N., Poultsidi, A., Fasoulas, A., . Giaginis, C. (2018). Estimating the agreement between the metabolic rate calculated from prediction equations and from a portable indirect calorimetry device: an effort to develop a new equation for predicting resting metabolic rate. Nutrition & Metabolism, 15, 41. https://doi.org/10.1186/s12986-018-0278-7",
    #
    #     eq(name = "pavlidou_18-a", outcome = "rmr", strata = list(),
    #        intercept = 0, bmi = 21.53^(-0.152)
    #     )
    #
    # ),



    # Quenouille 1951 ------------------------------------------------------

    eqs(name = "quenoille_51", reference = "",

        eq(name = "quenoille_51", outcome = "bmr", strata = list(),
           intercept = 293.8, height = 2.975, weight = 8.90, surface_area = 11.7, air_humidity = 3.0, air_temperature = -4.0
        )

    ),



    # Quiroz-Olguin 2014 ------------------------------------------------------

    eqs(name = "quiroz_14", reference = "Quiroz-Olguin, G., Serralde-Zuniga, A. E., Saldana-Morales, M. V., Gulias-Herrero, A., & Guevara-Cruz, M. (2014). Validating an energy expenditure prediction equation in overweight and obese Mexican patients. Nutricion Hospitalaria, 30(4), 749-755. https://doi.org/10.3305/nh.2014.30.4.7639",

        eq(name = "quiroz_14-m", outcome = "ree", strata = list(sex = "male"),
           intercept = -402.204,             weight = 12.204, wrist_circumference = 83.954
        ),
        eq(name = "quiroz_14-f", outcome = "ree", strata = list(sex = "female"),
           intercept = (-402.204 - 244.892), weight = 12.204, wrist_circumference = 83.954
        )
    ),

    # # Robertson & Reid 2013 ------------------------------------------------------
    #
    # eqs(name = "robertson_13", reference = "",
    #
    #     eq(name = "robertson_13", outcome = "ree", strata = list(),
    #        intercept = 0, 24 * bsa * age * specific_value
    #     )
    #
    # ),

    # Sabounchi 2013-a ------------------------------------------------------
    #da ricontrollare ? uguale alle femmine versione b
    eqs(name = "sabounchi_13-a", reference = "Sabounchi, N. S., Rahmandad, H., & Ammerman, A. (2013). Best-fitting prediction equations for basal metabolic rate: informing obesity interventions in diverse populations. International Journal of Obesity (2005), 37(10), 1364-1370. https://doi.org/10.1038/ijo.2012.218",

        eq(name = "sabounchi_13-a", outcome = "bmr", strata = list(),
           intercept = 301, weight = 10.2, height = 3.09, age = -3.09
        )

    ),
    # Sabounchi 2013-b ------------------------------------------------------

    eqs(name = "sabounchi_13-b", reference = "Sabounchi, N. S., Rahmandad, H., & Ammerman, A. (2013). Best-fitting prediction equations for basal metabolic rate: informing obesity interventions in diverse populations. International Journal of Obesity (2005), 37(10), 1364-1370. https://doi.org/10.1038/ijo.2012.218",

        eq(name = "sabounchi_f", outcome = "bmr", strata = list(sex = "female"),
           intercept = 301, weight = 10.2, height = 3.09, age = -3.09
        ),
        eq(name = "sabounchi_m", outcome = "bmr", strata = list(sex = "male"),
           intercept = 522, weight = 10.4, height = 3.19, age = -3.10
        )

    ),



    # Segura-Badilla 2018-a ------------------------------------------------------

    eqs(name = "segura_18-a", reference = "",

        eq(name = "segura_18-a-f", outcome = "ree", strata = list(sex = "female"),
           intercept = -35.95,  weight = 11.701, height = 5.75,  age = -7.824
        ),
        eq(name = "segura_18-a-m", outcome = "ree", strata = list(sex = "male"),
           intercept = 346.867, weight = 4.317,  height = 7.967, age = -10.16
        )
    ),



    # Segura-Badilla 2018-b ------------------------------------------------------

    eqs(name = "segura_18-b", reference = "",

        eq(name = "segura_18-b-f", outcome = "ree", strata = list(sex = "female"),
           intercept = -817.918, weight = 11.774, height = 7.37
        ),

        eq(name = "segura_18-b-m", outcome = "ree", strata = list(sex = "male"),
           intercept = 316.398,  weight = 4.255,  height = 7.819
        )

    ),



    # Segura-Badilla 2018-c ------------------------------------------------------
   eqs(name = "segura_18-c", reference = "",

        eq(name = "segura_18-c-f", outcome = "ree", strata = list(sex = "female"),
           intercept = 9427.775,  weight = 84.689,  height = -55.063, bmi = -174.811, age = -8.798
        ),
        eq(name = "segura_18-c-m", outcome = "ree", strata = list(sex = "male"),
           intercept = -5008.038, weight = -30.019, height = 41.687,  bmi = 95.416,   age = -13.978
        )
    ),



    # Segura-Badilla 2018-d (normalweight/overweight) ------------------------------------------------------

    eqs(name = "segura_18-d", reference = "",

        eq(name = "segura_18-d-f-nw", outcome = "ree", strata = list(sex = "female", bmi_class = "normal weight"),
           intercept = 896.249,   weight = 14.361,   height = -0.055, age = -10.389
        ),
        eq(name = "segura_18-d-f-ow", outcome = "ree", strata = list(sex = "female", bmi_class = "overweight"),
           intercept = -314.07,   weight = 17.211,   height = 4.437, age = -7.499
        ),
        eq(name = "segura_18-d-m-ow", outcome = "ree", strata = list(sex = "male", bmi_class = "overweight"),
           intercept = 19.995,    weight = 3.252,    height = 9.488, age = -7.61
        )
    ),


    # Segura-Badilla 2018-d (normalweight/overweight) ------------------------------------------------------

    eqs(name = "segura_18-e", reference = "",

        eq(name = "segura_18-e-m-nw", outcome = "ree", strata = list(sex = "male", bmi_class = "normal weight"),
           intercept = -15817.35, weight = -137.022, height = 151.717, age = 24.108, bmi = 95.416
        )
    ),



    # Schoefild 1985-a ------------------------------------------------------

    eqs(name = "schoefild_85-a", reference = "Schofield, W. N. (1985). Predicting basal metabolic rate, new standards and review of previous work. Human Nutrition. Clinical Nutrition, 39 Suppl 1, 5-41.",

        eq(name = "schoefild_85-a-m", outcome = "bmr", strata = list(sex = "male"),
           intercept = 587.7, weight = 11.711
        ),
        eq(name = "schoefild_85-a-f", outcome = "bmr", strata = list(sex = "female"),
           intercept = 658.5, weight = 9.082
        )
    ),



    # Schoefild 1985-b ------------------------------------------------------

    eqs(name = "schoefild_85-b", reference = "Schofield, W. N. (1985). Predicting basal metabolic rate, new standards and review of previous work. Human Nutrition. Clinical Nutrition, 39 Suppl 1, 5-41.",

        eq(name = "schoefild_85-b-m", outcome = "bmr", strata = list(sex = "male"),
           intercept = 17.7,   weight = 7.887, height = 4.582
        ),
        eq(name = "schoefild_85-b-f", outcome = "bmr", strata = list(sex = "female"),
           intercept = -834.4, weight = 9.082, height = 9.723
        )
    ),




    # Silver 2013 ------------------------------------------------------
    eqs(name = "silver_13", reference = "",

        eq(name = "silver_13-f", outcome = "rmr", strata = list(sex = "female"),
           intercept = 0, weight = 20.6
        ),
        eq(name = "silver_13-m", outcome = "rmr", strata = list(sex = "male"),
           intercept = 0, weight = 22.7
        )

    ),




    # Tabata 2012-a------------------------------------------------------

    # eqs(name = "tabata_12", reference = "Tabata, I., Ebine, N., Kawashima, Y., Ishikawa-Takata, K., Tanaka, S., Higuchi, M., & Yoshitake, Y. (2012). Dietary Reference Intakes for Japanese 2010: Energy. Journal of Nutritional Science and Vitaminology, 59(Supplement), S26-S35. https://doi.org/10.3177/jnsv.59.S26",
    #
    #     eq(name = "tabata_12-ref", outcome = "bmr", strata = list(),
    #        intercept = 0, referencebmr*reference_weight
    #     )
    #
    # ),

    # # Tabata 2012-b (50-69 years)------------------------------------------------------
    # # controlalre intercetta e variabili, così non hanno molto senso: probabilmebte c'è un weight da qualche parte
    # eqs(name = "tabata_12-50_69", reference = "Tabata, I., Ebine, N., Kawashima, Y., Ishikawa-Takata, K., Tanaka, S., Higuchi, M., & Yoshitake, Y. (2012). Dietary Reference Intakes for Japanese 2010: Energy. Journal of Nutritional Science and Vitaminology, 59(Supplement), S26-S35. https://doi.org/10.3177/jnsv.59.S26",
    #
    #     eq(name = "tabata_12-50_69-m", outcome = "bmr", strata = list(sex = "male"),
    #        intercept = 21.5*65.0
    #     ),
    #
    #     eq(name = "tabata_12-50_69-f", outcome = "bmr", strata = list(sex = "female"),
    #        intercept = 20.7*53.6
    #     )
    # ),



    # Weijs & Vansant 2010 ------------------------------------------------------

    eqs(name = "weijs_10", reference = "",

        eq(name = "weijs_10-m-ow", outcome = "ree", strata = list(sex = "male", bmi_class = "overweight"),
           intercept = (-221.631 + 137.566), weight = 14.038, height = 4.498, age = -0.977
        ),

        eq(name = "weijs_10-f-ow", outcome = "ree", strata = list(sex = "female", bmi_class = "overweight"),
           intercept = -221.631,             weight = 14.038, height = 4.498, age = -0.977
        ),
        eq(name = "weijs_10-m-o", outcome = "ree", strata = list(sex = "male", bmi_class = "obese"),
           intercept = (-221.631 + 137.566), weight = 14.038, height = 4.498, age = -0.977
        ),

        eq(name = "weijs_10-f-o", outcome = "ree", strata = list(sex = "female", bmi_class = "obese"),
           intercept = -221.631,             weight = 14.038, height = 4.498, age = -0.977
        )

    ),





    # Wilms 2010 ------------------------------------------------------

    eqs(name = "wilms_10", reference = "",

        eq(name = "wilms_10", outcome = "ree", strata = list(),
           intercept = 816.714, weight = 11.035, age = -3.435
        )

    ),

# FAO/WHO/ONU 1985 ------------------------------------------------------

eqs(name = "fao_who_onu_85", reference = "FAO/WHO/UNU. (1985). Energy and protein requirements. Report of a joint FAO/WHO/UNU expert consultation. (technical report service no. 724.). Geneva: FAO/WHO/UNU. Retrieved from http://www.fao.org/docrep/003/aa040e/AA040E00.htm",

    eq(name = "fao_who_onu_85-m", outcome = "ree", strata = list(sex = "male"),
       intercept = 587.7, weight = 11.711
    ),
    eq(name = "fao_who_onu_85-f", outcome = "ree", strata = list(sex = "female"),
       intercept = 658.5, weight = 9.082
    )
),

    # De Lorenzo 2001 ------------------------------------------------------

    eqs(name = "delorenzo_01", reference = "De Lorenzo, A., Tagliabue, A., Andreoli, A., Testolin, G., Comelli, M., & Deurenberg, P. (2001). Measured and predicted resting metabolic rate in Italian males and females, aged 18-59 y. European Journal of Clinical Nutrition, 55(3), 208.",

        eq(name = "delorenzo_01-m", outcome = "rmr", strata = list(sex = "male"),
           intercept = 116.34, weight = 12.73, height = 5.01, age = -5.70
        ),
        eq(name = "delorenzo_01-f", outcome = "rmr", strata = list(sex = "female"),
           intercept = 225.51, weight = 11.07, height = 3.76, age = -3.98
        )
    ),

# De Luis 2016 ------------------------------------------------------

eqs(name = "deluis_16", reference = "De Luis, D. A., Aller, R., Izaola, O., & Romero, E. (2006). Prediction equation of resting energy expenditure in an adult Spanish population of obese adult population. Annals of Nutrition and Metabolism, 50(3), 193-196.",

    eq(name = "deluis_16-m", outcome = "ree", strata = list(sex = "male"),
       intercept = 58.61, weight = 6.1, height = 10.237, age = -9.5
    ),
    eq(name = "deluis_16-f", outcome = "ree", strata = list(sex = "female"),
       intercept = 1272.5, weight = 9.8, height = 0.616, age = -8.2
    )
),


# Harris Benedict 1918 ------------------------------------------------------

eqs(name = "harris_benedict_918", reference = "Harris, J. A., & Benedict, F. G. (1918). A biometric study of human basal metabolism. Proceedings of the National Academy of Sciences of the United States of America, 4(12), 370.",

    eq(name = "harris_benedict_918-f", outcome = "rmr", strata = list(sex = "female"),
       intercept = 655, weight = 9.6, height = 1.8, age = -4.7
    ),
    eq(name = "harris_benedict_918-m", outcome = "rmr", strata = list(sex = "male"),
       intercept = 66.5, weight = 13.8, height = 5, age = -6.8
    )
),

# # Vander Weg 2004 ------------------------------------------------------
#
# eqs(name = "vander_weg_04", reference = "Vander Weg, M. W., Watson, J. M., Klesges, R. C., Eck Clemens, L. H., Slawson, D. L., & McClanahan, B. S. (2004). Development and cross-validation of a prediction equation for estimating resting  energy expenditure in healthy African-American and European-American women. European Journal of Clinical Nutrition, 58(3), 474-480. https://doi.org/10.1038/sj.ejcn.1601833",
#
#     eq(name = "vander_weg_04-aa", outcome = "ree", strata = list(ethnicity = "african american"),
#        intercept = 147.45 - 64.98, weight = 8.39, height = 4.74, age = -3.56
#     ),
#     eq(name = "vander_weg_04-ea", outcome = "ree", strata = list(ethnicity = "african european american"),
#        intercept = 147.45, weight = 8.39, height = 4.74, age = -3.56
#     )
# ),


# Orozco 2017 ------------------------------------------------------

eqs(name = "orozco_17", reference = "Orozco-Ruiz, X., Pichardo-Ontiveros, E., Tovar, A. R., Torres, N., Medina-Vera, I., Prinelli, F., . Guevara-Cruz, M. (2017). Development and validation of new predictive equation for resting energy expenditure in adults with overweight and obesity. Clinical Nutrition. https://doi.org/10.1016/j.clnu.2017.10.022",

    eq(name = "orosco_17-f", outcome = "ree", strata = list(sex = "female"),
       intercept = 835.952, weight = 12.114, age = -6.541
    ),
    eq(name = "orosco_17-m", outcome = "ree", strata = list(sex = "male"),
       intercept = 1094.991, weight = 12.114, age = -6.541
)
),
# De la Cruz 2015 ------------------------------------------------------

eqs(name = "delacruz_15", reference = "",

    eq(name = "delacruz_15-m", outcome = "ree", strata = list(sex = "male"),
       intercept = 1376.4, weight = 11.1, age = -8
    ),
    eq(name = "delacruz_15-f", outcome = "ree", strata = list(sex = "female"),
       intercept = 1376.4 - 308, weight = 11.1, age = -8
    )
),

# Roza 1984-a ------------------------------------------------------

eqs(name = "roza_84-a", reference = "Roza, A. M., & Shizgal, H. M. (1984). The Harris Benedict equation reevaluated: resting energy requirements and the body cell mass. The American journal of clinical nutrition, 40(1), 168-182.",

    eq(name = "roza_84-a-m", outcome = "rmr", strata = list(sex = "male"),
       intercept = 88.362, height = 4.799, weight = 13.397, age = -5.677
    ),
    eq(name = "roza_84-a-f", outcome = "rmr", strata = list(sex = "female"),
       intercept = 447.593, height = 3.098, weight = 9.247, age = -4.330
    )
),

# Roza 1984-b ------------------------------------------------------

eqs(name = "roza_84-b", reference = "Roza, A. M., & Shizgal, H. M. (1984). The Harris Benedict equation reevaluated: resting energy requirements and the body cell mass. The American journal of clinical nutrition, 40(1), 168-182.",

    eq(name = "roza_84-b-m", outcome = "", strata = list(sex = "male"),
       intercept = 77.607, height = 4.923, weight = 13.702, age = -6.673
    ),
    eq(name = "roza_84-b-f", outcome = "", strata = list(sex = "female"),
       intercept = 667.051, height = 1.729, weight = 9.740, age = -4.737
    )
),

# Valencia 1994 ------------------------------------------------------

eqs(name = "valencia_94", reference = "Valencia, M. E., Moya, S. Y., McNeill, G., & Haggarty, P. (1994). Basal metabolic rate and body fatness of adult men in northern Mexico. European Journal of Clinical Nutrition, 48(3), 205-211.",

    eq(name = "valencia_94-f", outcome = "bmr", strata = list(sex = "female"),
       intercept = 520, weight = 10.98
    ),
    eq(name = "valencia_94-m", outcome = "bmr", strata = list(sex = "male"),
       intercept = 42, weight = 14.21
    )
),


# Yang 2010-a ------------------------------------------------------

eqs(name = "yang_10-a", reference = "Yang, X., Li, M., Mao, D., Zeng, G., Zhuo, Q., Hu, W., . Huang, C. (2010). Basal energy expenditure in southern Chinese healthy adults: measurement and development of a new equation. The British Journal of Nutrition, 104(12), 1817-1823. https://doi.org/10.1017/S0007114510002795",

    eq(name = "yang_10-a-m", outcome = "bee", strata = list(sex = "male"),
       intercept = (277 + 600) / 4.184, weight = 89 / 4.184
    ),

    eq(name = "yang_10-a-f", outcome = "bee", strata = list(sex = "female"),
       intercept = 277 / 4.184, weight = 89 / 4.184
    )
),

# Yang 2010-b ------------------------------------------------------

eqs(name = "yang_10-b", reference = "Yang, X., Li, M., Mao, D., Zeng, G., Zhuo, Q., Hu, W., . Huang, C. (2010). Basal energy expenditure in southern Chinese healthy adults: measurement and development of a new equation. The British Journal of Nutrition, 104(12), 1817-1823. https://doi.org/10.1017/S0007114510002795",

    eq(name = "yang_10-b-m", outcome = "bee", strata = list(sex = "male"),
       intercept = -58 / 4.184, weight = 105 / 4.184
    ),
    eq(name = "yang_10-b-f", outcome = "bee", strata = list(sex = "female"),
       intercept = 1355 / 4.184, weight = 69 / 4.184
    )
),

# Siervo 2003 ------------------------------------------------------

eqs(name = "siervo_03", reference = "Siervo, M., Boschi, V., & Falconi, C. (2003). Which REE prediction equation should we use in normal-weight, overweight and obese women?. Clinical Nutrition, 22(2), 193-204.",

    eq(name = "siervo_03-f", outcome = "", strata = list(),
       intercept = 542.2, weight = 11 - 5
    )

),

# Piers and Shetty 1993 ------------------------------------------------------

eqs(name = "piers_93", reference = "Piers, L. S., & Shetty, P. S. (1993). BASAL METABOLIC RATES OF INDIAN WOMEN1. ENERGY METABOLISM DURING THE MENSTRUAL CYCLE, PREGNANCY AND LACTATION IN WELL NOURISHED INDIAN WOMEN, 47, 19.",

    eq(name = "piers_93-f", outcome = "bmr", strata = list(sex = "female"),
       intercept = 2479.7 / 4.184, weight = 45.46 / 4.184
    )

)

# # Author YYYY ------------------------------------------------------
#
# eqs(name = "", reference = "",
#
#     eq(name = "", outcome = "", strata = list(),
#        intercept = 0,
#     )
#
# )
#



)

reer

usethis::use_data(reer, overwrite = TRUE)
