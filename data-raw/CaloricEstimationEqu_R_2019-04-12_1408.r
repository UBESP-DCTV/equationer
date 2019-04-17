data=read.csv('data-raw/CaloricEstimationEqu_DATA_2019-04-12_1408.csv')

#Setting Factors(will create new variable for factors)
data$level.factor = factor(data$level,levels=c("0","1","2"))
data$sesso.factor = factor(data$sesso,levels=c("1","2"))
data$exemption.factor = factor(data$exemption,levels=c("1","0"))
data$mobility_level.factor = factor(data$mobility_level,levels=c("0","1","2","3","4"))
data$razza.factor = factor(data$razza,levels=c("0","1"))
data$disfagia.factor = factor(data$disfagia,levels=c("1","0"))
data$consistenza_solidi.factor = factor(data$consistenza_solidi,levels=c("0","1","2"))
data$consistenza_liquidi.factor = factor(data$consistenza_liquidi,levels=c("0","1","2"))
data$addensante.factor = factor(data$addensante,levels=c("0","1"))
data$integratore.factor = factor(data$integratore,levels=c("0","1"))
data$fall_risk.factor = factor(data$fall_risk,levels=c("1","0"))
data$hospital_admission.factor = factor(data$hospital_admission,levels=c(""))
data$tipo_bilancia.factor = factor(data$tipo_bilancia,levels=c("0","1"))
data$diabetico.factor = factor(data$diabetico,levels=c("1","0"))
data$menopausa.factor = factor(data$menopausa,levels=c("1","2","3"))
data$socio_demographic_characteristics_8c8d_complete.factor = factor(data$socio_demographic_characteristics_8c8d_complete,levels=c("0","1","2"))
data$braccio_dominante.factor = factor(data$braccio_dominante,levels=c("0","1"))
data$measurements_complete.factor = factor(data$measurements_complete,levels=c("0","1","2"))
data$ratio_ecw_tbw.factor = factor(data$ratio_ecw_tbw,levels=c("0","1","2"))
data$segmental_assessment_lbm.factor = factor(data$segmental_assessment_lbm,levels=c(""))
data$l_arm.factor = factor(data$l_arm,levels=c("0","1","2"))
data$r_arm.factor = factor(data$r_arm,levels=c("0","1","2"))
data$l_leg.factor = factor(data$l_leg,levels=c("0","1","2"))
data$r_leg.factor = factor(data$r_leg,levels=c("0","1","2"))
data$r_trunk.factor = factor(data$r_trunk,levels=c("0","1","2"))
data$bias_measurement_complete.factor = factor(data$bias_measurement_complete,levels=c("0","1","2"))
data$letto_sedia1.factor = factor(data$letto_sedia1,levels=c("0","3","7","12","15"))
data$letto_sedia_2.factor = factor(data$letto_sedia_2,levels=c("0","3","7","12","15"))
data$deambulazione_carrozzina1.factor = factor(data$deambulazione_carrozzina1,levels=c("0","3","7","10","11","12","14","15"))
data$deambulazione_carrozzina_2.factor = factor(data$deambulazione_carrozzina_2,levels=c("0","3","7","10","11","12","14","15"))
data$scale1.factor = factor(data$scale1,levels=c("0","2","dispnea","5","8","10"))
data$scale_2.factor = factor(data$scale_2,levels=c("0","2","dispnea","5","8","10"))
data$physical_activity_iom.factor = factor(data$physical_activity_iom,levels=c("1","2","3","4"))
data$atheletes.factor = factor(data$atheletes,levels=c("1","0"))
data$physical_function_complete.factor = factor(data$physical_function_complete,levels=c("0","1","2"))

levels(data$level.factor)=c("Bounty","Talita","Freedom")
levels(data$sesso.factor)=c("male","female")
levels(data$exemption.factor)=c("Yes","No")
levels(data$mobility_level.factor)=c("Allettato","Cammina","Carrozzina (con aiuto)","Carrozzina (da solo)","Cammina con girello")
levels(data$razza.factor)=c("Caucasica","Afroamericano")
levels(data$disfagia.factor)=c("Yes","No")
levels(data$consistenza_solidi.factor)=c("Cremoso","Sminuzzato","Morbido")
levels(data$consistenza_liquidi.factor)=c("Crema","Sciroppo","Normale")
levels(data$addensante.factor)=c("2 misurini/200ml","4 misurini/200ml")
levels(data$integratore.factor)=c("4 misurini fortimel x 1","4 misurini fortimel x 2")
levels(data$fall_risk.factor)=c("Yes","No")
levels(data$hospital_admission.factor)=c("")
levels(data$tipo_bilancia.factor)=c("bilancia digitale","sollevatore")
levels(data$diabetico.factor)=c("Yes","No")
levels(data$menopausa.factor)=c("pre menopausa","peri menopausa","post menopausa")
levels(data$socio_demographic_characteristics_8c8d_complete.factor)=c("Incomplete","Unverified","Complete")
levels(data$braccio_dominante.factor)=c("Right","Left")
levels(data$measurements_complete.factor)=c("Incomplete","Unverified","Complete")
levels(data$ratio_ecw_tbw.factor)=c("normal","borderline","over")
levels(data$segmental_assessment_lbm.factor)=c("")
levels(data$l_arm.factor)=c("well","under","optimal")
levels(data$r_arm.factor)=c("well","under","optimal")
levels(data$l_leg.factor)=c("well","under","optimal")
levels(data$r_leg.factor)=c("well","under","optimal")
levels(data$r_trunk.factor)=c("well","under","optimal")
levels(data$bias_measurement_complete.factor)=c("Incomplete","Unverified","Complete")
levels(data$letto_sedia1.factor)=c("E indipendente durante tutte le fasi.","Necessaria la presenza di una persona per maggior fiducia o per supervisione a scopo di sicurezza.","Necessario minimo aiuto da parte di una persona per uno o più aspetti del trasferimento.","Collabora, ma richiede massimo aiuto da parte di una persona durante tutti i movimenti del trasferimento.","Non collabora al trasferimento. Necessarie due persone per trasferire lanziano con o senza un sollevatore meccanico.")
levels(data$letto_sedia_2.factor)=c("E indipendente durante tutte le fasi.","Necessaria la presenza di una persona per maggior fiducia o per supervisione a scopo di sicurezza.","Necessario minimo aiuto da parte di una persona per uno o più aspetti del trasferimento.","Collabora, ma richiede massimo aiuto da parte di una persona durante tutti i movimenti del trasferimento.","Non collabora al trasferimento. Necessarie due persone per trasferire lanziano con o senza un sollevatore meccanico.")
levels(data$deambulazione_carrozzina1.factor)=c("In grado di usare stampelle, bastoni, walker e deambulare per 50 m. senza aiuto o supervisione.","Indipendente nella deambulazione, ma con autonomia < 50 m. Necessita di supervisione per maggior fiducia o sicurezza in situazioni pericolose.","Necessita di assistenza di una persona per raggiungere gli ausili e/o per la loro manipolazione.","Capace di compiere autonomamente tutti gli spostamenti (girare attorno agli angoli, rigirarsi, avvicinarsi al tavolo, letto, wc, ecc.) Lautonomia deve essere > 50 m.","Capace di spostarsi autonomamente, per periodi ragionevolmente lunghi, su terreni e superfici regolari. Può essere necessaria assistenza per fare curve strette.","Necessaria la presenza e lassistenza costante di una persona per avvicinare la carrozzina al tavolo, al letto, ecc.","Capace di spostarsi per brevi tratti su superfici piane, ma è necessaria assistenza per tutte le altre manovre.","Non in grado di deambulare autonomamente/dipende negli spostamenti con la carrozzina")
levels(data$deambulazione_carrozzina_2.factor)=c("In grado di usare stampelle, bastoni, walker e deambulare per 50 m. senza aiuto o supervisione.","Indipendente nella deambulazione, ma con autonomia < 50 m. Necessita di supervisione per maggior fiducia o sicurezza in situazioni pericolose.","Necessita di assistenza di una persona per raggiungere gli ausili e/o per la loro manipolazione.","Capace di compiere autonomamente tutti gli spostamenti (girare attorno agli angoli, rigirarsi, avvicinarsi al tavolo, letto, wc, ecc.) Lautonomia deve essere > 50 m.","Capace di spostarsi autonomamente, per periodi ragionevolmente lunghi, su terreni e superfici regolari. Può essere necessaria assistenza per fare curve strette.","Necessaria la presenza e lassistenza costante di una persona per avvicinare la carrozzina al tavolo, al letto, ecc.","Capace di spostarsi per brevi tratti su superfici piane, ma è necessaria assistenza per tutte le altre manovre.","Non in grado di deambulare autonomamente/dipende negli spostamenti con la carrozzina")
levels(data$scale1.factor)=c("In grado di salire e scendere una rampa di scale con sicurezza, senza aiuto o supervisione. In grado di usare corrimano, bastone o stampelle se necessario, ed è in grado di portarli con sé durante la salita o discesa.","In genere non richiede assistenza. Occasionalmente necessita di supervisione, per sicurezza (es. a causa di rigidità mattutina,","ecc.)","Capace di salire/scendere le scale, ma non in grado di gestire gli ausili e necessita di supervisione ed assistenza.","Necessita di aiuto per salire e scendere le scale (compreso eventuale uso di ausili).","Incapace di salire e scendere le scale.")
levels(data$scale_2.factor)=c("In grado di salire e scendere una rampa di scale con sicurezza, senza aiuto o supervisione. In grado di usare corrimano, bastone o stampelle se necessario, ed è in grado di portarli con sé durante la salita o discesa.","In genere non richiede assistenza. Occasionalmente necessita di supervisione, per sicurezza (es. a causa di rigidità mattutina,","ecc.)","Capace di salire/scendere le scale, ma non in grado di gestire gli ausili e necessita di supervisione ed assistenza.","Necessita di aiuto per salire e scendere le scale (compreso eventuale uso di ausili).","Incapace di salire e scendere le scale.")
levels(data$physical_activity_iom.factor)=c("1, sedentary","1.11 low active,","1.25 active,","1.48 very active")
levels(data$atheletes.factor)=c("Yes","No")
levels(data$physical_function_complete.factor)=c("Incomplete","Unverified","Complete")


sample_data <- dplyr::as_tibble(data) %>%
    dplyr::transmute(
        record_id = record_id,
        age = eta,
        height = height,
        weight = intpeso,
        bmi = weight/height^2,
        sex = sesso.factor,
        ethnicity = razza.factor,
        mean_chest_skinfold = mean_chest_skinfold,
        subscapular_skinfold = mean_subscapular_skinfold,
        wrist_circumference = wrist_circumference,
        # adjusted_weight = DA CALCOLARE,
        # lbm = DA CALCOLARE,
        # lta???,
        # surface_area????,
        # glucose_g_dl?????,
        # albumin_mg_dl?????,
        # bmi_class???? (obese, normal weight, overweight, underweigth),
        # bmi_greater_21???? (TRUE/FALSE)
        # age_greater_60???? (TRUE/FALSE),
        # diabetic???? (TRUE/FALSE),
        # hf???? (TRUE = nyha III/IV, FALSE = nyha I/II)
        menopausal = menopausa,
        air_temperature = temperature,
        air_humidity = humidity,
        atheletes = atheletes
        # pal = physical_activity_iom, # non usato in nessuna equazione....
        # SBSA = DA CALCOLARE, # non usato in nessuna equazione....
    )
