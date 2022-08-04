
dim(iris)
names(iris)
str(iris)



attributes(iris)



iris[1:3, ]
head(iris, 3)
tail(iris, 3)



#The first 10 values of Sepal.Length
iris[1:10, "Sepal.Length"]
iris$Sepal.Length[1:10]




summary(iris)



range(iris$Sepal.Length)
quantile(iris$Sepal.Length)
quantile(iris$Sepal.Length, c(0.1, 0.3, 0.65))




var(iris$Sepal.Length)
hist(iris$Sepal.Length)


plot(density(iris$Sepal.Length))





table(iris$Species)
pie(table(iris$Species))




barplot(table(iris$Species))

