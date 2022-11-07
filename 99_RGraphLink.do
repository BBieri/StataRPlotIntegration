// this bit grabs Stata's working directory and cleans it so we can 
// set it as the working directory in R
gen pwd = c(pwd) // pluck stata's working directory
replace pwd = subinstr(pwd, "\", "/",.) // slashes become r-friendly
local pwd=pwd[1]
drop pwd // get rid of variable. 
// start R, set the working directory, load packages
rcall clear // starts with a new instance of R
rcall: setwd("`pwd'") // make R working directory match stata's
rcall: library(ggstatsplot) // load the ggstatsplot library
rcall: library(ggplot2) // need ggplot2 to save the png
rcall: library(hrbrthemes) // Themes
// move Stata's dataset over to R:
rcall: data<- st.data() // move auto dataset to r
quietly {
noisily di " "
noisily di "ggplot2, ggstatsplot, hrbrthemes loaded in R."
noisily di "Stata's dataset in R, now called 'data'."
noisily di " "
noisily di "This is R's working directory. It should be the same as Stata's:"
noisily rcall: getwd()
}