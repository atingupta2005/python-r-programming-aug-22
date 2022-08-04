#Slide # 3
dim(iris)
names(iris)
str(iris)


#Slide # 4
attributes(iris)


#Slide # 5
iris[1:3, ]
head(iris, 3)
tail(iris, 3)


#Slide # 6
#The first 10 values of Sepal.Length
iris[1:10, "Sepal.Length"]
iris$Sepal.Length[1:10]



#Slide # 7
summary(iris)


#Slide # 8
range(iris$Sepal.Length)
quantile(iris$Sepal.Length)
quantile(iris$Sepal.Length, c(0.1, 0.3, 0.65))



#Slide # 9
var(iris$Sepal.Length)
hist(iris$Sepal.Length)

#Slide # 10
plot(density(iris$Sepal.Length))




#Slide # 11
table(iris$Species)
pie(table(iris$Species))



#Slide # 12
barplot(table(iris$Species))

