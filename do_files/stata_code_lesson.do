clear all
set more off
cd "C:\Users\DELL\Dropbox\stata_lesson"
capture mkdir outputs
capture mkdir ".\outputs\data"
capture mkdir ".\outputs\graphs"
capture mkdir ".\outputs\tables"

******************************************************
*************** Lesson 1, Hello Stata ****************
******************************************************

/*
first lesson, getting to know the env.
1. Command line.
2. Prior command tab.
3. Variables tab.
4. Properties tab.
5. File tab.
6. Do-files.
*/


******************************************************
******* Lesson 2, basic coding, getting help   *******
******************************************************

clear all
set more off
set obs 100

**** 1. Basic Coding

* a command is made of a program or function, and it syntax.
* in stata, we first tell stata the command we want it to call,
* and then write what we want depending of the syntax of the command

* example:
gen x = 1

* gen, is the call of the function. 
* after typing gen, we need to type the syntax of that specific command
* to see the syntax of a command, we type "help" and that command
help generate

* here specifaclly, we see the synatx is 
* "name of new variable" = (equal sign) "some expression"

* example: 
sum x

* sum, is the call of the function sum, which describes statistics of variables
* after typing sum, the syntax is to type the names of the variables we
* want to summarize over. 

**** 2. Getting Help

* help is the best helper, type
help help
chelp summarize 
help twoway
* and so on

*if not in stata itself, we go to google
* type in google "how to create new directory in stata command"

* we will probably get explanation on mkdir command, right?

* what if we don't find? Go to stata list.
*www.statalist.org

* enter forum, general, read faw
* before posting question, check very well no one asked before
* if have to ask, post all relevant info:
* data, commands, data lines, and so on. Good guidelines in the faq.

***** 3. An example project folder

* We set up a working directory.
* the command is "cd"
help cd
* empty command "cd" tells you what is the working directory set right now
cd

* typing a directory after "cd" changes to new directory.

* all stata outputs and inputs will be saved \ searched for in the 
* working directory you set up, so VERY important.

*** Example project folder:

* Tip: always keep projects well organized. 
* when you come back an year later, your memory won't help you, 
* but a well organzied folder will make it easy to move around.

* basic setup example:
	* inputs (includes raw data from various sources)
	* do files (data, descriptive, regression, master)
	* outsputs (tables, data, graphs)
	* readme \ codebooks
	* pdfs \ presentations
	
* Tip: create master do-files so order of programs is clear.

* an example of a master script:
	
	cd "some_master_directory/do_files"
	do "import_data.do"
	do "create_variables.do"
	do "export_tables.do"

******************************************************
***** Lesson 3, Data: types, upload and saving  ******
******************************************************

clear all
set more off
set obs 100

***** 1 data types.

* variables are defined by a specific data type.
* variables with numbers, called numeric, can be
	* byte, int long ...
* type:
help data type
* variables with non-number / alphabetic characters are called strings.

* 1.2. data types: numeric
* can specify when generating, what type of data type that variable is

* example

gen byte x = 100
gen byte x1 = 101

* what happend to x1? type:
browse
* we defined x1 to be data type "byte" which is limited to a
* maximum of 100, so stata put missing values instead of 100.

* to change a data type of a variable we use command "format"
help format

* exercise: format x1 to format %10.0g .

format x1 %10.0g

* we now show that we can input numbers we couldn't before
replace x1 = 1000
* type browse to see this worked.
browse

* 1.2. String
* create a variable called "name" with my name in it
gen name = "Dor Leventer"
browse
describe
* change it to something longer
replace name = "This is a very long string to show a point"
* observe stata changed the data type so it can put all those characters
* into the variable "name"
describe

* 1.3. Dates:
* last data type of stata is date,
* we won't go into this type here,
* read google / stata help for documentation.

* Tip: to understand dates in stata, think of it as number all the possible dates
* by numbers, e.g. 05/10/2020 will get some number value: 1004350.
* all dates with smaller numbers are, as you can guess, earlier dates.

*** 2. Uploading data

* download data from 
* https://github.com/dorlev3/stata_basic_programming/tree/main/data
* specifically download "merge_data1.dta"

* the directory you saved it into, 
* i.e.: "C:\Users\DELL\Downloads"
* type the name of the data after it, using the command "use"

help use

* example:
use "C:\Users\DELL\Downloads\merge_data1.dta" 

* note the error - stata won't let us upload data since we have data in 
* memory. to clean memory, type "clear"
clear
use "C:\Users\DELL\Downloads\merge_data1.dta" 

* to shorten this, we just type together
use "C:\Users\DELL\Downloads\merge_data1.dta" , clear

* stata can also import csv, excel, sas and more different data types.
* press tab file, and go to import, to manually import a data-table.


*** 3. reading data
* so we have seen this before, type "browse" or "br"
* to look at the data
browse
br

* note that in browse mode, we can only view the data,
* not change it. If we were to open "edit" mode, 
* then one can change the data directly. 
* note that we can use "edit" mode to 
edit

* Tip: this is highly not recommened, since changes in edit
* mode are not recored in do-file, so you won't know what you 
* did to the data later on.

*** 4. saving data.
help save
* we save stata data files, filename.dta, using the save command

* example

save filename

* note that if the same name exists, we get an error
* type again
save filename

* to save, we need to tell stata to replace the file
save filename , replace

* Tip: it is good practice to always specify rename after save command, 
* so won't get error when running same do-file multiple times. 

* Tip: specify file location to control where data is saved
save "P:/personal/stata_lesson/outputs/data/saved_data_file_name" , replace

* if you won't, stata will automatically save in working directory.

******************************************************
*********** Lesson 4, manpiulating data  *************
******************************************************

/*

1. generating variables and subsetting.

1.1. gen and replace
1.2. drop.
1.3. keep.

*/

clear all
set more off
cd "P:/personal/stata_lesson"
use "P:/personal/stata_lesson/inputs/data/merge_data1" , clear

gen my_first_var = 1
gen second_var = my_first_var * 10
gen third = second_var + x1 * 2 + x3 / 4

replace my_first_var = 2
replace second_var = my_first_var * 3 + 12

drop second_var
drop x1 x2 x3

keep id my_first_var
keep id

/*
2. sum and tab

2.1. summarize a variable
2.2. one-way tabulate a variable
2.3. two-way tabulate a variable
2.4. two-way tabulate a variable combined with "by"

*/

clear all
set more off
cd "P:/personal/stata_lesson"
use "P:/personal/stata_lesson/inputs/data/merge_data1" , clear

* type help sum
sum x1
sum x1 x2
sum x* /* same as writing: sum x1 x2 x3 */

* type help tab
* choose tabulate oneway

tab x3
tab x3 x4

replace x4 = . if _n > 80

tab x3 x4
tab x3 x4, missing

* tip: sometimes it is useful to add option: no label, for example
* tab x3 x4, missing nolabel

/*
3. ifs and looping

3.1. replace a variable using if
3.2. create a categorical variable using if
3.3. loop over values using forvalues
3.4. loop over varlist using foreach

*/

clear all
set more off
cd "P:/personal/stata_lesson"
use "P:/personal/stata_lesson/inputs/data/merge_data1" , clear

*** If

* simple use of "ifs" - condition variable making

gen cond_var = 10
replace cond_var = 8 if x3 == 1

* logical operators:

	* double equal == for equal condition
	* exclamation mark and equal != for unequal condition
	* & for and condition
	* | for or condition
	* > and >= for greater and greater or equal
	* < and <= for lesser or lesser or equal
	
* examples:

replace cond_var = 7 if x3 != 2
replace cond_var = 6 if x3 == 1 & x4 == 2
replace cond_var = 5 if x3 == 1 | x4 == 10
replace cond_var = 4 if x4 >= 7
replace cond_var = 3 if x4 > 8 | x4 < 3

* can use "ifs" in summary statistics

sum x1 if x3 == 1
sum x1 if x4 != 2 & x3 < 3

tab x3 x4 if x1 > 50

* can be used in regression, graphs, and more to condition inputs to commands
* advanced if and else programming after introduction of globals and locals

*** For

* stata incorporates two kinds of looping, forvalues and foreach

* forvalue goes over a range of numerical values.

* Example:

	* i is the running variable
	* 1 is the minimum variable in the range i runs over
	* 10 is the maximum variable in the range
	* note the curly braces, and that code is one line beneath forvalues command
	* Tip: indent command after initial loop command to keep track of what goes into loop
	
forvalues i = 1 / 10 {
	di `i'
}

* in general:
/*
forvalues running_variable = min_range / max_range {
	looping commands
}
*/

* note that you can shorten command / jump values

forval i = 2(2)20 {
	di `i'
}

* can use "to" to specify jump values
forval i= 5 10  to 100 {
	di `i'
}

* switch "to" to ":"
forval i= 5 15 : 100 {
	di `i'
}

* can use loop within loop

forval i = 1/10 {
	forval j = 0.1(0.1)1 {
		di `i' * `j'
	}
}


*foreach goes over a list of objects, and runs code separately for each

* Example:

	* var is the running variable
	* x1 x2 x3 is a list of objects var will run over
	* note the curly braces, and that code is one line beneath forvalues command
	* Tip: indent command after initial loop command to keep track of what goes into loop

foreach var in x1 x2 x3 {
	sum `var'
}

* for easy to use with locals / globals which are lists of objects, more on that later.

* can also use numeric values directly

foreach num in 1 5 10 {
	di `num'
}

* type help foreach for more.
* we will use in later lessons.



******************************************************
*********** Lesson 5, combining datasets *************
******************************************************

* two main ways to combine datasets, append and merge.

* append pushes a dataset below another one.
* type help append


* consider the data set

clear all
set more off
cd "P:/personal/stata_lesson"
use "P:/personal/stata_lesson/inputs/data/append_data2" , clear

* now consider 

use "P:/personal/stata_lesson/inputs/data/append_data1" , clear

* if we want to combine the data2 below the data1, i.e. append them, we use

append using "P:/personal/stata_lesson/inputs/data/append_data2"

* we can generate a file number to know which data set an observation
* originally belonged to

use "P:/personal/stata_lesson/inputs/data/append_data1" , clear
append using "P:/personal/stata_lesson/inputs/data/append_data2" , gen(filenum)

* Tip: can label variable to remember
label variable filenum "0 from append_data1, 1 from append_data2"
* Tip can also label values to remember
label define files 0 "append_data1" 1 "append_data2"
label values filenum files
* type br to view result
* type help label for documentation

* another way is to loop over files we want to append
* first upload a data
use "P:/personal/stata_lesson/inputs/data/append_data1" , clear

foreach data_file in "P:/personal/stata_lesson/inputs/data/append_data2"  "P:/personal/stata_lesson/inputs/data/append_data2" {
	append using "`data_file'"
}

2. merge

*/



******************************************************
*********** Lesson 6, locals and globals *************
******************************************************

*** Globals

clear all
set more off
cd "P:/personal/stata_lesson"

* create a global using the global command

global some_global = 1234

* call the global using the dollar sign and curly parentheses

display ${some_global}

* can call without parentheses, but sometimes this solves bugs
* note also equal sign isn't needed, but is convenient for user

global some_global 1234
di $some_global

* use globals to set folder locations in start of do file

global Path "P:/personal/stata_lesson"
global InDat "${Path}/input/data"

use "${InDat}/merge_data1" , clear

* another use is to set a string of variables, e.g. for use in similar models
* for example
global base_model = "x1 x2"

reg y ${base_model}
reg y ${base_model} x3
reg y ${base_model} x4


*** Locals

* we create locals in a similar way to globals, using the local command

local some_local = 1234

* call the local using the ` sign next to the number 1 on the keyboard and
* ' sign, which is a single ", as follows

display `some_local'

* use locals while running loops
* when using a loop, the running variable is called like a local

forvalues i = 2000/2005 {
	di `i'
	* locals can be used to create other locals
	local temp = `i' - 2000
	di `temp'
}

* stata by itself stores estimates as locals after estimation and descriptive commands
* run help sum

sum x1
* after sum, stata saves the local r(max) as the maximum of the output
di `r(max)'

* excerise: display the minimum, mean and number of observations.

	* first, type help sum

	* choose the summarize option

	* scroll down to "Stored results"

	* for example, r(N) is the local stored after sum for the number of observations.

* excerise: create a loop that goes over the variables x1 x2 and x3
* and store the maximum of each, and display the minimum of all the maximums

global needed_maximum = "x1 x2 x3"
foreach var in ${needed_maximum} {
	sum `var'
	local max_`var' = `r(max)'
}
di min(`max_x1',`max_x2',`max_x3') /* note min() function outputs minimum value over list */

* this excerise shows how use of locals can create simiple and elegant coding solutions.

*** Tip: combine locals with forvalues ranges
* for dynamic programming, less errors
local min_year = 2000
local max_year = 2010
forvalues year = `min_year' / `max_year' {
	di `year'
}

*** advanced programming if and else

* _N is the number of observations in the dataset
local n = _N
if `n' == 100 {
	di "Dor created this data"
}
else { 
	di "Dor did not create this data"
}

* in a general sense:
/* 
if (exp1 cond exp2) {
	code run if condition true
}
else {
	code run if condition false
}
*/
* note that "else" doesn't have to be specified.



******************************************************
*********** Lesson 7, generating fake data ***********
******************************************************

* do file setup
clear all
set more off

* creating data table with 100 empty observations
set obs 100

* generating a variable called x
gen x = 1
replace x = 2 if _n > 33
replace x = 3 if _n > 66

* set seed determines that the generation of random variables will always be the same
set seed 1
* generating a variable called epsilon with uniform distribution, mean 0 and sd 0.2
gen epsilon = rnormal(0,0.2)

* creating a local called beta
local beta = 5

* generating a variable called y constructed from other variables
gen y = `beta' * x + epsilon

* generating social-economic-score, as string, based with probability on "x" variable of individual
set seed 1
gen random_uniform = runiform()
gen SES = "" 
forvalues i=1/3 {
	replace SES = "Low" if x == `i' & random_uniform <= (0.4/`i')
	replace SES = "Medium" if x == `i' & random_uniform > (0.4/`i') & random_uniform <= (0.8/`i')
	replace SES = "High" if x == `i' & random_uniform > (0.8/`i')
}

* tabulate to view summary of SES by x
tab SES x

* generating numeric variable to allow procedures that need numeric inputs
egen SES_num = group(SES)
replace SES_num = 0 if SES_num == 2
replace SES_num = 2 if SES_num == 1
replace SES_num = 1 if SES_num == 3

replace SES_num = SES_num + 1

tab SES_num x

* labeling values and variable
label define SES_groups 1 "Low" 2 "Medium" 3 "High"
label values SES_num SES_groups
label variable SES_num "Numerical Categorical Variable of Social-Economic-Score"



******************************************************
************* Lesson 8, graphing data  ***************
******************************************************

* do file setup
clear all
set more off
cd "P:/personal/stata_lesson"
global OutGraph "./outputs/graphs"

set obs 100

* gen a variables
gen x = runiform(0,100)
gen e = rnormal(0,10)
gen y = 2 * x + e

* one graph, a scatter plot
twoway (scatter y x) 
* two graphs together, a scatter plot and a fitted line
twoway (scatter y x) (lfit y x)

* generating categorical data
rename x x1

gen x2 = 1
replace x2 = 2 if _n > 33
replace x2 = 3 if _n > 66

* this time, straight off we generate a numeric categorical variable
set seed 1
gen random_uniform = runiform()
gen SES = 1 
forvalues i=1/3 {
	replace SES = 2 if x2 == `i' & random_uniform > (0.4/`i') & random_uniform <= (0.8/`i')
	replace SES = 3 if x2 == `i' & random_uniform > (0.8/`i')
}

* labeling values and variable
label define SES_groups 1 "Low" 2 "Medium" 3 "High"
label values SES SES_groups
label variable SES "Numerical Categorical Variable of Social-Economic-Score"

replace y = 2 * x1 + 5 * SES + e

* a histogram graph shows the density of a variable
histogram y

* a bar graph show a statistic, e.g. the mean, of a variable 
graph bar (mean) y
* usually used when grouping over othe variables
graph bar (mean) y, over(SES)
* most times we want to compare between diferrent variables
graph bar (median) y x1 , over(SES)

* Tip: type what you want into google with "STATA" in the end for documentations

* Exercise 1, have each bar represent 100%, and each variable the percent out of 100.

graph bar y x1 , over(SES) percentage stack

* Exercise 2, turn the above graph bar onto its side

graph hbar y x1 , over(SES) percentage stack

* Exercise 3, add labels to bars in the above graph
graph hbar y x1 , over(SES) percentage stack blabel(bar)
graph hbar y x1 , over(SES) percentage stack blabel(bar,position(center))
graph hbar y x1 , over(SES) percentage stack blabel(bar,position(center) format(%8.1f))

* Exercise 4, label the legend: y as "Annual Income" and x1 as "Hours worked",
* some title and some note
* Tip: note triple backslash, /// to add options with multiple lines

graph hbar y x1 , over(SES) ///
					percentage stack ///
					blabel(bar,position(center) format(%8.1f)) ///
					legend(label(1 "Annual Income") label(2 "Hours Worked")) ///
					title("Annual Income and Hours Worked") ///
					subtitle("By Social Economic Score") note("Source: fake data.")

* finally, if one wants to save the graph
graph save "${OutGraph}/mygraph.gph" ,  replace


******************************************************
*************       Last Tips          ***************
******************************************************

choose variables names you understand, if have time then label variables and labels,
document - coming back after half year / year you won't remember anything, 
putexcel, outreg, saving tables from stata output directly, logging
use of _n, _N, replace in, set obs, 
indention in looping, dynamic programming (e.g. in looping ranges), 
globals as paths,
use tempfiles to save temporary playing with datasets 
