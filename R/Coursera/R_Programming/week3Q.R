# TODO: Add comment
# 
# Author: harakonan
###############################################################################

library(datasets)
data(iris)
?iris
iris["Sepal.Length"]
irissp <- split(iris, iris$Species)
irissp$virginica#iris�̂���virginica�̃f�[�^
colMeans(irissp$virginica["Sepal.Length"])#1
sapply(split(iris$Sepal.Length, iris$Species), mean)#����ł��o����

apply(iris[ , 1:4], 2, mean)#2

library(datasets)
data(mtcars)
?mtcars
mtcars
sapply(split(mtcars$mpg, mtcars$cyl), mean)#3
with(mtcars, tapply(mpg, cyl, mean))#����ł��o����

mtcarshpsp <- lapply(split(mtcars$hp, mtcars$cyl), mean)
abs(mtcarshpsp$`4` - mtcarshpsp$`8`)#4

?ls
debug(ls)
ls()
undebug(ls)#5���ʂ��o��Browse�ɔ��