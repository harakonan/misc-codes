# TODO: Add comment
# 
# Author: harakonan
###############################################################################
x<-c(4,"a",TRUE)
x
class(x) #5

x <- list(2, "a", "b", TRUE)
x[[1]] #8

x<-1:4
y<-2
x+y #9

x <- c(17, 14, 4, 5, 13, 12, 10)
x[x >= 11] <- 4
x #10

getwd()
R.home()
setwd("/Users/harakonan/Documents/workspace") #作業ディレクトリの変更
data<-read.csv("/Users/harakonan/Documents/workspace/hw1_data.csv")
data<-read.csv("hw1_data.csv") #11
data[1:2,] #12
head(data) #おまけ
nrow(data) #13
data[152:153,] #14
data[47,] #15
sum(is.na(data$Ozone)) #16

good<-complete.cases(data$Ozone)
mean(data[good,]$Ozone) #17
mean(data[good, "Ozone"]) #これでもオッケー

ex<-data$Ozone>31 & data$Temp>90
data18<-data[ex,]
data18[1:10,]
bad18<-is.na(data18$Solar.R)
data18good<-data18[!bad18,]
data18good
mean(data18good$Solar.R) #18

eqm6<-data$Month==6
data19<-data[eqm6,]
bad19<-is.na(data19$Temp)
data19good<-data19[!bad19,]
data19good
mean(data19good$Temp) #19

eqm5<-data$Month==5
data20<-data[eqm5,]
bad20<-is.na(data20$Ozone)
data20good<-data20[!bad20,]
data20good
max(data20good$Ozone) #20