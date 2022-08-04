#Slide # 3
# Assignment using equal operator.
var.1 = c(0,1,2,3)
# Assignment using leftward operator.
var.2 <- c("learn","R")   
# Assignment using rightward operator.   
c(TRUE,1) -> var.3           
print(var.1)
cat ("var.1 is ", var.1 ,"\n")
cat ("var.2 is ", var.2 ,"\n")
cat ("var.3 is ", var.3 ,"\n")


#Slide # 6
o <- c(1,2,5.3,6,-2,4)       # Numeric vector
p <- c("one","two","three","four","five","six")   # Character vector
q <- c(TRUE,TRUE,FALSE,TRUE,FALSE,TRUE)   #Logical vector
o;p;q

#Slide # 7
o[q]   # Logical vector can be used to extract vector components 
names(o) <- p   # Give each component a name
o
o["three"]      # Extract your components by "calling" their names

#Slide # 8
t <- matrix(1:12,nrow=4,ncol=3,byrow = FALSE)
t


#Slide # 9
t[2,3]                    # component at 2nd row and 3rd column
t[,3]                     # 3rd column of matrix
t[4,]                     # 4th row of matrix
t[2:4,1:3]                # rows 2,3,4 of columns 


#Slide # 10
d <- c(1,2,3,4)
e <- c("red", "white", "red", NA)
f <- c(TRUE,TRUE,TRUE,FALSE)
mydata <- data.frame(d,e,f)
names(mydata) <- c("ID","Color","Passed")      # variable names
mydata

#Slide # 11
mydata$ID                       # try mydata["ID"] or mydata[1]
mydata$ID[3]                    # try mydata[3,"ID"] or mydata[3,1]
mydata[1:2,]                    # first two records



#Slide # 12 
# a list with a vector, a matrix, a data frame defined earlier and a scalar
p=c("one", "two", "three", "four", "five", "six")
l <-list(vec=p, mat=t, fra=mydata, count=3)
l$vec
l$mat



#Slide # 13
l$fra
l$count
l$mat[2,3]
l$fra$Color


#Slide # 14
setwd("~/WorkingD")
mydata <- read.csv("empdata.csv", header=TRUE, row.names="Employee_ID")
mydata



#Slide # 15
# Steps to install Java if needed
#https://askubuntu.com/questions/335457/how-to-uninstall-openjdk
#https://www.digitalocean.com/community/tutorials/how-to-install-java-with-apt-get-on-ubuntu-16-04
#install.packages('rJava')
#install.packages("xlsx")
library(xlsx)
write.xlsx(mydata, "EmployeeSales.xlsx", row.names= F)
mydata <- read.xlsx("EmployeeSales.xlsx", 1)
mydata
# read in the worksheet named mysheet
mydata <- read.xlsx("EmployeeSales.xlsx", sheetName = "Sheet1")
mydata




#Slide # 16
df <- data.frame( c( 183, 85, 40), c( 175, 76, 35), c( 178, 79, 38 ))
names(df) <- c("Height", "Weight", "Age")

# All Rows and All Columns
df[,]
# First row and all columns
df[1,]
# First two rows and all columns
df[1:2,]




#Slide # 17
# First and third row and all columns
df[ c(1,3), ]
# First Row and 2nd and third column
df[1, 2:3]
# First, Second Row and Second and Third Column
df[1:2, 2:3]



#Slide # 18

students <- c("John", "Alice", "Zeus", "Tim")
students
order(students)
students[order(students)]


