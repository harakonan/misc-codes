# TODO: Add comment
# 
# Author: harakonan
###############################################################################

rankall <- function(outcome, num = "best"){
	setwd("/Users/harakonan/Documents/workspace/rprog-data-ProgAssignment3-data")
	outcomedata <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
	outcomecolname <- colnames(outcomedata)
	outcost <- split(outcomedata, outcomedata$State)
	statename <- names(outcost)
	if(outcome == "heart attack"){
		outcomename <- outcomecolname[11]
	}else if(outcome == "heart failure"){
		outcomename <- outcomecolname[17]
	}else if(outcome == "pneumonia"){
		outcomename <- outcomecolname[23]
	}else stop(messege = "invalid outcome")
	makeranktada <- function(data, rankf){
		data[, outcomename] <- as.numeric(data[, outcomename])
		outcobif <- data.frame(data[, 2], data[, outcomename], stringsAsFactors = FALSE)
		goutcobif <- na.omit(outcobif)
		ordgoutcobif <- goutcobif[order(goutcobif[, 2], goutcobif[, 1]), ]
		nrowrank <- nrow(ordgoutcobif)
		if(rankf == "best"){
			rank <- 1
		}else if(rankf >= 1 && rankf <= nrowrank){
			rank <- rankf
		}
		else if(rankf == "worst"){
			rank <- nrowrank
		}else rank <- rankf
		ranktaf <- data.frame(hospital = ordgoutcobif[rank, 1], state = data[1, 7], stringsAsFactors = FALSE)
		ranktaf
	}
	ranktaall <- by(outcomedata, outcomedata$State, makeranktada, rankf = num)
	daranktaall <- Reduce(function(...) merge(..., all = T), ranktaall)
	daranktaall <- daranktaall[order(daranktaall[, 2]), ]
	rownames(daranktaall) <- statename
	daranktaall
}

setwd("/Users/harakonan/Documents/workspace/cousera")