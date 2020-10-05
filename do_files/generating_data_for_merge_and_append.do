* do file setup
clear all
set more off
cd "C:\Users\DELL\Dropbox\stata_lesson"
capture mkdir inputs
cd ".\inputs"
capture mkdir data
cd ".\data"

set obs 100
gen id = _n
gen x1 = runiform()*100
gen x2 = rnormal(0,10)
gen x3 = 1
replace x3 = 2 if _n > 33
replace x3 = 3 if _n > 66

gen x4 = 1
forvalues i=10(10)90{
	local j = `i'/10 + 1
	replace x4 = `j' if _n > `i'
}

save "merge_data1" , replace

clear

set obs 100
gen id = _n
gen x5 = runiform()
gen x6 = rbinomial(50,0.8)

save "merge_data2" , replace

clear

set obs 100
gen id = round(_n/2)
gen x1 = runiform()
gen x6 = rbinomial(50,0.8)

save "merge_data3" , replace

clear

set obs 100
gen id = _n
gen x1 = runiform()*100
gen x2 = rnormal(0,10)
gen x3 = rbinomial(100,0.5)

save "append_data1" , replace

clear

set obs 100
gen id = 100+_n
gen x1 = runiform()*50
gen x2 = rnormal(0,2)
gen x3 = rbinomial(50,0.5)

save "append_data2" , replace

clear

set obs 100
gen id = 200+_n
gen x1 = runiform()*50
gen x3 = rbinomial(50,0.5)

save "append_data3" , replace
