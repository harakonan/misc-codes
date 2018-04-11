# TODO: Add comment
# 
# Author: harakonan
###############################################################################

setwd("/Users/harakonan/Documents/workspace/rprog-data-ProgAssignment3-data")
outcomedata <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
outcomecolname <- colnames(outcomedata)
outcost <- split(outcomedata, outcomedata$State)
statename <- names(outcost)
##環境整備

outcost[[statename[1]]][, 11] <- as.numeric(outcost[[statename[1]]][, 11])
outcobi1 <- data.frame(outcost[[statename[1]]][, 2],
				outcost[[statename[1]]][, 11], stringsAsFactors = FALSE)
##statename[1](AK)をまず考える
goutcobi1 <- na.omit(outcobi1)
ordgoutcobi1 <- goutcobi1[order(goutcobi1[, 2], goutcobi1[, 1]), ]
head(ordgoutcobi1)
##ranking table
rank <- 3
rankta1 <- data.frame(hospital = ordgoutcobi1[rank, 1], state = statename[1])
rankta1
##data.frameにhospitalとstate

makerankta <- function(state, rank){
	data <- outcost[[state]]
	data[, 11] <- as.numeric(data[, 11])
	outcobif <- data.frame(data[, 2], data[, 11], stringsAsFactors = FALSE)
	goutcobif <- na.omit(outcobif)
	ordgoutcobif <- goutcobif[order(goutcobif[, 2], goutcobif[, 1]), ]
	ranktaf <- data.frame(hospital = ordgoutcobif[rank, 1], state = state, stringsAsFactors = FALSE)
	ranktaf
}
makerankta(statename[1], 3)
##dataからranking tableを作成出来るfunction
##このままだとlapplyが使えない

makeranktada <- function(data, rank){
	data[, 11] <- as.numeric(data[, 11])
	outcobif <- data.frame(data[, 2], data[, 11], stringsAsFactors = FALSE)
	goutcobif <- na.omit(outcobif)
	ordgoutcobif <- goutcobif[order(goutcobif[, 2], goutcobif[, 1]), ]
	ranktaf <- data.frame(hospital = ordgoutcobif[rank, 1], state = data[1, 7], stringsAsFactors = FALSE)
	ranktaf
}
makeranktada(outcost[[1]], 3)

makeranktada1 <- function(data){
	data[, 11] <- as.numeric(data[, 11])
	outcobif <- data.frame(data[, 2], data[, 11], stringsAsFactors = FALSE)
	goutcobif <- na.omit(outcobif)
	ordgoutcobif <- goutcobif[order(goutcobif[, 2], goutcobif[, 1]), ]
	ranktaf <- data.frame(hospital = ordgoutcobif[3, 1], state = data[1, 7], stringsAsFactors = FALSE)
	ranktaf
}
makeranktada1(outcost[[1]])
##まずrank3で固定

ranktaall <- by(outcomedata, outcomedata$State, makeranktada1)
head(ranktaall)
##rank3 of all state

ranktaall3 <- by(outcomedata, outcomedata$State, makeranktada, rank = 3)
head(ranktaall3)
##makeranktadaにrankを代入して利用
ranktaall500 <- by(outcomedata, outcomedata$State, makeranktada, rank = 500)
head(ranktaall500)
##NAを返している
ranktaall20 <- by(outcomedata, outcomedata$State, makeranktada, rank = 20)
head(ranktaall20, 10)
##rank=20
daranktaall20 <- Reduce(function(...) merge(..., all = T), ranktaall20)
head(daranktaall20, 10)
##Reduceを使ってlistをmerge
##hospital nameの順になっている
daranktaall20 <- daranktaall20[order(daranktaall20[, 2]), ]
head(daranktaall20, 10)
##state順に
rownames(daranktaall20) <- statename
##行の名前をstateに
##rank20のdata.frame完成

##makeranktadaでは"worst"に対応出来ない
##rankに関する情報を加える
makeranktada <- function(data, rank){
	data[, 11] <- as.numeric(data[, 11])
	outcobif <- data.frame(data[, 2], data[, 11], stringsAsFactors = FALSE)
	goutcobif <- na.omit(outcobif)
	ordgoutcobif <- goutcobif[order(goutcobif[, 2], goutcobif[, 1]), ]
	nrowrank <- nrow(ordgoutcobif)
	if(rank == "best"){
		rank <- 1
	}else if(rank >= 1 && rank <= nrowrank){
		rank <- rank
	}
	else if(rank == "worst"){
		rank <- nrowrank
	}else rank <- rank
	ranktaf <- data.frame(hospital = ordgoutcobif[rank, 1], state = data[1, 7], stringsAsFactors = FALSE)
	ranktaf
}
makeranktada(outcost[[1]], 3)
makeranktada(outcost[[1]], 50)
makeranktada(outcost[[1]], "best")
makeranktada(outcost[[1]], "worst")

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
##Completion!!
head(rankall("heart attack", 20), 10)
tail(rankall("pneumonia", "worst"), 3)
tail(rankall("heart failure"), 10)

