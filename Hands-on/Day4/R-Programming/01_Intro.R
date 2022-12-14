#How to Get Help in R
#~~~~~~~~~~~~~~~~~~~~


?mean                  #opens the help page for the mean function
?"+"                   #opens the help page for addition
?"if"                  #opens the help page for if, used for branching code
??plotting             #searches for help containing words like "plotting"
??"regression model"   #searches for the help containing phrases like this


help("mean")
help("+")
help("if")
help.search("plotting")
help.search("regression model")

a_vector <- c(1, 3, 6, 10)

?apropos
apropos("vector")


apropos("z$")
apropos("[4-9]")


example(plot)
demo()         #list all demonstrations
demo(smooth)

?browseVignettes
browseVignettes()


vignette("Sweave", package = "utils")


RSiteSearch("{Bayesian regression}")


#Installing Extra Related Software
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
install.packages("installr")   #download and install the package named installr
library(installr)              #load the installr package
install.RStudio()              #download and install the RStudio IDE
install.Rtools()               #Rtools is needed for building your own packages
install.git()                  #git provides version control for your code
