#setwd("~/WorkingD")

#
#install.packages("tidyverse")

library(haven)	

# Prepare data
df <- data.frame( c( 183, 85, 40), c( 175, 76, 35), c( 178, 79, 38 ))
names(df) <- c("Height", "Weight", "Age")


#
#Export SPSS file
write_sav(df, "df_spss.sav")

#Export SAS file
write_sas(df, "df_sas.sas7bdat")

#Export STATA file
write_dta(df, "df_stata.dta")

#
#Read SPSS file
read_sav("df_spss.sav")

#Read SAS file
read_sas( "df_sas.sas7bdat")

#Read STATA file
read_dta( "df_stata.dta")
