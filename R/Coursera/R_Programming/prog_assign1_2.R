# TODO: Add comment
# 
# Author: harakonan
###############################################################################

setwd("/Users/harakonan/Documents/workspace")
temp = list.files("specdata")
for(i in 1:10){
	temp[i] <- paste("specdata", temp[i], sep = "/")
	assign(paste("data", i, sep=""), read.csv(temp[i]))
}
good1 <- na.omit(data1)#NAを除いたデータ作成
nrow(good1)#欠損値を除いた行数
sum(complete.cases(data1))#これでも同じ
datacomp0 <- data.frame(id = integer(0), nobs = integer(0))#empty data
datacomp1 <- data.frame(id = 1, nobs = sum(complete.cases(data1)))
rbind(datacomp0, datacomp1)#data1をidとnodsに

setwd("/Users/harakonan/Documents/workspace")
temp = list.files("specdata")
datacomp <- list()
for(i in 1:10){
	temp[i] <- paste("specdata", temp[i], sep = "/")
	datacomp[i] <- list(cbind(id = i, nods = sum(complete.cases(read.csv(temp[i])))))
}
datacomp#ファイル1-10のlistでのidとnodsのまとめ
datacomp[1:10]#ファイル1-10だけ抽出出来る
datacompall <- do.call(rbind, datacomp[1:10])
datacompall#datacompを一つのlistにまとめ
as.data.frame(datacompall)#さらにdata.frameに変換

complete <- function(directory, id = 1:332) {
	setwd("/Users/harakonan/Documents/workspace")
	temp = list.files(directory)
	datacomp <- list()
	for(i in id){
		temp[i] <- paste(directory, temp[i], sep = "/")
		datacomp[i] <- list(cbind(id = i, nobs = sum(complete.cases(read.csv(temp[i])))))
	}
	datacompall <- do.call(rbind, datacomp[id])
	as.data.frame(datacompall)
}
#完成
complete("specdata", 1)
complete("specdata", c(2, 4, 8, 10, 12))
complete("specdata", 30:25)
complete("specdata", 3)
