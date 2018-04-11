# TODO: Add comment
# 
# Author: harakonan
###############################################################################

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

setwd("/Users/harakonan/Documents/workspace/cousera")