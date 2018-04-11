# TODO: Add comment
# 
# Author: harakonan
###############################################################################

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

setwd("/Users/harakonan/Documents/workspace/cousera")

