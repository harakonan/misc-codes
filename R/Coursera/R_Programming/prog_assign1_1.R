# TODO: Add comment
# 
# Author: harakonan
###############################################################################

setwd("/Users/harakonan/Documents/workspace")
data001 <- read.csv("specdata/001.csv")
mean(data001$sulfate, na.rm = TRUE) 
#001のsulfateの平均

setwd("/Users/harakonan/Documents/workspace")
assign("data001", read.csv("specdata/001.csv"))
mean(data001$sulfate, na.rm = TRUE) 
#assignを使っての方法

x="specdata"
class(x)
y="001.csv"
paste(x,y,sep="/")
#間を"/"で区切って文字の結合

setwd("/Users/harakonan/Documents/workspace")
temp = list.files("specdata")
temp[1]
tempdata1 <- paste("specdata", temp[1], sep = "/")
dataall1 <- read.csv(tempdata1)
mean(dataall1$sulfate, na.rm = TRUE) 
#list.filesを利用してファイルを読む

setwd("/Users/harakonan/Documents/workspace")
temp = list.files("specdata")
for(i in 1:10){
	temp[i] <- paste("specdata", temp[i], sep = "/")
	assign(paste("data", i, sep=""), read.csv(temp[i]))
}
mean(data1$sulfate, na.rm = TRUE) 
#ファイルをdataiに格納
#これだとこの課題は出来ない

setwd("/Users/harakonan/Documents/workspace")
temp = list.files("specdata")
datalist <- list()
for(i in 1:10){
	temp[i] <- paste("specdata", temp[i], sep = "/")
	datalist[i] <- list(read.csv(temp[i]))
}
mean(datalist[[2]]$sulfate, na.rm = TRUE) 
dataall <- do.call(rbind, datalist)
mean(dataall$sulfate, na.rm = TRUE) 
#1-10までのファイルのsulfateの平均

pollutantmean <- function(directory, pollutant, id = 1:332) {
	setwd("/Users/harakonan/Documents/workspace")
	temp = list.files(directory)
	datalist <- list()
	for(i in id){
		temp[i] <- paste(directory, temp[i], sep = "/")
		datalist[i] <- list(read.csv(temp[i]))
	}
	dataall <- do.call(rbind, datalist)
	mean(dataall[[pollutant]], na.rm = TRUE)
}
#完成
pollutantmean("specdata", "sulfate", 1:10)
pollutantmean("specdata", "nitrate", 70:72)
pollutantmean("specdata", "nitrate", 23)