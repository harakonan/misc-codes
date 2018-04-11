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
gooddata1 <- na.omit(data1)
nrow(gooddata1)#欠損値を除いた数
cor(gooddata1$sulfate, gooddata1$nitrate)
#data1のsulfateとnitrateの相関係数
if(nrow(gooddata1) > 150){
	cor(gooddata1$sulfate, gooddata1$nitrate)
}else{
	vector()
}
#欠損値を除いた数がthreshold150を越えるならcor、越えないなら何もなし

setwd("/Users/harakonan/Documents/workspace")
temp = list.files("specdata")
veccor <- vector()
for(i in 1:10){
	temp[i] <- paste("specdata", temp[i], sep = "/")
	if(nrow(na.omit(read.csv(temp[i]))) > 150){
		veccor[i] <- cor(na.omit(read.csv(temp[i]))$sulfate, na.omit(read.csv(temp[i]))$nitrate)
	}
}
goodveccor <- na.omit(veccor)
#ファイル1-10までの閾値150以上の相関係数

corr <- function(directory, threshold = 0) {
	setwd("/Users/harakonan/Documents/workspace")
	temp = list.files(directory)
	veccor <- vector()
	for(i in 1:length(temp)){
		temp[i] <- paste(directory, temp[i], sep = "/")
		if(nrow(na.omit(read.csv(temp[i]))) > threshold){
			veccor[i] <- cor(na.omit(read.csv(temp[i]))$sulfate, na.omit(read.csv(temp[i]))$nitrate)
		}
	}
	goodveccor <- na.omit(veccor)
}
#完成
cr <- corr("specdata", 150)
head(cr)
summary(cr)
cr <- corr("specdata", 400)
head(cr)
summary(cr)
cr <- corr("specdata", 5000)
summary(cr)
length(cr)
cr <- corr("specdata")
summary(cr)
length(cr)