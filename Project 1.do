

/* 
Research question: How do returns to education vary across different points of the income distribution between Punjab and Sindh

Dataset: Labor Force Survey 2017-2018

Dependent variable: Total Wages

Independent variables: Education Level

Control variables: family income, Expected work experience, Age, hours worked
*/


clear all
set more off

// Calling the dataset
cd "pathway", clear

// labeling variables 
lab var S04C06 "Age"
lab var S04C05 "Gender"
label var PrCode "Processing Code"
label var EbCode "Enumeration block code"
label var RespSex "Respondent's Sex"
label var RespRel "Respondent's relation to head of household"
label var SrHhd "Serial No of household"
label var S04C04 "Present status"
label var S04C03 "Relationship to household head"
label var S04C05 "Household member's Gender"
label var S04C06 "Age at last birthday"
label var S04C07 "Household member's marital status (10 years and above)"
label var S04C08 "Can household member read and write/understand any language"
label var S04C09 "Household member's education level"
label var S04C10 "Household member's current enrollment"
label var S04C11 "Has the member completed any technical/vocational training"
label var S04C12 "Type of Training (If Yes)"
label var S04C13 "Duration of Training (If Yes)"
label var S04C14 "Provider of Training"
label var S04C15 "How Long has the member been living in the district"
label var S04C16 "Previous district of residence"
label var S04C17 "Previous residence was located in? (Rural or Urban)"
label var S04C18 "Main reason for migration"
label var S05C01 "Principal activities during most of the last 12 months"
label var S05C02 "Did... do paid work during last week or for atleast one hour on any day"
label var S05C03 "Did... help to work for family gain in family business or family farm during the last week"
label var S05C04 "Did... have a job or enterprise (If did not work last week)"
label var S05C05 "Why did ... not work last week"
label var S05C06 "How Long has been ... absent from job or enterprise"
label var S05C07 "What kind of attachment does ... have to that enterprise"
label var S05C08 "What was ... employment status"
label var S05C09 "What was ... main occupation? (nature of work)"
label var S05C10 "What was the nature of work done by establishment (shop, business)"
label var S05C11 "What kind of enterprise"
label var S05C12 "Does the enterprise keep written accounts?"
label var S05C13 "How many persons are engaged in the enterprise?"
label var S05C14 "Are there any regular paid employees in the enterprise?"
label var S05C15 "Where did ... carry out the work?"
label var S05C16 "What was the location of workplace? (Rural/Urban)"
label var S05C171 "How many hours did ... worked each day during the last week at his/her main occupation?"
label var S05C172 "If did not work even though had a job or enterprise"
label var S05C173 "If did not work, had no job or enterprise, but was available for work"
label var S05C174 "If did not work, had no job or enterprise, and not available for work"
label var S05C18 "If in addition to the main occupation, did ... 1s0 work in any subsidiary occupation last week"
label var S05C19 "What was ... employment status?"
label var S05C20 "What was ... subsidiary occupation (nature of work)?"
label var S05C21 "Nature of work done by establishment (business, shop) where ... worked?"
label var S05C22 "What kind of enterprise?"
label var S05C23 "Does ... the enterprise keep written accounts?"
label var S05C24 "How many persons are engaged in the enterprise?"
label var S05C25 "Are there any regular paid employees in the enterprise?"
label var S05C26 "How many hours did ... worked each day during the last week of his/her subsidiary occupation(s)?"
label var S05C27 "In addition to the main and subsidiary jobs, did ... perform other jobs?"
label var S05C28 "What was the nature of main activity ... did one year ago?"
label var S06C01 "If the number of hours worked at the main occupation and subsidiary occupation is less than 35, why did ... work less than 35 hours during last week?"
label var S06C02 "Was ... available for alternative or additional work?"
label var S06C03 "Did ... seek any alternative or additional work last week?"
label var S06C04 "Why did ... seek any alternative or additional work last week?"
label var S07C01 "What was the status of job's contract between employee and employer (Paid employees only)?"
label var S07C02 "At ... main work, what is the periodicity of the payment? (paid employees only)?"
label var S07C031 "How much total net money in cash did ... earn from the main work last week? (paid employees only)?"
label var S07C032 "How much net money (in-kind) did ... earn from the main work last week? (paid employees only)?"
label var S07C03 "How much total net money did ... earn from the main work last week? (paid employees only)?"
label var S07C041 "How much net money in cash did ... earn from the main work last month (paid employees only)?"
label var S07C042 "How much net money (in-kind) did ... earn from the main work last month (paid employees only)?"
label var S07C04 "How much total net money did ... earn from the main work last month (paid employees only)?"
label var S07C051 "How much net money in cash did ... receive last year in bonuses ( paid employees only)?"
label var S07C052 "How much net money (in-kind) in cash did ... receive last year in bonuses ( paid employees only)?"
label var S07C05 "How much net money in total in cash did ... receive last year in bonuses ( paid employees only)?"
label var S07C061 "Whether ... is entitiled to have any benefits (1) (paid employees only)?"
label var S07C062 "Whether ... is entitiled to have any benefits (2) (paid employees only)?"
label var S07C063 "Whether ... is entitiled to have any benefits (3) (paid employees only)?"
label var S07C064 "Whether ... is entitiled to have any benefits (4) (paid employees only)?"
label var S07C065 "Whether ... is entitiled to have any benefits (5) (paid employees only)?"
label var S07C066 "Whether ... is entitiled to have any benefits (6) (paid employees only)?"
label var S07C07 "How many days entitiled/availed for vacation or sick leave during the year (paid employees only)?"
label var S08C01 "In the past 12 months...did receive any occupational injury/disease that caused to take time off of work or consulted a doctor?"
label var S08C021 "If yes, what was the unsafe act that caused the accident?"
label var S08C022 "If yes, what was the other unsafe act that caused the accident?"
label var S08C023 "If yes, what was the other unsafe act that caused the accident?"
label var S08C031 "Did... receive treatment for injury/disease or have to take time off because of it?"
label var S08C032 "Did... receive treatment for the other injury/disease or have to take time off because of it?"
label var S08C033 "Did... receive treatment for the other injury/disease or have to take time off because of it?"
label var S08C041 "What were the conditions causing the accident/disease?"
label var S08C042 "What were the other conditions causing the accident/disease?"
label var S08C043 "What were the other conditions causing the accident/disease?"
label var S08C051 "How soon were ... able to go back to work after the accident/disease?"
label var S08C052 "How soon were ... able to go back to work after the other accident/disease?"
label var S08C053 "How soon were ... able to go back to work after the other accident/disease?"
label var S09C01 "Was ... seeking work during the past week?"
label var S09C0201 "What steps did ... take during the past month to seek work? (1)"
label var S09C0202 "What steps did ... take during the past month to seek work? (2)"
label var S09C0203 "What steps did ... take during the past month to seek work? (3)"
label var S09C0204 "What steps did ... take during the past month to seek work? (4)"
label var S09C0205 "What steps did ... take during the past month to seek work? (5)"
label var S09C0206 "What steps did ... take during the past month to seek work? (6)"
label var S09C0207 "What steps did ... take during the past month to seek work? (7)"
label var S09C0208 "What steps did ... take during the past month to seek work? (8)"
label var S09C0209 "What steps did ... take during the past month to seek work? (9)"
label var S09C0210 "What steps did ... take during the past month to seek work? (10)"
label var S09C0211 "What steps did ... take during the past month to seek work? (11)"
label var S09C0212 "What steps did ... take during the past month to seek work? (12)"
label var S09C0213 "What steps did ... take during the past month to seek work? (13)"
label var S09C031 "How long has ... been seeking work (Years)?"
label var S09C032 "How long has ... been seeking work (Months)?"
label var S09C033 "How long has ... been seeking work (Days)?"
label var S09C04 "Was ... available for work during the past week?"
label var S09C05 "What type of work would ... be available for?"
label var S09C06 "Why was ... not available to work?"
label var S09C07 "Would ... be willing to?"
label var S09C08 "Has ... ever worked in?"
label var S09C09 "Did ... work in the last 12 months?"
label var S09C10 "What was the main occupation, in other words, what was the nature of the work previously did?"
label var S09C11 "What was the nature of the work done by the enterprise such as shop, or business where ... previously worked?"
label var S09C12 "What was ... employment status?"
label var S09C13 "For how many years has ... been doing this sort of work?"
label var S09C14 "What was the main reason for leaving the last job/business?"

// Seperating the Province from PrCode
clonevar PrCode1 = PrCode
tostring PrCode1, replace
gen Province = substr(PrCode1, 1, 1)
label var Province "Province" 
destring Province, replace
lab def Province 1 "Khyber Pakhtunkhwa" 2 "Punjab" 3 "Sindh" 4 "Balochistan" 6 "Islamabad" 
lab value Province Province

// The dependent variable
gen wages1 = (52 * S07C03) if S07C04 == .
gen wages2 = (12 * S07C04) if S07C03 == .
egen totwages = rowtotal (wages1 wages2 S07C05)
histogram totwages
graph export "C:\Users\Shehroz Jawad Khan\Desktop\Semester2\Econometrics\Project\New folder\histogram_wages.png", as(png) name("Graph")
gen ln_wages = ln(totwages)
lab var totwages "Total wages"

// Division of the independent variable of education into 4 categories of education
gen education = 1 if inlist(S04C09, 1, 2, 3)
replace education = 2 if S04C09 == 4
replace education = 3 if inlist(S04C09, 5, 6, 7)
replace education = 4 if inrange(S04C09, 8, 15)
lab def education 1 "preprimary" 2 "primary" 3 "Secondary" 4 "Tertiary"
lab value education Education
label var education "Education"

// Further creating dummies for education and labeling values
gen preprimary = 1 if education == 1
replace preprimary = 0 if inlist(education, 2, 3, 4)
lab val preprimary preprimary
gen primary = 1 if education == 2
replace primary = 0 if inlist(education, 1, 3, 4)
lab val primary primary
gen secondary = 1 if education == 3
replace secondary = 0 if inlist(education, 1, 2, 4)
lab val secondary secondary
gen tertiary = 1 if education == 4
replace tertiary = 0 if inlist(education, 1, 2, 3)
lab val tertiary tertiary 

// Contructing expected experience for the control variable
gen expected_exp = (S04C06 - S04C09 - 6) // fixing 6 as the age at which school started
replace expected_exp = 0 if inrange(expected_exp, -10, -1) // exp is not negative
label var expected_exp "Expected Experience"

// Constructing Family income as a control variable 
bys PrCode: egen fam_inc = total(totwages)
egen tag_1 = tag(PrCode)
gen familyincome = fam_inc if tag_1 == 1
gen ln_faminc = ln(familyincome)
label var ln_faminc "family income"

// Constructing hours worked as a control variable 
gen hrsworked = (52 * S05C171) // since the original variable provided hrs worked last week

// Limiting age to that above 10 years and older
gen working_age = S04C06 if S04C06 >= 10

// Removing all data except that of Punjab and Sindh
sort Province
keep if inlist(Province, 2, 3)

// storing the dependent variable and explanatory variables in global
global ylist ln_wages
global xlist preprimary primary secondary expected_exp ln_faminc hrsworked working_age

// Describing, summarizing, and tabulating dependent variable and explanatory variables.
desc $ylist $xlist
summ $ylist $xlist if Province == 2
outreg2 using summarypunjab.rtf, replace sum(detail) eqkeep (N mean sd min max) keep ($ylist $xlist ) label 
summ $ylist $xlist if Province == 3
outreg2 using summarysindh.rtf, replace sum(detail) eqkeep (N mean sd min max) keep ($ylist $xlist) label 

// Descriptive statistics by quantile 
sort $ylist 
xtile ybar = $ylist, nq(4)
bys ybar: sum $ylist $xlist 

// OLS regression
reg $ylist $xlist if Province == 2, cluster(PrCode) // For Punjab
reg $ylist $xlist if Province == 3, cluster (PrCode) // For Sindh


// As we can see that our education level dummies are statistically insignificant since p-value > alpha. Therefore, we will proceed with dropping ln_faminc and expected_exp as an explanatory variable to make our explanatory variables statistically significant

// Now we run and export OLS regression after dropping above-mentioned variables
global xlist preprimary primary secondary hrsworked working_age
reg $ylist $xlist if Province == 2, cluster (PrCode) // For Punjab
*Testing for overall significance of the model for Punjab
test preprimary = primary = secondary = hrsworked = working_age = 0
outreg2 using regression1.rtf, replace label
reg $ylist $xlist if Province == 3, cluster (PrCode) // For Sindh
*Testing for overall significance of the model for Sindh
test preprimary = primary = secondary = hrsworked = working_age = 0
outreg2 using regression1.rtf, append label

// Testing for heteroskedacity using the Breush-Pagan test
quietly reg $ylist $xlist if Province == 2
rvfplot // clustering found
graph export "C:\Users\Shehroz Jawad Khan\Desktop\Semester2\Econometrics\Project\New folder\rvfplot_punjab.png", as(png) name("Graph")
estat hettest
* P-value is less than 0.05 for Punjab hence heteroskedacity is present
quietly reg $ylist $xlist if Province == 3
rvfplot // clustering found
graph export "C:\Users\Shehroz Jawad Khan\Desktop\Semester2\Econometrics\Project\New folder\rvfplot_sindh.png", as(png) name("Graph")
estat hettest
*P-value is less than 0.05 for Sindh hence heteroskedacity is present

// For these reasons, we will use the quantile regression technique

//Quantile regressions for the 25th, 50th, and 75th quantiles of Punjab and Sindh
qreg $ylist $xlist if Province == 2, quantile(.25)
qreg $ylist $xlist if Province == 3, quantile(.25)
qreg $ylist $xlist if Province == 2
qreg $ylist $xlist if Province == 3
qreg $ylist $xlist if Province == 2, quantile(.75)
qreg $ylist $xlist if Province == 3, quantile(.75)
qreg $ylist $xlist if Province == 2, quantile(.90)
qreg $ylist $xlist if Province == 3, quantile(.90)

// Generating quartiles
gen id = _n
gen quantiles = _n
replace quantiles = . if inrange(quantiles, 5, 178934)
replace quantiles = 0.25 if quantiles == 1
replace quantiles = 0.50 if quantiles == 2
replace quantiles = 0.75 if quantiles == 3
replace quantiles = 0.90 if quantiles == 4

// Generating Betas of explanatory variables extracted from quantile regressions of Punjab manually
gen beta_preprimary_punjab = -1.032588 if quantiles == 0.25
replace beta_preprimary_punjab = -0.9749089 if quantiles == 0.50
replace beta_preprimary_punjab = -0.9669609 if quantiles == 0.75
replace beta_preprimary_punjab = -1.066007 if id == 4

gen beta_primary_punjab = -0.7583202 if quantiles == 0.25
replace beta_primary_punjab = -0.7862782 if quantiles == 0.50
replace beta_primary_punjab = -0.8265216 if quantiles == 0.75
replace beta_primary_punjab = -0.9741167 if id == 4

gen beta_secondary_punjab = -0.5839824 if quantiles == 0.25
replace beta_secondary_punjab = -0.6357384 if quantiles == 0.50
replace beta_secondary_punjab = -0.6493211 if quantiles == 0.75
replace beta_secondary_punjab = -0.7516057 if id == 4

gen beta_hrsworked_punjab = 0.0003472 if quantiles == 0.25
replace beta_hrsworked_punjab = 0.0002144 if quantiles == 0.50
replace beta_hrsworked_punjab = 0.0001254 if quantiles == 0.75
replace beta_hrsworked_punjab = 0.0000786 if id == 4

gen beta_workingage_punjab = 0.0122141 if quantiles == 0.25
replace beta_workingage_punjab = 0.0115239 if quantiles == 0.50
replace beta_workingage_punjab = 0.013798 if quantiles == 0.75
replace beta_workingage_punjab = 0.0156614 if id == 4

gen beta_Cons_punjab = 11.06088 if quantiles == 0.25
replace beta_Cons_punjab = 11.84473 if quantiles == 0.50
replace beta_Cons_punjab = 12.34071 if quantiles == 0.75
replace beta_Cons_punjab = 12.79002 if id == 4



br quantiles beta_preprimary_punjab beta_primary_punjab beta_secondary_punjab beta_hrsworked_punjab beta_workingage_punjab beta_Cons_punjab

// Plotting the results for the province of Punjab
twoway scatter beta_preprimary_punjab quantiles || qfit beta_preprimary_punjab quantiles
graph export "C:\Users\Shehroz Jawad Khan\Desktop\Semester2\Econometrics\Project\New folder\beta_preprimary_punjab_scatter.png", as(png) name("Graph") 
twoway scatter beta_primary_punjab quantiles || qfit beta_primary_punjab quantiles
graph export "C:\Users\Shehroz Jawad Khan\Desktop\Semester2\Econometrics\Project\New folder\beta_primary_punjab_scatter.png", as(png) name("Graph")
twoway scatter beta_secondary_punjab quantiles || qfit beta_secondary_punjab quantiles
graph export "C:\Users\Shehroz Jawad Khan\Desktop\Semester2\Econometrics\Project\New folder\beta_secondary_punjab_scatter.png", as(png) name("Graph")
twoway scatter beta_hrsworked_punjab quantiles || qfit beta_hrsworked_punjab quantiles
graph export "C:\Users\Shehroz Jawad Khan\Desktop\Semester2\Econometrics\Project\New folder\beta_hrsworked_punjab_scatter.png", as(png) name("Graph")
twoway scatter  beta_workingage_punjab quantiles || qfit beta_workingage_punjab quantiles
graph export "C:\Users\Shehroz Jawad Khan\Desktop\Semester2\Econometrics\Project\New folder\beta_workingage_punjab_scatter.png", as(png) name("Graph")
twoway scatter beta_Cons_punjab quantiles || qfit beta_Cons_punjab quantiles 
graph export "C:\Users\Shehroz Jawad Khan\Desktop\Semester2\Econometrics\Project\New folder\beta_Cons_punjab_scatter.png", as(png) name("Graph")

// Generating Betas of explanatory variables extracted from quantile regressions of Sindh manually

gen beta_preprimary_sindh = -1.020886 if quantiles == 0.25
replace beta_preprimary_sindh = -1.107581 if quantiles == 0.50
replace beta_preprimary_sindh = -1.080604 if quantiles == 0.75
replace beta_preprimary_sindh = -1.109332 if id == 4

gen beta_primary_sindh = -0.9071166 if quantiles == 0.25
replace beta_primary_sindh = -0.9722295 if quantiles == 0.50
replace beta_primary_sindh = -0.9336079 if quantiles == 0.75
replace beta_primary_sindh = -1.03922 if id == 4

gen beta_secondary_sindh = -0.7049347 if quantiles == 0.25
replace beta_secondary_sindh = -0.7330837 if quantiles == 0.50
replace beta_secondary_sindh = -0.6391279 if quantiles == 0.75
replace beta_secondary_sindh = -0.6484917 if id == 4

gen beta_hrsworked_sindh = 0.0002047 if quantiles == 0.25
replace beta_hrsworked_sindh = 0.000141 if quantiles == 0.50
replace beta_hrsworked_sindh = 0.0001295 if quantiles == 0.75
replace beta_hrsworked_sindh = 0.0001034 if id == 4

gen beta_workingage_sindh = 0.0125989 if quantiles == 0.25
replace beta_workingage_sindh = 0.0154841 if quantiles == 0.50
replace beta_workingage_sindh = 0.0194719 if quantiles == 0.75
replace beta_workingage_sindh = 0.0211517 if id == 4

gen beta_Cons_sindh = 11.5176 if quantiles == 0.25
replace beta_Cons_sindh = 11.9863 if quantiles == 0.50
replace beta_Cons_sindh = 12.15115 if quantiles == 0.75
replace beta_Cons_sindh = 12.49659 if id == 4

br quantiles beta_preprimary_sindh beta_primary_sindh beta_secondary_sindh beta_hrsworked_sindh beta_workingage_sindh beta_Cons_sindh

// Plotting the results for the province of Sindh
twoway scatter beta_preprimary_sindh quantiles || qfit beta_preprimary_sindh quantiles 
graph export "C:\Users\Shehroz Jawad Khan\Desktop\Semester2\Econometrics\Project\New folder\beta_preprimary_sindh_scatter.png", as(png) name("Graph")
twoway scatter beta_primary_sindh quantiles || qfit beta_primary_sindh quantiles
graph export "C:\Users\Shehroz Jawad Khan\Desktop\Semester2\Econometrics\Project\New folder\beta_primary_sindh_scatter.png", as(png) name("Graph")
twoway scatter beta_secondary_sindh quantiles || qfit beta_secondary_sindh quantiles
graph export "C:\Users\Shehroz Jawad Khan\Desktop\Semester2\Econometrics\Project\New folder\beta_secondary_sindh_scatter.png", as(png) name("Graph")
twoway scatter beta_hrsworked_sindh quantiles || qfit beta_hrsworked_sindh quantiles
graph export "C:\Users\Shehroz Jawad Khan\Desktop\Semester2\Econometrics\Project\New folder\beta_hrsworked_sindh_scatter.png", as(png) name("Graph")
twoway scatter  beta_workingage_sindh quantiles || qfit beta_workingage_sindh quantiles
graph export "C:\Users\Shehroz Jawad Khan\Desktop\Semester2\Econometrics\Project\New folder\beta_workingage_sindh_scatter.png", as(png) name("Graph")
twoway scatter beta_Cons_sindh quantiles || qfit beta_Cons_sindh quantiles 
graph export "C:\Users\Shehroz Jawad Khan\Desktop\Semester2\Econometrics\Project\New folder\beta_Cons_sindh_scatter.png", as(png) name("Graph")


// It must be mentioned here that we wanted to plot the betas of all the variables against .25, .50, .75, .90 quantiles. For that we had to extract the betas from the regressions. There was no easy way to do this, that is why we manually constructed variables for betas of all the variables for each province. Finally, we produced graphs with betas on the y axis and quantiles on the x axis for all variables for each province. It was a cumbersome work, but it had to be done. 

// Thank you! 

































