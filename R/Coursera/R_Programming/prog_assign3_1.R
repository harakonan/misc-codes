# TODO: Add comment
# 
# Author: harakonan
###############################################################################

setwd("/Users/harakonan/Documents/workspace/rprog-data-ProgAssignment3-data")

outcome <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
head(outcome)
outcomecolname <- colnames(outcome)##それぞれの列の名前
outcomenameha <- outcomecolname[11]
outcome[, 11] <- as.numeric(outcome[, 11])
##11 is Heart Attack rate
##17 is Heart Failure rate
##23 is Pneumonia rate
hist(outcome[, 11])
head(outcome[, 11])
##introduction

head(outcome[, 7])##州の名前
head(outcome$State)
outcohast <- split(outcome[, 11], outcome$State)
##split outcome of "heart attack" with the "State"
head(outcohast)
attributes(outcohast)##存在する属性を調べられる
names(outcohast)##属性namesでStateがわかる
goutcohast <- lapply(outcohast, na.omit)##NAの排除
head(goutcohast)
lapply(goutcohast, min)##それぞれのStateの最小値

outcohast <- split(outcome, outcome$State)
head(outcohast$"WY"[, 2])##WYの病院の名前,""つきでも大丈夫
harankwy <- outcohast$WY[order(outcohast$WY[, 11]), 2]##WYの病院のheart attack rateの順位
harankwy[1]##The hospital of the first place in heart attack rate
harankwy <- outcohast$WY[order(outcohast$WY[, outcomenameha]), 2]
harankwy##数字じゃなくてもok
harankwy <- outcohast$WY[order(outcohast$WY[, 11], outcohast$WY[, 2]), 2]
harankwy##かつ名前順

outcometest <- function(outcome){
	setwd("/Users/harakonan/Documents/workspace/rprog-data-ProgAssignment3-data")
	outcomedata <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
	outcomecolname <- colnames(outcomedata)
	if(outcome == "heart attack"){
		outcomename <- outcomecolname[11]
	}else if(outcome == "heart failure"){
		outcomename <- outcomecolname[17]
	}else if(outcome == "pneumonia"){
		outcomename <- outcomecolname[23]
	}else stop(messege = "invalid outcome")
	outcomename
}
outcometest("pneumonia")
outcometest("heart")
##change outcomename by outcome and if invalid outcome was assigned 
##it returns error message

statetest <- function(state){
	setwd("/Users/harakonan/Documents/workspace/rprog-data-ProgAssignment3-data")
	outcomedata <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
	outcost <- split(outcomedata, outcomedata$State)
	statename <- names(outcost)
	if(any(state == statename) == TRUE){
			state
		}else stop(message = "invalid state")
}
statetest("AK")
statetest("WY")
statetest("BB")
##When invalid state was assigned it returns error message

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
##completion
##functionの変数にlistの$は使えない
best("TX", "heart attack")
best("TX", "heart failure")
best("MD", "heart attack")
best("MD", "pneumonia")
best("BB", "heart attack")
best("NY", "heart")
