# TODO: Add comment
# 
# Author: harakonan
###############################################################################

best <- function(state, outcome){
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
	harank <- outcost[[state]][order(outcost[[state]][, outcomename], outcost[[state]][, 2]), 2]
	harank[1]
}

setwd("/Users/harakonan/Documents/workspace/cousera")
