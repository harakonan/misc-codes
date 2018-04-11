# TODO: Add comment
# 
# Author: harakonan
###############################################################################

##Q1
##tutorial https://github.com/hadley/httr/blob/master/demo/oauth2-github.r
library(httr)
oauth_endpoints("github")
myapp <- oauth_app("github", "6a514a067869edc50460", "6abe3e5cc546bb35f16935019471e48f01a91490")
library(httpuv)
github_token <- oauth2.0_token(oauth_endpoints("github"), myapp)
##you need to select use local file or not
gtoken <- config(token = github_token)
req <- GET("https://api.github.com/users/jtleek/repos", gtoken)
stop_for_status(req)
library(jsonlite)
repo <- content(req)
head(repo)
names(repo[[1]])
##we want names which is the second element
reponame <- sapply(repo,"[[", 2)
##extract names from the data
repo[[which(reponame == "datasharing")]]$created_at
##complete!!"2013-11-07T13:25:07Z"

##Q2
library(sqldf)
setwd("/Users/harakonan/Documents/workspace/Getting_and_Cleaning_Data")
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv"
download.file(fileUrl, destfile = "./data/week2Q2.csv", method = "curl")
acs <- read.csv("./data/week2Q2.csv")
head(acs)
head(acs$pwgtp1)
head(sqldf("select pwgtp1 from acs where AGEP < 50"))
##shows the value of pwgtp1 when AGEP<50
##this is the answer
head(sqldf("select * from acs where AGEP < 50"))
##shows the value for all value when AGEP<50
a <- sqldf("select * from acs where AGEP < 50")
head(a$pwgtp1)
##this can do same as "select pwgtp1 from acs where AGEP < 50"

##Q3
library(sqldf)
setwd("/Users/harakonan/Documents/workspace/Getting_and_Cleaning_Data")
acs <- read.csv("./data/week2Q2.csv")
head(unique(acs$AGEP))
length(acs$AGEP)
length(unique(acs$AGEP))
##unique removes duplicate values
sqldf("select unique AGEP from acs")
##error
sqldf("select distinct AGEP from acs")
##ok

##Q4
setwd("/Users/harakonan/Documents/workspace/Getting_and_Cleaning_Data")
fileUrl <- "http://biostat.jhsph.edu/~jleek/contact.html"
library(XML)
html <- htmlTreeParse(fileUrl, ignoreBlanks=F, useInternalNodes=T)
html
##can't deal with htmlTreeParse
con = url(fileUrl)
htmlcode = readLines(con)
close(con)
htmlcode
htmlcode[10]
nchar(htmlcode[c(10,20,30,100)])
##45 31 7 25

##Q5
setwd("/Users/harakonan/Documents/workspace/Getting_and_Cleaning_Data")
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fwksst8110.for"
download.file(fileUrl, destfile = "./data/week2Q5.for", method = "curl")
raw.fwf <- read.fwf("./data/week2Q5.for", widths=c(1,9,rep(c(5,4,4),4))
, header=F, skip=4)
head(raw.fwf)
sum(raw.fwf$V7)
##32426.7