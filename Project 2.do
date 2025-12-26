//786

clear all
set more off

//Setting the working directory
cd "pathway"

//Importing the dataset
use "pathway"

//Checking for unique identifier
isid key

//Constructing the Dependent Variable - Natural Logarithm of Wages
tab wage_yr
gen ln_wages = ln(wage_yr)
lab var ln_wages "Ln_Wages"
histogram ln_wages
graph export "pathway", as(jpg) name("Graph") quality(90)

//Creating dummies for Independent Variable 1 - Education
gen no_education = 1 if S4C9 == 1
replace no_education = 0 if inrange(S4C9, 2, 15)
lab def no_education 1 "No Education"
lab val no_education no_education

gen preprimary = 1 if inlist(S4C9, 2, 3)
replace preprimary = 0 if inlist(S4C9, 1, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15)
lab def preprimary 1 "Preprimary"
lab val preprimary preprimary

gen primary = 1 if S4C9 == 4
replace primary = 0 if inlist(S4C9, 1, 2, 3, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15)
lab def primary 1 "Primary"
lab val primary primary

gen secondary = 1 if inlist(S4C9, 5, 6, 7)
replace secondary = 0 if inlist(S4C9, 1, 2, 3, 4, 8, 9, 10, 11, 12, 13, 14, 15)
lab def secondary 1 "Secondary"
lab val secondary secondary 

gen tertiary = 1 if inrange(S4C9, 8, 15)
replace tertiary = 0 if inrange(S4C9, 1, 7)
lab def tertiary 1 "Tertiary"
lab val tertiary tertiary

//Creating dummies for Independent Variable 2 - Region
gen rural = 1 if Region == 1
replace rural = 0 if Region == 2
lab def rural 1 "Rural"
lab val rural rural

gen urban = 1 if Region == 2
replace urban = 0 if Region == 1
lab def urban 1 "Urban"
lab val urban urban

//Creating dummies for Independent Variable 3 - Marital Status
gen never_married = 1 if S4C7 == 1
replace never_married = 0 if inlist(S4C7, 2, 3, 4)
lab def never_married 1 "Never Married"
lab val never_married never_married

gen ever_married = 1 if inlist(S4C7, 2, 3, 4)
replace ever_married = 0 if S4C7 == 1
lab def ever_married 1 "Ever Married"
lab val ever_married ever_married

//Constructing the Independent Variable 4 - Working Age
gen working_age = S4C6 if S4C6 >= 10 //10 years and older

//Creating the Independent Variable 5 - Gender
gen gender = 1 if RSex == 1
replace gender = 2 if RSex == 2
lab def gender 1 "Male" 2 "Female"
lab val gender gender

//Constructing the Independent Variable 6 - Family Income
bys PrCode: egen fam_inc = total(wage_yr)
egen tag_1 = tag(PrCode)
gen familyincome = fam_inc if tag_1 == 1
gen ln_faminc = ln(familyincome)
label var ln_faminc "family income"
br PrCode tag_1 ln_faminc


//Constructing Independent Variable 7 - Sector
gen sector = 2 if inrange(S5C10, 1, 4)
replace sector = 1 if inrange(S5C10, 5, 10)
lab def sector 2 "Public Sector" 1 "Private Sector"
lab val sector sector

//Constructing the Independent Variable 8 - Nature of Work
gen managers_executives = 1 if inrange(S5C8, 1111, 1439)
replace managers_executives = 0 if inrange(S5C8, 2111, 9629)
lab def managers_executives 1 "Managers and Executives"
lab val managers_executives managers_executives

gen professionals = 1 if inrange(S5C8, 2111, 2659)
replace professionals = 0 if (inrange(S5C8,1111, 1439) | inrange(S5C8, 3111, 9629))
lab def professionals 1 "Professionals"
lab val professionals professionals

gen technicians_professionals = 1 if inrange(S5C8, 3111, 3522)
replace technicians_professionals = 0 if (inrange(S5C8, 1111, 2659) | inrange(S5C8, 4110, 9629))
lab def technicians_professionals 1 "Technicians and Associate Professionals"
lab val technicians_professionals technicians_professionals

gen clerical_support = 1 if inrange(S5C8, 4110, 4419)
replace clerical_support = 0 if (inrange(S5C8, 1111, 3522) | inrange(S5C8, 5112, 9629))
lab def clerical_support 1 "Clerical Support Workers"
lab val clerical_support clerical_support

gen service_sales = 1 if inrange(S5C8, 5112, 5414)
replace service_sales = 0 if (inrange(S5C8, 1111, 4419) | inrange(S5C8, 6111, 9629))
lab def service_sales 1 "Service and Sales Workers"
lab val service_sales service_sales

gen agriculture = 1 if inrange(S5C8, 6111, 6340)
replace agriculture = 0 if (inrange(S5C8, 1111, 5414) | inrange(S5C8, 7111, 9629))
lab def agriculture 1 "Skilled Agriculture Workers"
lab val agriculture agriculture

gen crafts_trades = 1 if inrange(S5C8, 7111, 7549)
replace crafts_trades = 0 if (inrange(S5C8, 1111, 6340) | inrange(S5C8, 8111, 9629))
lab def crafts_trades 1 "Crafts and Trades Workers"
lab val crafts_trades crafts_trades

gen plant_machine = 1 if inrange(S5C8, 8111, 8350)
replace plant_machine = 0 if (inrange(S5C8, 1111, 7549) | inrange(S5C8, 9111, 9629))
lab def plant_machine 1 "Plant and Machine Operators"
lab val plant_machine plant_machine

gen elementary = 1 if inrange(S5C8, 9111, 9629)
replace elementary = 0 if inrange(S5C8, 1111, 8350)
lab def elementary 1 "Elementary Occupations"
lab val elementary elementary

//Constructing Independent Variable 9 - Age^2 as a proxy for Experience^2
gen working_age_sq = working_age * working_age

//Keeping data for the working population only
tab work
tab ln_wages
keep if work == 1 & ln_wages != .

//Removing missing values of gender
keep if gender != .

//Transferring all missing values of sector to private sector
replace sector = 1 if sector == .

//Division of ln_wages into 5 quantiles
sum ln_wages
xtile ln_wages_q=ln_wages , nq(5)
tab ln_wages_q , gen(ln_wages_q)

//Generating natural logarithm of male and female wages
tab gender, gen(gender)
gen mlwage=gender1 *ln_wages
gen flwage=gender2 *ln_wages
mat list e(b)
macro list

//Constructing a variable for industry
*Question is what industries represent majority of the data
tab S5C9_regroup
gen industry_draft = 1 if inlist(S5C9_regroup, 1, 7, 3, 6, 8, 16)
replace industry_draft = 0 if industry_draft == .
tab industry_draft
//83.46% of the data is covered by few industries mentioned below. 

gen industry = 1 if S5C9_regroup == 1 //agriculture
replace industry = 2 if S5C9_regroup == 7 //wholesale and retail trade
replace industry = 3 if S5C9_regroup == 3 //manufacturing
replace industry = 4 if S5C9_regroup == 6 //construction
replace industry = 5 if S5C9_regroup == 8 //transportation and storage
replace industry = 6 if S5C9_regroup == 16 //education
replace industry = 7 if industry == .
lab def industry 1 "Agriculture" 2 "Wholesale and Retail Trade" 3 "Manufacturing" 4 "Construction" 5 "Transportation & Storage" 6 "Education" 7 "Others"
lab val industry industry

//Probability Distribution Function for male and female wages
twoway kdensity mlwage|| kdensity flwage

//Cumulative Distribution Function for male and female wages
cumul flwage [aw=Weight], gen(Flwage)
cumul mlwage [aw=Weight], gen(Mlwage)
line Mlwage mlwage, sort || line Flwage flwage, sort

//Descriptive Analysis
bysort gender sector: summ working_age wage_yr urban no_education preprimary primary secondary tertiary ever_married managers_executives professionals technicians_professionals clerical_support service_sales agriculture crafts_trades plant_machine elementary [iw = Weights]

//Wage differentials at different education levels
bysort gender sector: summ wage_yr if no_education [iw = Weights]
bysort gender sector: summ wage_yr if preprimary [iw = Weights]
bysort gender sector: summ wage_yr if primary [iw = Weights]
bysort gender sector: summ wage_yr if secondary [iw = Weights]
bysort gender sector: summ wage_yr if tertiary [iw = Weights]


//Wage differentials at different occupations
bysort gender sector: summ wage_yr if managers_executives [iw = Weights]
bysort gender sector: summ wage_yr if professionals [iw = Weights]
bysort gender sector: summ wage_yr if technicians_professionals [iw = Weights]
bysort gender sector: summ wage_yr if clerical_support [iw = Weights]
bysort gender sector: summ wage_yr if service_sales [iw = Weights]
bysort gender sector: summ wage_yr if agriculture [iw = Weights]
bysort gender sector: summ wage_yr if crafts_trades [iw = Weights]
bysort gender sector: summ wage_yr if plant_machine [iw = Weights]
bysort gender sector: summ wage_yr if elementary [iw = Weights]

//Storing the dependent variable and explanatory variables in global
global ylist ln_wages
global xlist preprimary primary secondary tertiary working_age working_age_sq urban ln_faminc ever_married managers_executives professionals technicians_professionals clerical_support service_sales agriculture crafts_trades plant_machine

//OLS regression
bysort sector gender: reg $ylist $xlist [iw = Weights], robust //Robustness controls for heteroscedasticity

//Testing for multicollinearity 
vif //Most values fall below 5 so multicollinearity is controlled

////////////////////////////////////Blinder-Oaxaca Decomposition/////////////////////////////////////////////////////

*By Gender
oaxaca ln_wages preprimary primary secondary tertiary working_age working_age_sq ln_faminc ever_married managers_executives professionals technicians_professionals clerical_support service_sales agriculture crafts_trades plant_machine sector [iw = Weights], by (gender)

*By Gender at different ln_wage quantiles
//First quantile
oaxaca ln_wages preprimary primary secondary tertiary working_age working_age_sq ln_faminc ever_married managers_executives professionals technicians_professionals clerical_support service_sales agriculture crafts_trades plant_machine sector if ln_wages_q == 1 [iw = Weights], by (gender)
//Second quantile
oaxaca ln_wages preprimary primary secondary tertiary working_age working_age_sq ln_faminc ever_married managers_executives professionals technicians_professionals clerical_support service_sales agriculture crafts_trades plant_machine sector if ln_wages_q == 2 [iw = Weights], by (gender)
//Third quantile
oaxaca ln_wages preprimary primary secondary tertiary working_age working_age_sq ln_faminc ever_married managers_executives professionals technicians_professionals clerical_support service_sales agriculture crafts_trades plant_machine sector if ln_wages_q == 3 [iw = Weights], by (gender)
//Fourth quantile
oaxaca ln_wages preprimary primary secondary tertiary working_age working_age_sq ln_faminc ever_married managers_executives professionals technicians_professionals clerical_support service_sales agriculture crafts_trades plant_machine sector if ln_wages_q == 4 [iw = Weights], by (gender)
//Fifth quantile
oaxaca ln_wages preprimary primary secondary tertiary working_age working_age_sq ln_faminc ever_married managers_executives professionals technicians_professionals clerical_support service_sales agriculture crafts_trades plant_machine sector if ln_wages_q == 5 [iw = Weights], by (gender)

*By Gender at different sectors
//Private
oaxaca ln_wages preprimary primary secondary tertiary working_age working_age_sq urban ln_faminc ever_married managers_executives professionals technicians_professionals clerical_support service_sales agriculture crafts_trades plant_machine if sector== 1 [iw = Weights], by (gender)
//Public
oaxaca ln_wages preprimary primary secondary tertiary working_age working_age_sq urban ln_faminc ever_married managers_executives professionals technicians_professionals clerical_support service_sales agriculture crafts_trades plant_machine if sector == 2 [iw = Weights], by (gender) vce(cluster PCode)

*By Gender at different industries
//Agriculture
oaxaca ln_wages preprimary primary secondary tertiary working_age working_age_sq urban ln_faminc ever_married if industry == 1 [iw = Weights], by (gender)
//Wholesale and Retail Trade
oaxaca ln_wages preprimary primary secondary tertiary working_age working_age_sq urban ln_faminc ever_married if industry == 2 [iw = Weights], by (gender)
//Manufacturing
oaxaca ln_wages preprimary primary secondary tertiary working_age working_age_sq urban ln_faminc ever_married if industry == 3 [iw = Weights], by (gender)
//Construction
oaxaca ln_wages preprimary primary secondary tertiary working_age working_age_sq urban ln_faminc ever_married if industry == 4 [iw = Weights], by (gender)
//Transportation and Storage
oaxaca ln_wages preprimary primary secondary tertiary working_age working_age_sq urban ln_faminc ever_married if industry == 5 [iw = Weights], by (gender)
//Education
oaxaca ln_wages preprimary primary secondary tertiary working_age working_age_sq urban ln_faminc ever_married if industry == 6 [iw = Weights], by (gender)
//Others
oaxaca ln_wages preprimary primary secondary tertiary working_age working_age_sq urban ln_faminc ever_married if industry == 7 [iw = Weights], by (gender)

*By Gender at different education levels
//No education
oaxaca ln_wages working_age working_age_sq ln_faminc ever_married sector if no_education == 1 [iw = Weights], by(gender)
//Preprimary
oaxaca ln_wages working_age working_age_sq ln_faminc ever_married sector if preprimary == 1 [iw = Weights], by(gender)
//Primary
oaxaca ln_wages working_age working_age_sq ln_faminc ever_married sector if primary == 1 [iw = Weights], by(gender)
//Secondary
oaxaca ln_wages working_age working_age_sq ln_faminc ever_married sector if secondary == 1 [iw = Weights], by(gender)
//Tertiary
oaxaca ln_wages working_age working_age_sq ln_faminc ever_married sector if tertiary == 1 [iw = Weights], by(gender)

*For Males by Sector
oaxaca ln_wages preprimary primary secondary tertiary working_age working_age_sq urban ln_faminc ever_married managers_executives professionals technicians_professionals clerical_support service_sales agriculture crafts_trades plant_machine if gender == 1 [iw = Weights], by (sector)

*For Females by Sector
oaxaca ln_wages preprimary primary secondary tertiary working_age working_age_sq urban ln_faminc ever_married managers_executives professionals technicians_professionals clerical_support service_sales agriculture crafts_trades plant_machine if gender == 1 [iw = Weights], by (sector)

*For Males by Region
oaxaca ln_wages preprimary primary secondary tertiary working_age working_age_sq ln_faminc ever_married managers_executives professionals technicians_professionals clerical_support service_sales agriculture crafts_trades plant_machine sector if gender == 1 [iw = Weights], by (Region)

*For Females by Region
oaxaca ln_wages preprimary primary secondary tertiary working_age working_age_sq ln_faminc ever_married managers_executives professionals technicians_professionals clerical_support service_sales agriculture crafts_trades plant_machine sector if gender == 2 [iw = Weights], by (Region)



