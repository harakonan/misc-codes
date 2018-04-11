# TODO: Add comment
# 
# Author: harakonan
###############################################################################

rankhospital <- function(state, outcome, num = "best"){
	setwd("/Users/harakonan/Documents/workspace/rprog-data-ProgAssignment3-data")
	outcomedata <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
	outcomecolname <- colnames(outcomedata)
	outcost <- split(outcomedata, outcomedata$State)
	statename <- names(outcost)
	if(any(state == statename) == FALSE){
		stop(message = "invalid state")
	}
	if(outcome == "heart attack"){
		outcomename <- outcomecolname[11]
	}else if(outcome == "heart failure"){
		outcomename <- outcomecolname[17]
	}else if(outcome == "pneumonia"){
		outcomename <- outcomecolname[23]
	}else stop(messege = "invalid outcome")
	outcost[[state]][, outcomename] <- as.numeric(outcost[[state]][, outcomename])
	outcostex <- data.frame(outcost[[state]][, 2], outcost[[state]][, outcomename]
			, stringsAsFactors = FALSE)
	goutcostex <- na.omit(outcostex)
	hqrank <- goutcostex[order(goutcostex[, 2], goutcostex[, 1]), ]
	nrowrank <- nrow(hqrank)
	if(num == "best"){
		rank <- 1
	}else if(num >= 1 && num <= nrowrank){
		rank <- num
	}
	else if(num == "worst"){
		rank <- nrowrank
	}else return(NA)
	hqrank[rank, 1]
}

setwd("/Users/harakonan/Documents/workspace/cousera")
