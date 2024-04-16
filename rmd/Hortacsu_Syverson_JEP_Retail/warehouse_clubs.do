******Warehouse Store Tests******
**********July 31, 2015**********
**County Business Patterns Data**

clear all
set more off

* Change directory names below to suit

* Import the raw 2003 and 2013 CBP county-level data for the following industries
* NAICS "------" All industries
* NAICS "44----" Retail trade sector
* NAICS "442///" Furniture and home furnishings stores
* NAICS "443///" Electronics and appliances
* NAICS "445///" Food and beverage stores
* NAICS "446///" Health and personal care stores
* NAICS "448///" Clothing and clothing accessories stores
* NAICS "45111/" Sporting goods stores
* NAICS "45112/" Hobby, toy, and game stores
* NAICS "45121/" Book stores and news dealers
* NAICS "4521//" Department stores
* NAICS "45291/" Warehouse clubs and supercenters
* NAICS "45321/" Office supplies and stationary stores
* NAICS "4541//" Electronic shopping and mail-order houses

local baseline = "C:\Projects\JEP\Evolution of Retail\data_appendix"

insheet using "`baseline'\cbp2003_2013.csv", comma

* Group by county and year
egen fipsstcou = group(fipstate fipscty)
sort fipsstcou year naics
drop censtate cencty

* Matching standard NAICS codes
replace naics="000000" if naics=="------" 
replace naics="440000" if naics=="44----"
replace naics="442000" if naics=="442///"
replace naics="443000" if naics=="443///"
replace naics="445000" if naics=="445///"
replace naics="446000" if naics=="446///"
replace naics="448000" if naics=="448///"
replace naics="451110" if naics=="45111/"
replace naics="451120" if naics=="45112/"
replace naics="451210" if naics=="45121/"
replace naics="452100" if naics=="4521//"
replace naics="452910" if naics=="45291/"
replace naics="453210" if naics=="45321/"
replace naics="454100" if naics=="4541//"

* Reshape the data to have one observation per county and year
reshape wide empflag emp qp1 ap est n1_4 n5_9 n10_19 n20_49 n50_99 n100_249 n250_499 n500_999 n1000 n1000_1 n1000_2 n1000_3 n1000_4 emp_nf qp1_nf ap_nf, i(fipsstcou year) j(naics) string

* Take the log and difference by breakout industry
foreach naics in 000000 440000 442000 443000 445000 446000 448000 451110 451120 451210 452100 452910 453210 454100 {
	replace est`naics'=0 if est`naics'==.
	gen lest`naics'=ln(est`naics')
	by fipsstcou: gen dest`naics'=est`naics'-est`naics'[_n-1]
	by fipsstcou: gen dlest`naics'=lest`naics'-lest`naics'[_n-1]
}

* Label variables by NAICS code
label var dlest000000 "Total"
label var dlest440000 "Retail"
label var dest442000 "Furniture"
label var dest443000 "Elec. \& Appl."
label var dest445000 "Food \& Beverages"
label var dest446000 "Health \& P. Care"
label var dest448000 "Clothing \& Access."
label var dest451110 "Sporting Goods"
label var dest451120 "Hobby, Toy, \& Games"
label var dest451210 "Books \& News"
label var dest452100 "Department Stores"
label var dest452910 "Warehouse"
label var dest453210 "Office \& Stationary"
label var dest454100 "ESMOH"

* Main regression specification
foreach dep in 452100 451210 451120 443000 442000 451110 453210 448000 446000 445000 {
	reg dest`dep' dlest000000 dlest440000 dest452910, r
	estimates store n_`dep'
}

* ESMOH control included
reg dest452100 dlest000000 dlest440000 dest452910 dest454100, r
	estimates store n_`dep'_e

