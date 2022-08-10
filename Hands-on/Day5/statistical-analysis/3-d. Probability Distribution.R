#
pnorm(84, mean=72, sd=15.2, lower.tail=FALSE) 

# T Test
set.seed(123)
sugar_cookie <- rnorm(30, mean = 9.99, sd = 0.04)
head(sugar_cookie)
t.test(sugar_cookie, mu = 10)

# Paired T Test
set.seed(123)
# sales before the program
sales_before <- rnorm(7, mean = 50000, sd = 50)
# sales after the program.This has higher mean
sales_after <- rnorm(7, mean = 50075, sd = 50)
# draw the distribution
t.test(sales_before, sales_after,var.equal = TRUE)





#
dbinom(4, size=12, prob=0.2) 

dbinom(0, size=12, prob=0.2) + 
  + dbinom(1, size=12, prob=0.2) + 
  + dbinom(2, size=12, prob=0.2) + 
  + dbinom(3, size=12, prob=0.2) + 
  + dbinom(4, size=12, prob=0.2) 


