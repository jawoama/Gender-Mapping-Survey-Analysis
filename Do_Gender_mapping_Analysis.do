********************Gender Mapping Survey Analysis************************
clear
set more off
****Import Dataset
use "C:\Users\22031\Desktop\main_master.dta"

***Replacing variables with similar names as one variable using different regions*******

// Replacing names in West coast region(WCR) as WCR
replace  Region="WCR" if substr(Region, strpos( Region,"WCR"), .)!=""|substr(Region, strpos(Region,"West Coast"), .)!=""|substr(Region, strpos(Region,"West Coast Region"), .)!="" ///
|substr(Region, strpos(Region," west  Coast Region"), .)!=""|substr(Region, strpos(Region,"west Coast"), .)!="" ///
|substr(Region, strpos(Region,"west Coast Region"), .)!=""|substr(Region, strpos(Region,"west coast"), .)!="" ///
|substr(Region, strpos(Region," west coast Region"), .)!=""|substr(Region, strpos(Region,"west coast region"), .)!="" ///
|substr(Region, strpos(Region,"west cost Region"), .)!="" |substr(Region, strpos(Region,"West Coast Region"), .)!="" ///
|substr(Region, strpos(Region,"west cost Region"), .)!="" |substr(Region, strpos(Region,"West Coast Region"), .)!="" ///
|substr(Region, strpos(Region," West Coast"), .)!="" |substr(Region, strpos(Region,"West Cost Region"), .)!="" ///
|substr(Region, strpos(Region,"west  Coast Region"), .)!="" |substr(Region, strpos(Region,"West Coast"), .)!="" 

// Replacing names in Lover River Region(LRR) as LRR
replace  Region="LRR" if substr(Region, strpos( Region,"LOWER RIVER REGION"), .)!=""|substr(Region, strpos(Region,"Lower River region "), .)!="" ///
|substr(Region, strpos(Region,"lower River region"), .)!=""|substr(Region, strpos(Region,"lower river region "), .)!="" ///
|substr(Region, strpos(Region,"lower river region"), .)!=""|substr(Region, strpos(Region,"Lower River region"), .)!="" 

// Replacing names in Central River Region(LRR) as CRR
replace  Region="CRR" if substr(Region, strpos( Region,"central river region"), .)!=""

// Replacing names in North Bank Region(NBR) as NBR
replace  Region="NBR" if substr(Region, strpos( Region,"NBD"), .)!=""  |substr(Region, strpos(Region,"NBR5"), .)!=""|substr(Region, strpos(Region,"North Bank"), .)!="" ///
|substr(Region, strpos(Region,"North ban6"), .)!=""|substr(Region, strpos(Region,"North bank"), .)!="" ///
|substr(Region, strpos(Region,"Upper Nuimi"), .)!=""|substr(Region, strpos(Region,"lower Nuimi"), .)!="" ///
|substr(Region, strpos(Region,"upper Nuimi"), .)!=""|substr(Region, strpos(Region," Lowe Nuimi"), .)!="" ///
|substr(Region, strpos(Region,"Lower Nuimi"), .)!="" |substr(Region, strpos(Region,"Lower Nuimi district"), .)!="" ///
|substr(Region, strpos(Region,"Lowe Nuimi"), .)!=""

// Drop unkonwn locations
drop if Region=="##N/A##"

*****Droping outliers in age*****
drop if age_respon==3251289
drop if age_respon<=17
// Grouping (age into youths(18-35) and non-youths above 35 years
gen age_group=(age_respon>=18&age_respon<=35)
//Label and define values for age_group
label values age_group age
label define age 0"Above Youthful age" 1"Youthful age"
**** labelling value  and defining  education*****
label values educ_respond edu
label define edu 1"Attended formal education" 2"Do not attend formal education"

****Renaming Purpose land is use for*****
rename use_land__1 Field_crop_farming
rename use_land__2 Vegetable_farming
rename use_land__3 Residential_Purpose
rename use_land__4 Rent_Farmers
rename use_land__5 Rearing Livestocks
rename use_land__5 Rearing_Livestocks

****Label project Site as intervention and non intervention site*********
label values project_interven pro
label define pro 1" Intervention SIte" 2" Non-Intervention Site"

******Analysis of 	Demographic characteristics using tables and graphs*******

// Graphing relationship between age and gender using line of fits and scatter plot
graph twoway (lfit age_respon gen_respod) (scatter age_respon gen_respod)
// Histograh and density plot showing the age distribution of respondents
histogram age_respon, kdensity
// Table for region, by gender and age_group
table region, stat(fvpercent age_group gen_respod ) nformat(%5.2f)
// Tabulation of region by project site( i.e Intervention and non intervention site)
tab region project_interven, row
// Bar Chart of mean of houshold head by gender
graph bar head_house, by(gen_respod)
// Tabulation of Who is responsible for household earnings 
tab responsi_incom
// Pie chart of formal education
graph pie, over( educ_respond ) plabel(_all percent) scheme(yale)
// Tabulation of primary soure of income
tab primary_sour
// Bar Chart for Average income made per harvest in a year
graph bar,over( income_harv ) asyvars blabel(bar, format(%9.1f))
// Pie Chart for recieved loan or not
graph pie, over( receive_loan ) plabel(_all percent) scheme(yale)



***********Land Ownership and Cultivation*************
//tabulate land ownership
tab land_own
// Bar chart of Land area per plot own 
graph bar,over( hecter_lan ) asyvars blabel(bar, format(%9.1f))
// Bar chart for usage of land by Region
graph bar Field_crop_farming Vegetable_farming Residential_Purpose Rent_Farmers Rearing_Livestocks , over(Region)
//Bar Chart for usage of land by project and non project intervention site
graph bar Field_crop_farming Vegetable_farming Residential_Purpose Rent_Farmers Rearing_Livestocks , over( project_interven )
// Who Cultivates the land
graph bar myself Daughter Son Father Mother Husband Hired_Labor , over(Region)
// Do you encouter challeges in renting a land_own
tab encounter
// What kind of challenges Do you encounter
graph bar Gender_equality Sexualharrassement Forcefullytakeoverofland Seduction High_cost unfavourablelandtenurerights Renting Infertilelands others , over(Region)

*******************WOMEN'SROLESAND RESPONSIBILITIES ON VEGETABLE VALUE CHAIN********************
//role along the vegetable value chain
graph bar Producer Processor Marketer Supplier, over( project_interven ) asyvars blabel(bar, format(%9.1f)) percent
//wheredo you think one can make moreprofit?
graph bar Producer1 Processor1 Marketer1 Supplier1 , over( project_interven ) asyvars blabel(bar, format(%9.1f)) percent
//your responsibilities as vegetables  producer
graph bar weeding Fertilising Land_Plowing Watering Seedlings Pest_Management Harvesting Others , over( project_interven ) asyvars blabel(bar, format(%9.1f)) percent
//your responsibilities as vegetables processor
graph bar Cleaning Preserving Juicing Packaging Freezing Drying Storage Others1 , asyvars blabel(bar, format(%9.1f)) percent
// your responsibilities as vegetables supplier (input providers)
graph bar Selling_seeds Provide_information_to_farm Selling_farming_equipments Selling_Fertilizer Selling_improved_seeds Others3 , over( project_interven ) asyvars blabel(bar, format(%9.1f)) percent
//your responsibilities as vegetables marketer (Wholesaler and Retailer)
graph bar Transportation Retailing Bulk_Selling Advertisment Pricing Compare_Price_with_competitors Delivery_base_on_order Others4 , over( project_interven ) asyvars blabel(bar, format(%9.1f)) percent


*****Strengths and Weaknesses, Opportunities and Threats (SWOT) analysis to realizing the growth potentials of women, particularly poor and extreme poor, in the value chain******
//Causes of increase in growth potentials in the vegetable value chain
graph bar Availability_farming Availability_underground_water Access_Market Access_Labor_supply Access_processing_facilities Access_communal_garden Access_transport Access_Finance Others6 , over( project_interven ) asyvars blabel(bar, format(%9.1f)) percent 

// what affects your growth potentials in the vegetable value chain
graph bar Lack_storage_facilities Lack_processing_facilities Inadequate_packaging_facilities Lack_proper_irrigation_system Market_access Lack_pest_diseases_control Access_Finance1 Availabilit_storage_facilities Access_communal_garen Lack_fertilizer Lack_seeds Others5 , over( project_interven ) asyvars blabel(bar, format(%9.1f)) percent
// opportuinities that increase your growth potential in the vegetable value chain
graph bar Training Access_Finance2 Acess_market3 Potential_expansion Proper_Irrigation Government_support Access_equipment Others7 , over( project_interven ) asyvars blabel(bar, format(%9.1f)) percent
// Threats affect your  growth potential in the vegetable value chain
graph bar Climate_Change Pest_Diseases Price_violatility Rural_urban_migration Financial_Constraint High_cost_inputs Expired_Seeds Lack_farmland Lack_irrigation Others9 , over( project_interven ) asyvars blabel(bar, format(%9.1f)) percent
//Spending Decision
asdoc tab financial project_interven, col save(gender)
// Make management decision
asdoc tab management project_interven, col save(gender)
// Satisfaction of the way the finance is being manage
asdoc tab satisfied_vege project_interven, col save(gender)
// What could help to manage finace better
graph hbar Lack_financial_iliteracy High_Dependency Social_commitment Lack_access_finance_situation Lack_Financial_Discipline Lack_Saving Others99 , over( project_interven ) asyvars blabel(bar, format(%9.1f)) percent
// What could help to manage finance better
graph hbar Training1 Coaching_Mentoring Saving Financial_Discipline Access_Bank Low_Dependency , over( project_interven ) asyvars blabel(bar, format(%9.1f)) percent
// How managing finance to statisfaction
graph hbar Saving Reinvestmenst Proper_Planing Financial_Discipline Less_focus_social_events Others, over( project_interven ) asyvars blabel(bar, format(%9.1f)) percent
//Decision making if you want to venture into any category along the vegetable value chain
asdoc tab spend_decision project_interven, col

*******************Land tenure system affects/influence large-scale production of onion and other horticulture crops in the intervention regions and how this can be mitigated to increase women's access to and ownership of productive assets including Land********************

// type of land tenure system are you engaged in
asdoc tab tenure_engage  project_interven, col nofreq save(engage)

//Did land tenure system help increasing your productivity 

//What were the factors that helped you in increasing your productivity  during the land tenure system
graph hbar Availability_storage_facility secure_safety_land Access_Market3 Favourable_rental_cost Large_Land_size Favourable_land_rights Access_land_fertility Proximity_land_community others99 ,over( project_interven ) asyvars blabel(bar, format(%9.1f)) percent

//What were the factors that affected your productivity during the land tenure system
graph hbar Lack_Storage_facility Lack_security_safety_Land Lack_access_market High_rental_cost_land Small_Land_Size Unfavorable_Land_rights Infertility_Land Farm_Land_far_from_community Others33 ,over( project_interven ) asyvars blabel(bar, format(%9.1f)) percent
//To what extend has the land tenure system affected your productiv
tab project_interven extend_affect, row nofreq

************Projections on how increased productive workload in the value chain impacts women's reproductive and domestic role and how this could be mitigated on a more sustainable way************
//Does increased productive workload affect the reproductive role of women in the vegetable value chain
tab project_interven workload_repro , row nofreq 
//Which of the following reproductive role  of women is/are affected by increased in productivity in the vegetable value chain
graph hbar Child_Bearing Child_Rearing Breastfeeding Caring_for_sick Adult_Care ,over( project_interven ) asyvars blabel(bar, format(%9.1f)) percent
//How does  increased in productivity in the vegetable value chain affect  the reproductive role of women 
graph bar Reduce_Breastfeeding_time Reduction_in_child_bearing Limited_concentration Lack_concentration_adultcare Lack_focus_on_sick Others65 ,over( project_interven ) asyvars blabel(bar, format(%9.1f)) percent
// How severe does  increased in productivity in the vegetable value chain affect  the reproductive role of women
asdoc tab project_interven servere_repro, row nofreq save(rep)

//What are the stratgies to reduce the impact of increase productive workload on the reproductive  role of women 
graph bar Proper_time_management Proper_planning Increase_in_child_bearing Hire_Labor Close_proximity_farmland Division_labor Others11 ,over( project_interven ) asyvars blabel(bar, format(%9.1f)) percent
// Does increased productive workload in the vegetable value chain affect the domestic  role of women 
asdoc tab domestic_role project_interven, save(do)

// Which of the following domestic  role  of women is/are affected by increased in productivity in the vegetable value chain
graph bar Fetching_water Cooking Firewood_colection Household_chores Care_Provision ,over( project_interven ) asyvars blabel(bar, format(%9.1f)) percent
// How does increased productive workload affect the domestic role of women 
graph bar Lack_time_fatch_water limited_or_no_water_at_home Lack_of_time_to_collect_firewood Limited_or_no_firewood_at_home Cooking_late Neglence_household_chores Others13 ,over( project_interven ) asyvars blabel(bar, format(%9.1f)) percent
// What are the stratgies to reduce the impact of increase productive workload on the domestic role of women 
graph bar Improve_household_water_source Hire_Labor1 Use_Fuel_efficient_stoves Division_of_labor Proper_Planning Others14 ,over( project_interven ) asyvars blabel(bar, format(%9.1f)) percent



**************Strategic interventions to increase access to productive resources (such as land and water, training and the time required to develop a viable livelihood) and services and improve the involvement of women in decision making in different spheres including household finance****************

// Which main support do you urgently need that could increase your productivity and income in the vegetable value change
graph bar Access_of_finance Access_to_equipment Increase_Land_ownership Increase_capacity_and_training Provide_cold_store_faciltiy Access_to_market Irrigation Electricity Fertilizer Seed Others15 ,over( project_interven ) asyvars blabel(bar, format(%9.1f)) percent























 
