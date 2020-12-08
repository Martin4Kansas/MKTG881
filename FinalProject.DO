cd /Users/Shared/MSDA/MKTG881/finalproject

import excel "covid19.xlsx", clear firstrow

reg cases pop pop_den lat lon since_march mandate_level visits google admissions quidel full part two_case_avg two_death_avg four_case_avg four_death_avg case_trend death_trend neighbor_cases neighbor_deaths

predict case_pred, xb

reg deaths pop pop_den lat lon since_march mandate_level visits google admissions quidel full part two_case_avg two_death_avg four_case_avg four_death_avg case_trend death_trend neighbor_cases neighbor_deaths

predict death_pred, xb

summarize

corr

twoway (line cases since_march if code=="ks", lcolor(blue)) (line case_pred since_march if code=="ks", lcolor(red) lpattern(dash))

twoway (line deaths since_march if code=="ks", lcolor(blue)) (line death_pred since_march if code=="ks", lcolor(red) lpattern(dash))

bysort since_march : gen cum_cases = sum(cases)

bysort since_march : gen cum_deaths = sum(deaths)

bysort since_march : gen cum_pred_cases = sum(case_pred)

bysort since_march : gen cum_pred_deaths = sum(death_pred)

twoway (line cum_cases since_march if code=="wy", lcolor(blue)) (line cum_pred_cases since_march if code=="wy", lcolor(red) lpattern(dash))

twoway (line cum_deaths since_march if code=="wy", lcolor(blue)) (line cum_pred_deaths since_march if code=="wy", lcolor(red) lpattern(dash))
