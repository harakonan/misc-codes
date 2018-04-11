# TODO: Add comment
# 
# Author: harakonan
###############################################################################

library(datasets)
data(iris)
?iris
iris["Sepal.Length"]
irissp <- split(iris, iris$Species)
irissp$virginica#irisのうちvirginicaのデータ
colMeans(irissp$virginica["Sepal.Length"])#1
sapply(split(iris$Sepal.Length, iris$Species), mean)#これでも出来た

apply(iris[ , 1:4], 2, mean)#2

library(datasets)
data(mtcars)
?mtcars
mtcars
sapply(split(mtcars$mpg, mtcars$cyl), mean)#3
with(mtcars, tapply(mpg, cyl, mean))#これでも出来る

mtcarshpsp <- lapply(split(mtcars$hp, mtcars$cyl), mean)
abs(mtcarshpsp$`4` - mtcarshpsp$`8`)#4

?ls
debug(ls)
ls()
undebug(ls)#5結果が出ずBrowseに飛ぶ