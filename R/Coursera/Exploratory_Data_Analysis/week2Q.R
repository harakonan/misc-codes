# TODO: Add comment
# 
# Author: harakonan
###############################################################################

library(lattice)

#Q1
library(datasets)
p <- xyplot(Ozone ~ Wind, data=airquality)
class(p)
#class trellis
print(p)
#auto printing as usual

#Q2
library(nlme)
xyplot(weight ~ Time | Diet, BodyWeight)

#Q4
data(airquality)
p <- xyplot(Ozone ~ Wind | factor(Month), data = airquality)
print(p)

#Q5
names(trellis.par.get())
#you can see the defalt settings
show.settings()
#you can set it by this function
trellis.par.set()

#Q7
library(ggplot2)
data(airquality)
airquality <- transform(airquality, Month = factor(Month))
#need to transform to class "factor" 
qplot(Wind, Ozone, data = airquality, facets = .~Month)

#Q8
#continue from Q7
qplot(Wind, Ozone, data = airquality, geom = c("smooth"))
#only smoothed line
qplot(Wind, Ozone, data = airquality, geom = c("point","smooth"))

#Q9
#continue from Q7
#use data movies
names(movies)
head(movies)
g <- ggplot(movies, aes(votes, rating))
print(g)
#Error: No layers in plot
p <- g + geom_point()
#need the things to plot
print(p)

#Q10
#continue from Q9
qplot(votes, rating, data=movies) + geom_smooth()
#can add a smoother!!