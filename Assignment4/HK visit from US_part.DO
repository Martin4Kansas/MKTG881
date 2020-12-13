
*** Practice Stata (3).do first

*** Google search: Download google trends data (Jan 2009 - Sep 2014, US)


// Q1. Merging data sets //
******************************************************************
*0: change your working directory accordingly or use "File>>Change Working Directory" menu
cd "c:\ your working directory  " 
******************************************************************

*1
import excel "US search.xlsx", clear firstrow // variable name: "week", "hongkong"

*2
split week, parse(-)
 *Data > Create or change data > Other variable-transformation commands > Split string variables into parts

drop week week3-week6
destring week1 week2, generate(yr mth) // to numeric variable
 *Data > Create or change data > Other variable transformation commands > Convert variables from string to numeric

drop week1 week2
by yr mth, sort: egen search=total(hongkong) // combine weekly into monthly visits
 *by yr, sort:  egen search1=total(hongkong) // try this
 *by mth, sort: egen search2=total(hongkong) // try this

drop hongkong
duplicates drop // keep one obs per month
 *Data > Data utilities > Drop duplicated observations

save "US search monthly.dta", replace

*3 Merge
import excel "HK visit from US.xlsx", clear first //  cntry visit yr mth
merge 1:1 yr mth using "US search monthly.dta"
keep if _merge==3
drop _merge



// Q3. Making lagged variables and two-way line graphs//
gen l1visit =visit[_n-1] // previous obs
gen l12visit=visit[_n-12] // previous 12th obs
gen l1search=search[_n-1]
gen l2search=search[_n-2]

gen t=_n // 

twoway (scatter visit t) (scatter l1search t)
twoway (line visit t) (line l1search t, yaxis(2)) // 2nd axis
twoway (line visit t, lpattern(dash)) (line l1search t, yaxis(2))