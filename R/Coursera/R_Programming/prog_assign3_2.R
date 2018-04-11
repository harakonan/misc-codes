# TODO: Add comment
# 
# Author: harakonan
###############################################################################

setwd("/Users/harakonan/Documents/workspace/rprog-data-ProgAssignment3-data")
outcomedata <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
outcomecolname <- colnames(outcomedata)
outcost <- split(outcomedata, outcomedata$State)
statename <- names(outcost)
##������

outcost$MD[, 11] <- as.numeric(outcost$MD[, 11])
##numeric�ɕύX���Ă���data.frame���쐬���Ȃ��ƁAfactor�Ƃ��ĔF������Anumeric�̕ϊ��������ɂȂ��Ă��܂�
##17.1(factor)��25(numeric order)
outcobimd <- data.frame(outcost$MD[, 2], outcost$MD[, 11],stringsAsFactors = FALSE)
##matrix�ł͑S�ē���class�̂��̂����i�[�o���Ȃ��A�܂�cbind����_��
##data.frame�Ƃ��č쐬���Ȃ���2��ڂ�numeric�̂܂܂ɏo���Ȃ�
##data.frame��default�ł�character��factor�ɂȂ��Ă��܂��̂�stringsAsFactors��FALSE�ɐݒ肷��
head(outcobimd)##hospital name��outcome�̕\������
class(outcobimd)##data.frame
class(outcobimd[1, 1])
class(outcobimd[1, 2])##numeric
goutcobimd <- na.omit(outcobimd)
head(goutcobimd)##NA���O
ordgoutcobimd <- goutcobimd[order(goutcobimd[, 2], goutcobimd[, 1]), ]
head(ordgoutcobimd)##���ʂŕ��בւ�
##outcome�ł�NA�����������ʕ\
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
##rank�Ɏw�肳�ꂽ���ʂ�^����
##nrow���z���Ă�����NA
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