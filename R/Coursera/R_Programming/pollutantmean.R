# TODO: Add comment
# 
# Author: harakonan
###############################################################################

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

setwd("/Users/harakonan/Documents/workspace/cousera")