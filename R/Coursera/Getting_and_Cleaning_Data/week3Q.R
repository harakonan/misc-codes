# TODO: Add comment
# 
# Author: harakonan
###############################################################################

##Q1
setwd("/Users/harakonan/Documents/workspace/Getting_and_Cleaning_Data")
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
download.file(fileUrl, destfile = "./data/week3Q1.csv", method = "curl")
week3Q1 <- read.csv("./data/week3Q1.csv")
agricultureLogical <- week3Q1$ACR == 3 & week3Q1$AGS == 6
head(which(agricultureLogical), n=3)
##the answer is 125 238 262

##Q2
setwd("/Users/harakonan/Documents/workspace/Getting_and_Cleaning_Data")
library(jpeg)
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fjeff.jpg"
download.file(fileUrl, destfile = "./data/week3Q2.jpg", method = "curl")
jpeg <- readJPEG("./data/week3Q2.jpg", native=T)
head(jpeg)
quantile(jpeg, probs = c(0.3, 0.8))
##-15259150 -10575416 

##Q3
setwd("/Users/harakonan/Documents/workspace/Getting_and_Cleaning_Data")
fileUrl1 <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"
fileUrl2 <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv"
download.file(fileUrl1, destfile = "./data/week3Q3_1.csv", method = "curl")
download.file(fileUrl2, destfile = "./data/week3Q3_2.csv", method = "curl")
week3Q3_1 <- read.csv("./data/week3Q3_1.csv")
##this includes data which has no rank for GDP
week3Q3_1 <- read.csv("./data/week3Q3_1.csv", nrows=190, skip=4)
week3Q3_2 <- read.csv("./data/week3Q3_2.csv")
head(week3Q3_1)
head(week3Q3_2)
mergeddata <- merge(week3Q3_1, week3Q3_2, by.x="X", by.y="CountryCode")
head(mergeddata)
nrow(mergeddata)
##189 countrys matches
class(mergeddata$X.1)
##X.1 is the rank of GDP
##check the rank is coerced as integer
orderrank <- mergeddata[order(mergeddata$X.1, decreasing=T), ]
tail(orderrank)
##the last is USA
orderrank[13,c(1,4)]
##column1 is short name code, 4 is the country name
##KNA:St. Kitts and Nevis

##Q4
##this continues from Q3
c(mean(mergeddata[mergeddata$Income.Group == "High income: OECD", ]$X.1), 
mean(mergeddata[mergeddata$Income.Group == "High income: nonOECD", ]$X.1))
##32.96667 91.91304

##Q5
##this continues from Q3,Q4
mergeddata$cut <- cut(mergeddata$X.1, breaks=seq(0, 190, 38))
table(mergeddata$cut)
table(mergeddata$cut, mergeddata$Income.Group)
##5