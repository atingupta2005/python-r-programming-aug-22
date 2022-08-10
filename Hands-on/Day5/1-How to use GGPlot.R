setwd("D:/22-Trngs/2-Confirmed/1-Python-R-Programming/GH/Hands-on/WorkingD")

#
# Setup
options(scipen=999)  # turn off scientific notation like 1e+06

library(ggplot2)

data("midwest", package = "ggplot2")  # load the data

# midwest <- read.csv("http://goo.gl/G1K41K") # alt source

View(midwest)

# Init Ggplot
# area and poptotal are columns in 'midwest?
# aes() function is used to specify the X and Y axes.
ggplot(midwest, aes(x=area, y=poptotal))


#
ggplot(midwest, aes(x=area, y=poptotal)) + geom_point()


#
g <- ggplot(midwest, aes(x=area, y=poptotal)) + geom_point() + geom_smooth(method="lm")  # set se=FALSE to turnoff confidence bands
plot(g)


#
g <- ggplot(midwest, aes(x=area, y=poptotal)) + geom_point() + geom_smooth(method="lm")
g1 <- g + coord_cartesian(xlim=c(0,0.1), ylim=c(0, 500000))  # zooms in
plot(g1)


#
g1 + labs(title="Area Vs Population", subtitle="From midwest dataset", y="Population", x="Area", caption="Midwest Demographics")



#
# Full Plot call
library(ggplot2)
ggplot(midwest, aes(x=area, y=poptotal)) +
  geom_point() +
  geom_smooth(method="lm") +
  coord_cartesian(xlim=c(0,0.1), ylim=c(0, 1000000)) +
  labs(title="Area Vs Population", subtitle="From midwest dataset", y="Population", x="Area", caption="Midwest Demographics")





#
gg <- ggplot(midwest, aes(x=area, y=poptotal)) +
  geom_point(aes(col=state), size=3) +  # Set color to vary based on state categories.
  geom_smooth(method="lm", col="firebrick", size=2) +
  coord_cartesian(xlim=c(0, 0.1), ylim=c(0, 1000000)) +
  labs(title="Area Vs Population", subtitle="From midwest dataset", y="Population", x="Area", caption="Midwest Demographics")
plot(gg)
