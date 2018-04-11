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

outcost$MD[, 11] <- as.numeric(outcost$MD[, 11])
##numericに変更してからdata.frameを作成しないと、factorとして認識され、numericの変換が順序になってしまう
##17.1(factor)→25(numeric order)
outcobimd <- data.frame(outcost$MD[, 2], outcost$MD[, 11],stringsAsFactors = FALSE)
##matrixでは全て同じclassのものしか格納出来ない、つまりcbindじゃダメ
##data.frameとして作成しないと2列目をnumericのままに出来ない
##data.frameはdefaultではcharacterがfactorになってしまうのでstringsAsFactorsをFALSEに設定する
head(outcobimd)##hospital nameとoutcomeの表をつくる
class(outcobimd)##data.frame
class(outcobimd[1, 1])
class(outcobimd[1, 2])##numeric
goutcobimd <- na.omit(outcobimd)
head(goutcobimd)##NA除外
ordgoutcobimd <- goutcobimd[order(goutcobimd[, 2], goutcobimd[, 1]), ]
head(ordgoutcobimd)##順位で並べ替え
##outcomeでのNAを除いた順位表
?data.frame

numtest <- function(num = "best"){
	nrowdata <- 40
	if(num == "best"){
		rank <- 1
	}else if(num >= 1 && num <= nrowdata){
		rank <- num
	}
	else if(num == "worst"){
		rank <- nrowdata
	}else return(NA)
	rank
}
##rankに指定された順位を与える
##nrowを越えていたらNA
numtest()#1
numtest(5)
numtest(15)
numtest("worst")##nrowdata
numtest(50)##NA

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
##completion
rankhospital("TX", "heart failure", 4)
rankhospital("MD", "heart attack", "worst")
rankhospital("MN", "heart attack", 5000)