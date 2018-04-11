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
good1 <- na.omit(data1)#NA���������f�[�^�쐬
nrow(good1)#�����l���������s��
sum(complete.cases(data1))#����ł�����
datacomp0 <- data.frame(id = integer(0), nobs = integer(0))#empty data
datacomp1 <- data.frame(id = 1, nobs = sum(complete.cases(data1)))
rbind(datacomp0, datacomp1)#data1��id��nods��

setwd("/Users/harakonan/Documents/workspace")
temp = list.files("specdata")
datacomp <- list()
for(i in 1:10){
	temp[i] <- paste("specdata", temp[i], sep = "/")
	datacomp[i] <- list(cbind(id = i, nods = sum(complete.cases(read.csv(temp[i])))))
}
datacomp#�t�@�C��1-10��list�ł�id��nods�̂܂Ƃ�
datacomp[1:10]#�t�@�C��1-10�������o�o����
datacompall <- do.call(rbind, datacomp[1:10])
datacompall#datacomp�����list�ɂ܂Ƃ�
as.data.frame(datacompall)#�����data.frame�ɕϊ�

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
#����
complete("specdata", 1)
complete("specdata", c(2, 4, 8, 10, 12))
complete("specdata", 30:25)
complete("specdata", 3)