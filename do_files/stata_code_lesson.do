******************************************************
*************** Lesson 1, Hello Stata ****************
******************************************************

clear all
set more off

global path_work "P:\personal\stata_lesson"
global path_home "C:\Users\DELL\Dropbox\stata_lesson"
cd "${path_work}"

capture mkdir inputs
capture mkdir ".\inputs\data"

capture mkdir outputs
capture mkdir ".\outputs\data"
capture mkdir ".\outputs\graphs"
capture mkdir ".\outputs\tables"

*** 1. command line.

* looks like a window with the title "Command"
* if you type something into that window, if stata understands it then it does what you told it
* type: gen x
gen x

* stata did not understand what you wanted, and produced an error in the output window.
* try typing: set obs 100
set obs 100

* stata understood what you wanted, in this case to manually set the number of observations
* to 100 (more on this later, you don't need to understand what this means right now).
* note that below the command we typed in the output window stata output what it did:

// number of observations (_N) was 0, now 100

*** 2. history (previous commands)

* looks like a window with the title "History"

* here stata tells us what commands we previously told it to do.
* this is for human use, 
* for example if we don't remember what we did before,
* or if we want to do the same command we did before

* for ease of use, if you click on a command in the history window,
* stata will copy it to the command line.

* try clicking the command "set obs 100" in the history window, and then execute it by clicking enter
* in the command line.

*** 3. variables 

* looks like a window with the title "Variables"

* here stata tells us what are the variables in the current dataset (more on all this later on)
* under "Name" is the term that stata uses to refer to that variable,
* and under "Label" is an addition for human ease of reading / understanding the variables.

* type: gex x = 1
gen x = 1

* so how a new variable popped up?
* under name we have "x", how stata calls this variable.
* under label we have nothing, because we didn't document, as of yet, "x"'s label.

*** 4. properties

* looks like a window with the title "Properties"

** 4.1. variable properties

* here one can view the properties of a specific variable.
* in the variables window, click on the variable "x".

* see how information popped up in the poperties, variables window?
* specifically, we can see the name, label, type (float means it is a variable containing a number)
* the display format, and more.

** 4.2. variable properties

* here one can view the properties of the whole data set currently loaded.
* once we load some data set, the information will stay there until we clear that data from stata's memory.

* for example, note that stata tells us the number of variables currently in the data, the number of obersvations, and more.
* type: set obs 50
set obs 200

* see how the number of observations jumped to 200?

*** 5. Tabs

* we won't go over the different tabs here
* but go yourself into File, Edit and so on, and see all the options that
* stata has for it's users.

*** 6 Do-files

* a do-file is similar to a text-file,
* that saves a number of stata commands in one place.

* when working on coding projects, we will always work on a 
* script (a general name text file like a do-file, that runs programming commands)
* so that we can save and repeat previous sessions.

* you open a do file by clicking the "New Do-File Editor", which looks like 
* a text page and a pencil, below the "Graphics" tab in the top right corner.

* you execute (run a script) by selecting a block of commands and pressing "Ctrl + D" (on windows).
* or by clicking the icon of the page + play button in the top right corner.

* Tip: always work from a do-file.
* in the command line, write codes to experiment if things work,
* but your main coding needs to be done, and saved, in a do-file.

* Tip: leave comments.
* for your future self, and collaborators.

* you can leave a comment using "*" , 

*a block using 
/*
	this is a
	block of comments
 */
 
 * or using //
 // this is also a comment
 
 *Tip: comment code blocks shortcut - select block of code and press "Ctrl+/".


******************************************************
******* Lesson 2, basic coding, getting help   *******
******************************************************

clear all
set more off

global path_work "P:\personal\stata_lesson"
global path_home "C:\Users\DELL\Dropbox\stata_lesson"
cd "${path_work}"

capture mkdir inputs
capture mkdir ".\inputs\data"

capture mkdir outputs
capture mkdir ".\outputs\data"
capture mkdir ".\outputs\graphs"
capture mkdir ".\outputs\tables"

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

* in stata, the syntax usually allows "options", which allow a user
* to tell stata various non-default things that need to be done
* options are usually added by a comma "," after the main part of the command.

* examples:

tab x , nolabel
use data , clear
scatter y x , title("Example of an option")

**** 2. Getting Help

* help is the best helper, type
help help
chelp summarize 
help twoway
* and so on

* Tip: help usually has examples on how to use stata commands.
* look at examples, even copy them to your do-file, and alter the
* specifics of the command to what you want.

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

global path_work "P:\personal\stata_lesson"
global path_home "C:\Users\DELL\Dropbox\stata_lesson"
cd "${path_work}"

capture mkdir inputs
capture mkdir ".\inputs\data"

capture mkdir outputs
capture mkdir ".\outputs\data"
capture mkdir ".\outputs\graphs"
capture mkdir ".\outputs\tables"

set obs 100

***** 1 data types.

* variables are defined by a specific data type.
* variables with numbers, called numeric, can be
	* byte, int long ...
* type:
help data type
* variables with non-number / alphabetic characters are called strings.

** 1.1. data types: numeric

* can specify when generating, what type of data type that variable is

* example

gen byte x = 100
gen byte x1 = 101

* what happend to x1? type:
browse
* we defined x1 to be data type "byte" which is limited to a
* maximum of 100, so stata put missing values instead of 100.

* if were to tell stata
replace x1 = 1000

* then, x will now be something other then a byte
* for the properties window, we can tell that now x is an int data type.

* to change a format display of a variable we use command "format"
help format

* exercise: format x1 to format %2.0g .

format x1 %2.0g

* properties window to see this worked.
* type browse to see the change

* exercise: format x1 back to 8.0, but this time add a comma display.

format x1 %8.0fc
browse

* Tip: this way users can control the way stata outputs variables in the way they want.

** 1.2. String

* create a variable called "name" with my name in it
gen name = "Dor Leventer"
browse
describe
* change it to something longer
replace name = "This is a very long string to show a point"
* observe stata changed the data type so it can put all those characters
* into the variable "name"
describe

* exercise: format name to left-justified 5 character format.

format name %-5s
br

** 1.3. Dates:

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
use "P:\personal\stata_lesson\inputs\data\merge_data1.dta"

* Tip: a good practice is to use forward slash "\" and not
* backward slash "/", which is problematic with macros (more later on)

* note the error - stata won't let us upload data since we have data in 
* memory. to clean memory, type "clear"
clear
use "C:\Users\DELL\Downloads\merge_data1.dta" 

* to shorten this, we just type clear as an option for the use command:
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

clear all
set more off

global path_work "P:\personal\stata_lesson"
global path_home "C:\Users\DELL\Dropbox\stata_lesson"
cd "${path_work}"

capture mkdir inputs
capture mkdir ".\inputs\data"

capture mkdir outputs
capture mkdir ".\outputs\data"
capture mkdir ".\outputs\graphs"
capture mkdir ".\outputs\tables"

*** 1. generating variables and subsetting.

** 1.1. gen and replace

use "P:/personal/stata_lesson/inputs/data/merge_data1" , clear

* first: creating new variables.
* command in stata: generate, or the shorter gen, or the even shorter g
help generate

generate my_first_var = 1
gen second_var = my_first_var * 10
g third = second_var + x1 * 2 + x3 / 4

* for human ease of reading, we usually use "gen"
* gen syntax is made up of "name_of_new_var" then equality sign "=" then "some_expression"

* this could be a numeric expression

gen ones = 1
gen twos = 1*2

* use other variables

gen x1_plus_1 = x1 + 1
gen x2_times_2 = x2 * 2

* second: changing values of existing variables
* command in stata: replace
* same syntax as generate command
help replace

replace my_first_var = 2
replace second_var = my_first_var * 3 + 12

* Tip: note that you can replace value of specific observation
* using the "in" synatx

replace my_first_var = 3 in 1
* look at the first observation
br

** 1.2. drop.

* how do you delete variables?
* using the "drop" command
help drop

* syntax is typing the names of the variables you want stata to delete
drop second_var
drop x1 x2

** 1.3. keep.

* you can tell stata to delete all the variable except a few specific 
* variables you want to keep

* using the "keep" command
keep id x3
keep id
* note that the last command, in the case of two variables "id" and "x3",
* is equivalent to the command "drop x3"


* excersices:
/*
		load merge1 data, create a variable that is the squared value of x1.
		create a variable equal half of x1, quarter of x1 squared, five times x2 and 10 times x3
		replace x2 to be half its current value for each observation.
		delete the variable x4
		delete all variables expect id and x1
*/

*solutions

		use "P:/personal/stata_lesson/inputs/data/merge_data1" , clear
		gen x1_sq = x1^2 /* same as gen x1_sq = x1 * x1 */
		gen y = 0.5*x1 + 0.25*x1_sq + 5*x2 + 10*x3
		replace x2 = x2 / 2
		drop x4
		keep id x1

*** 2. sum and tab

use "P:/personal/stata_lesson/inputs/data/merge_data1" , clear

* summarize is a command that summarizes a data set / specific variables
help summarize
* short command for summarize is sum
summarize
summarize x1
sum x1 x2

* Tip: if you have some variables with some characters in the start 
* of their name, write "same_start*"
sum x* 
* note that x1, x2, x3 and x4 were all sum'ed over, since they all begin with "x"

* tabulate is another command that summarizes a dataset and variables
* specifically, tabulate shows frequencies and number of observations
* by each distinct value of a variable.
help tabulate oneway
* short command for tabulate is tab
tabulate x3
tab x4

* tabulate can summarize a variable over categories of other variables.
* example:

tab x3 x4
* note that the total column and row are equivalent to tabulate for each
* variable separately.

* Tip: since tabulate shows frequencies for each distinct value,
* then it is less recommended to use for continuous variables.
* for example look at output from:
tab x1

* Tip: what if there are missing values, i.e. observations without a value in some variable?
* (note dot "." is how we represent a missing value in stata)
* change x4 to have some missing values
replace x4 = . if _n > 80

* run tab on x4
tab x4
* if you don't specify the option "missing" , stata will NOT display missing observations.
tab x3 x4, missing

*** 3. ifs and looping

** 3.1. conditioning a command with if

use "P:/personal/stata_lesson/inputs/data/merge_data1" , clear

** If
help if
* simple use of "ifs" - conditional variable making

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

* excersices:
/*
		load merge1 data, create a variable that is the squared value of x1,
			if x1 is greather then 50.
		create a variable equal half of x1, quarter of x1 squared, five times x2 and 10 times x3,
			if x1 greater or equal then 20, x2 greater then 2 in absolute value and x3 not equal 1.
		replace x2 to be half its current value for each observation,
			if x1 greater then 20 and x3 equal 1, or x1 less then 80 and x3 equal 3.
*/

*solutions

		use "P:/personal/stata_lesson/inputs/data/merge_data1" , clear
		gen x1_sq = x1^2 if x1 > 50
		gen y = 0.5*x1 + 0.25*x1_sq + 5*x2 + 10*x3 ///
			if x1 >= 20 & abs(x2) > 2 & x3 != 1
		replace x2 = x2 / 2 if (x1 > 20 & x3 == 1) | (x1 < 80 & x3 == 3)
* Tip: note triple backslash to make command go over multiple lines

* can use "ifs" in summary statistics

sum x1 if x3 == 1
sum x1 if x4 != 2 & x3 < 3

tab x3 if x1 > 50

* Tip: can be used in regressions, graphs, and more to condition inputs to commands
* (advanced if and else programming after introduction of globals and locals)



** 3.2. loop over values using forvalues

* stata incorporates three kinds of looping, forvalues, foreach and while

* forvalue goes over a range of numerical values.
help forvalues
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
* note above is same as
forval i= 5(5)100 {
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

* excerises
/*
	create a for value loop that goes from 1 to 3 by 1 and displays the value of each loop.
	a for value loop that goes from 3 to 1 by 1 and displays the value of each loop.
	a for value loop that goes from 1 to 15 by 10 and displays the value of each loop
		use di `name of running variable' in the loop to display the running variables
		value in each run of the loop
	
*/

*solutions
	forvalue i = 1/3 {
		di `i'
	}
	
	forvalue i = 3(-1)1 {
		di `i'
	}
	
	forvalue i = 1(10)15 {
		di `i'
	}
	
	
	
**  3.3. loop over varlist using foreach

*foreach goes over a list of objects, and runs code separately for each
help foreach
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

** 3.4. while loop stops when condition is fulfilled
help while

* example (don't mind the code very much, will go into locals later on)
local i = 1
while `i' < 10 {
	di `i'
	local i = `i' + 1
}

******************************************************
*********** Lesson 5, combining datasets *************
******************************************************

clear all
set more off

global path_work "P:\personal\stata_lesson"
global path_home "C:\Users\DELL\Dropbox\stata_lesson"
cd "${path_work}"

capture mkdir inputs
capture mkdir ".\inputs\data"

capture mkdir outputs
capture mkdir ".\outputs\data"
capture mkdir ".\outputs\graphs"
capture mkdir ".\outputs\tables"

* two main ways to combine datasets, append and merge.

*** append

* append pushes a dataset below another one.
help append

* download all the data files from: https://github.com/dorlev3/stata_basic_programming/tree/main/data
* put it in some folder and upload append_data1
use "P:/personal/stata_lesson/inputs/data/append_data1" , clear
br

* now consider append_data2
use "P:/personal/stata_lesson/inputs/data/append_data2" , clear
br

* if we want to combine data one below the other, i.e. append them, we use

append using "P:/personal/stata_lesson/inputs/data/append_data1"
br

* see how the number of observations jumped to 200?
* lets sort the new dataset by id:
sort id
br
* we can generate a file number to know which data set an observation
* originally belonged to

use "P:/personal/stata_lesson/inputs/data/append_data1" , clear
append using "P:/personal/stata_lesson/inputs/data/append_data2" , gen(filenum)
br

* Tip: can label variable to remember
help label
label variable filenum "0 from append_data1, 1 from append_data2"
* Tip can also label values to remember
label define files 0 "append_data1" 1 "append_data2"
label values filenum files
br

* now consider the case we want to append multiple files.
* can use append directly with all the data sets
use "P:/personal/stata_lesson/inputs/data/append_data1" , clear
append using "P:/personal/stata_lesson/inputs/data/append_data2" "P:/personal/stata_lesson/inputs/data/append_data3"
br

* Tip: another way is to loop over files we want to append
* first upload a data set
use "P:/personal/stata_lesson/inputs/data/append_data1" , clear
cd "P:/personal/stata_lesson/inputs/data"
foreach data_file in "append_data2"  "append_data3" {
	append using "`data_file'"
	
* what about the case where different datasets have different variables?
* consider append_data1
use "P:/personal/stata_lesson/inputs/data/append_data1" , clear
describe
* here we have id, x1, x2 and x3.

* now consider append_data3
use "P:/personal/stata_lesson/inputs/data/append_data3" , clear
desc
* this data doesn't have a varible x2.

*what happens when we append data3 to data1?
use "P:/personal/stata_lesson/inputs/data/append_data1" , clear
append using "P:/personal/stata_lesson/inputs/data/append_data3" , gen(filenum)
* we can see stata added the variable x2 to data3, but set all the values to 
* observations appended from data3 to missing
br

*** 2. merge

* merge combines data for the same "type" of obersvations.
help merge

*upload merge_data1
use "P:/personal/stata_lesson/inputs/data/merge_data1" , clear
br
* see the variable id? imagine this is individual or firm id, and we have in this data
* four variables for each id, x1-x4.

* upload merge_data2
use "P:/personal/stata_lesson/inputs/data/merge_data2" , clear
br
* see the same id variable? here we have two new variables, x5-x6.

* merge allows us to combine these two data sets so each id will
* have all the variables x1-x6.

* syntax:
* master data - the data currently loaded
* using data - the data you want to combine with
* 1:1 - match each observation from master data to one observation in using data
* id - the identifier variable
* using "using_data"
merge 1:1 id using "P:/personal/stata_lesson/inputs/data/merge_data1"

* the output tells us how much were not matched, specifically how many not matched
* from master and not matched from using, and how many were matched.
* in our case, all the values in variable "id" in master data - "merge_data2" - 
* are also all the values in the variable "id" in the using data - "merge_data1".

* lets create a case where this isn't how it is:
use "P:/personal/stata_lesson/inputs/data/merge_data2" , clear
drop if id <= 20
merge 1:1 id using "P:/personal/stata_lesson/inputs/data/merge_data1"
* see that in the output we see that the using data has 20 distinct values
* of id that the master data doesn't have (specifaclly id <= 20)?
br
* we can see that:
	* 1. stata still merged these id's, but put missing values in the variables
	* that were in the using data and didn't have matching id's in the master data
	
	* 2. stata generated a variable called "_merge", which documents which variables
	* were matched and which were not. 
	

* another case is if we have the same id values, but one
* data set has multiple values for the same id (e.g., multiple years / months / firms).

* we specify this by m:1 (many to one), 1:m (1 to many) or m:m (many to many)
* where the right value is the master data id values, and the right is the using id values.

* upload merge_data3
use "P:/personal/stata_lesson/inputs/data/merge_data3" , clear
br
* see we have 200 obs, but only 100 values for id?
* note the variable t, represents two time periods for each individual

* to combine with merge_data1, if merge_data3 is the master data,
* then we are using many to one merge, that is:
merge m:1 id using "P:/personal/stata_lesson/inputs/data/merge_data1"

* note that the variables for x5-x6 are distinct per id and t, but x1-x4 are distinct only per id

******************************************************
*********** Lesson 6, locals and globals *************
******************************************************

clear all
set more off

global path_work "P:\personal\stata_lesson"
global path_home "C:\Users\DELL\Dropbox\stata_lesson"
cd "${path_work}"

capture mkdir inputs
capture mkdir ".\inputs\data"

capture mkdir outputs
capture mkdir ".\outputs\data"
capture mkdir ".\outputs\graphs"
capture mkdir ".\outputs\tables"

*** 1. Globals

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
global InDat "${Path}/inputs/data"

use "${InDat}/merge_data1" , clear

* another use is to set a string of variables, e.g. for use in similar models
* for example
global base_model = "x1 x2"

reg y ${base_model}
reg y ${base_model} x3
reg y ${base_model} x4


*** 2. Locals

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

* excerise: 
/*
	create a loop that goes over the variables x1 x2 and x3
	and store the maximum of each, and display the minimum of all the maximums
*/

* solution
	global needed_maximum = "x1 x2 x3"
	foreach var in ${needed_maximum} {
		sum `var'
		local max_`var' = `r(max)'
	}
	di min(`max_x1',`max_x2',`max_x3') /* note min() function outputs minimum value over list */

* this excerise shows how use of locals can create simiple and elegant coding solutions.

* Tip: combine locals with forvalues ranges
* for dynamic programming, less errors
local min_year = 2000
local max_year = 2010
forvalues year = `min_year' / `max_year' {
	di `year'
}

*** 3. A bit more advanced: if and else

help [M-2] if
* Tip: _N is the number of observations in the dataset

global n = _N
* one way to code ifs: if (exp) condition_code
if ($n == 100) di "Hello"
* or
if ($n == 50) di "Hello"
else di "Bye"
* Tip: can nest if in the else statment
if ($n == 50) di "Hello"
else if ($n == 70) di "Bye"
else di "Okay"

* a way intuitive way (for me) is with coding blocks
if `n' == 100 {
	di "Dor created this data"
}
else { 
	di "Dor did not create this data"
}

* in general:
/* 
if (exp1 cond exp2) {
	code run if condition true
}
else {
	code run if condition false
}
*/

* Note on the difference between locals and globals.
* globals are set for a coding session, locals are set for a single run.
* that is, if you define a local, if you run that local, and then run another block of code
* then that local is not stored anymore.
* if you run a global, then it is stored even if you run another block of code.

* this is very important for temporary files / variables / programming programs in stata (more advanced).

******************************************************
*********** Lesson 7, generating fake data ***********
******************************************************

clear all
set more off

global path_work "P:\personal\stata_lesson"
global path_home "C:\Users\DELL\Dropbox\stata_lesson"
cd "${path_work}"

capture mkdir inputs
capture mkdir ".\inputs\data"

capture mkdir outputs
capture mkdir ".\outputs\data"
capture mkdir ".\outputs\graphs"
capture mkdir ".\outputs\tables"

* creating data table with 100 empty observations
help set obs
set obs 100

* generating a variable called x
gen x = 1
replace x = 2 if _n > 33
replace x = 3 if _n > 66

* set seed determines that the generation of random variables will always be the same
help set seed
set seed 1
* generating a variable called epsilon with uniform distribution, mean 0 and sd 0.2
help random
gen epsilon = rnormal(0,0.2)

* creating a local called beta
local beta = 5

* generating a variable called y constructed from other variables
gen y = `beta' * x + epsilon

* excersice:
/*
	set seed 1
	generate a variable named social economic score,
	as a string,
	based with probability on a random uniform variable
	conditioned on the variable x as follows:
	
	if x equals i, then social economic score is low if the uniform value is lower then 0.4 / i
	if x equals i, then social economic score is medium if the uniform value is between 0.4 / i and 0.8 / i
	if x equals i, then social economic score is high if the uniform value is higher then 0.8 / i
*/

* solution
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
* a very powerful command to generate complicated variables is egen
help egen
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

tab SES_num x
* to view without labels, add nolabel option
tab SES_num x , nolabel

******************************************************
************* Lesson 8, graphing data  ***************
******************************************************

clear all
set more off

global path_work "P:\personal\stata_lesson"
global path_home "C:\Users\DELL\Dropbox\stata_lesson"
cd "${path_work}"

capture mkdir inputs
capture mkdir ".\inputs\data"

capture mkdir outputs
capture mkdir ".\outputs\data"
capture mkdir ".\outputs\graphs"
capture mkdir ".\outputs\tables"
global OutGraph ".\outputs\graphs"

* lets begin by generating some variables to graph
set obs 100
gen x = runiform(0,100)
gen e = rnormal(0,10)
gen y = 2 * x + e

*** 1. twoway, scatter plot and lfit plot

* usually we graph using "twoway"
help twoway
* a first simple plot is the scatter plot
help scatter
* this is the known y-x two dimension graphs. the syntax:
twoway (scatter y x) 

* two way allows us to plot multiple graphs together
* consider a graph that fits a line to the data
help twoway lfit
twoway (lfit y x)
* now: two graphs together, a scatter plot and a fitted line
twoway (scatter y x) (lfit y x)
* note that we can change the syntax from parentheses to ||
twoway scatter y x || lfit y x
* and even drop the twoway
scatter y x || lfit y x
* depends on what you find is easier for you.

* Tip: you can use conditional ifs in twoway graphs.
* example:
twoway (scatter y x if x < 80) (lfit y x if x > 20)

*** 2. Histograms and bar plots.

* lets generate a categorical data
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

* a histogram graph is a simple way to view the distribution variables.
* default is density:
help histogram
histogram y
* can use to show frequences
histogram y , frequency

* a bar graph is a simple way to understand distribution of variables, conditioned one some other variables.
help graph bar
* a bar graph show a statistic, e.g. the mean, of a variable 
graph bar (mean) y
* the default statistic is the mean.

* usually used when grouping over othe variables
graph bar y, over(SES)
* we can also compare between diferrent variables at the same time
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
* add some title and some note
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
*************   	    Add   	       ***************
******************************************************

choose variables names you understand, if have time then label variables and labels,
document - coming back after half year / year you won't remember anything, 
putexcel, outreg, saving tables from stata output directly, logging
use of _n, _N, replace in, set obs, 
indention in looping, dynamic programming (e.g. in looping ranges), 
globals as paths,
use tempfiles to save temporary playing with datasets 