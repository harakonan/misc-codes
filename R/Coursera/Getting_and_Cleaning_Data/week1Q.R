# TODO: Add comment
# 
# Author: harakonan
###############################################################################

##Q1
setwd("/Users/harakonan/Documents/workspace/Getting_and_Cleaning_Data")
dir.create("data")
##create new directory
getwd()
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
download.file(fileUrl, destfile = "./data/Idaho.csv", method = "curl")
##download file
list.files("./data")
IdahoData <- read.csv("./data/Idaho.csv")
head(IdahoData)
a <- IdahoData$VAL==24
head(a)
sum(a, na.rm=T)
##answer is 53

##Q3
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FDATA.gov_NGAP.xlsx"
download.file(fileUrl, destfile = "./data/Natural_Gas.xlsx", method = "curl")
dataDownloaded <- data()
library(xlsx)
dat <- read.xlsx("./data/Natural_Gas.xlsx", sheetIndex=1
, colIndex=7:15, rowIndex=18:23)
head(dat)
sum(dat$Zip*dat$Ext, na.rm=T)
##answer is 36534720

##Q4
library(XML)
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml"
download.file(fileUrl, destfile = "./data/restaurants.xml", method = "curl")
doc <- xmlInternalTreeParse("./data/restaurants.xml")
rootNode <- xmlRoot(doc)
xmlName(rootNode)
names(rootNode)
rootNode[[1]][[1]]
zipcode <- xpathSApply(rootNode, "//zipcode", xmlValue)
head(zipcode)
sum(zipcode=="21231")
##handle as character
class(zipcode)##character
zipcode.num <- as.numeric(zipcode)
sum(zipcode.num==21231)
##handle as numeric
##answer is 127

##Q5
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv"
download.file(fileUrl, destfile = "./data/Idaho2.csv", method = "curl")
library(data.table)
DT <- fread("./data/Idaho2.csv")
head(DT)
head(DT$SEX)
head(DT$pwgtp15)
system.time(DT[, mean(pwgtp15), by=SEX])
system.time(sapply(split(DT$pwgtp15,DT$SEX),mean))