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
nrow(gooddata1)#�����l����������
cor(gooddata1$sulfate, gooddata1$nitrate)
#data1��sulfate��nitrate�̑��֌W��
if(nrow(gooddata1) > 150){
	cor(gooddata1$sulfate, gooddata1$nitrate)
}else{
	vector()
}
#�����l������������threshold150���z����Ȃ�cor�A�z���Ȃ��Ȃ牽���Ȃ�

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
#�t�@�C��1-10�܂ł�臒l150�ȏ�̑��֌W��

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
#����
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