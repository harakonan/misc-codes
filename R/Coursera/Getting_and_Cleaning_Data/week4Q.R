# TODO: Add comment
# 
# Author: harakonan
###############################################################################

##Q1
setwd("/Users/harakonan/Documents/workspace/Getting_and_Cleaning_Data")
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
download.file(fileUrl, destfile = "./data/week4Q1.csv", method = "curl")
week4Q1 <- read.csv("./data/week4Q1.csv")
names(week4Q1)[123]
strsplit(names(week4Q1), "wgtp")[[123]]
##""   "15"

##Q2
setwd("/Users/harakonan/Documents/workspace/Getting_and_Cleaning_Data")
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"
download.file(fileUrl, destfile = "./data/week4Q2.csv", method = "curl")
week4Q2 <- read.csv("./data/week4Q2.csv", nrows=190, skip=4)
head(week4Q2)
class(week4Q2$X.4)
##factor
week4Q2$X.4 <- gsub(",", "", week4Q2$X.4)
class(week4Q2$X.4)
##character
mean(as.numeric(week4Q2$X.4))
##377652.4

##Q3
##continue from Q2
countryNames <- week4Q2$X.3
length(grep("^United", countryNames))
##3

##Q4
setwd("/Users/harakonan/Documents/workspace/Getting_and_Cleaning_Data")
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv"
download.file(fileUrl, destfile = "./data/week4Q4.csv", method = "curl")
week4Q4 <- read.csv("./data/week4Q4.csv")
head(week4Q4)
grep("Fiscal year end: June", week4Q4$Special.Notes, value=T)
length(grep("Fiscal year end: June", week4Q4$Special.Notes))
##13

##Q5
library(quantmod)
amzn = getSymbols("AMZN", auto.assign=F)
sampleTimes = index(amzn)
head(sampleTimes)
class(sampleTimes)
##Date
sT2012 <- grep("^2012", sampleTimes, value=T)
length(sT2012)
##250
class(sT2012)
##coerced to character
sT2012w <- weekdays(as.Date(sT2012))
sum(sT2012w == "Monday")
##47
