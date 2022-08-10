setwd("~/WorkingD")

#
#install.packages("sqldf")

library(sqldf)

sqldf('SELECT age, circumference FROM Orange WHERE Tree = 1 ORDER BY circumference ASC')

help(sqldf)

#
sqldf("SELECT * FROM iris")

iris1 <- sqldf('SELECT "Petal.Width" FROM iris')

iris1

sqldf('SELECT * FROM iris')



#
sqldf('SELECT * FROM iris LIMIT 5')


#
sqldf("SELECT * FROM Orange ORDER BY age ASC, circumference DESC LIMIT 5")


#
sqldf('SELECT demand FROM BOD WHERE Time < 3')
sqldf('SELECT * FROM rock WHERE (peri > 5000 AND shape < .05) OR perm > 1000')

