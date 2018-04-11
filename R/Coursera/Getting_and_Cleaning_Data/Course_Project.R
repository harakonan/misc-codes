# TODO: Add comment
# 
# Author: harakonan
###############################################################################

setwd("/Users/harakonan/Documents/workspace/Getting_and_Cleaning_Data")
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl, destfile = "./data/Course_Project.zip", method = "curl")
unzip("./data/Course_Project.zip", exdir = "./data/Course_Project")
list.files("./data/Course_Project")
##"UCI HAR Dataset"
list.files("./data/Course_Project/UCI HAR Dataset")
##"README.txt""activity_labels.txt""features.txt""features_info.txt""test""train"
list.files("./data/Course_Project/UCI HAR Dataset/test")
##"Inertial Signals""X_test.txt""subject_test.txt""y_test.txt"
list.files("./data/Course_Project/UCI HAR Dataset/train")
##"Inertial Signals""X_train.txt""subject_train.txt""y_train.txt"
setwd("/Users/harakonan/Documents/workspace/Getting_and_Cleaning_Data/data/Course_Project/UCI HAR Dataset")
subject_train <- read.table("./train/subject_train.txt")
X_train <- read.table("./train/X_train.txt")
y_train <- read.table("./train/y_train.txt")
body_acc_x_train <- read.table("./train/Inertial Signals/body_acc_x_train.txt")
nrow(body_acc_x_train)
##want to read files automatically

##1
setwd("/Users/harakonan/Documents/workspace/Getting_and_Cleaning_Data/data/Course_Project/UCI HAR Dataset")
test <- list.files("test")
train <- list.files("train")
test_Int <- list.files("test/Inertial Signals")
train_Int <- list.files("train/Inertial Signals")
datalist_test <- list()
datalist_train <- list()
datalist_test_Int <- list()
datalist_train_Int <- list()
for(i in 2:4){
	test[i] <- paste("test", test[i], sep = "/")
	datalist_test[i-1] <- list(read.table(test[i]))
}
for(i in 2:4){
	train[i] <- paste("train", train[i], sep = "/")
	datalist_train[i-1] <- list(read.table(train[i]))
}
for(i in 1:9){
	test_Int[i] <- paste("test/Inertial Signals", test_Int[i], sep = "/")
	datalist_test_Int[i] <- list(read.table(test_Int[i]))
}
for(i in 1:9){
	train_Int[i] <- paste("train/Inertial Signals", train_Int[i], sep = "/")
	datalist_train_Int[i] <- list(read.table(train_Int[i]))
}
##files are read
testtemp1 <- do.call(cbind, datalist_test)
testtemp2 <- do.call(cbind, datalist_test_Int)
testall <- cbind(testtemp1, testtemp2)
traintemp1 <- do.call(cbind, datalist_train)
traintemp2 <- do.call(cbind, datalist_train_Int)
trainall <- cbind(traintemp1,traintemp2)
dataall <- rbind(testall, trainall)
##merged data
##column1-561 = X, 562 = subject, 563 = y, 564- = Inertial Signals

##2
features <- read.table("features.txt", stringsAsFactors=F)
mean <- data.frame(number = grep("mean()", features[,2]),
		variable = grep("mean()", features[,2], value=T))
mean <- mean[-grep("meanFreq", mean[,2]),]
##column number of the mean
std <- data.frame(number = grep("std()", features[,2]),
		variable = grep("std()", features[,2], value=T))
##column number of the std
meandata <- dataall[,mean[,1]]
stddata <- dataall[,std[,1]]
##extract mean and standard diviation measurements

##3
activity <- read.table("activity_labels.txt", col.names=c("number","label"),
		stringsAsFactors=F)
activity$label[1]
activity_label <- sapply(dataall[,563], function(x) switch(x,activity$label[1],
					activity$label[2],activity$label[3],activity$label[4],
					activity$label[5],activity$label[6]))
##named the activities

##4
names(meandata) <- mean$variable
names(stddata) <- std$variable
subject_activity <- data.frame(subject = dataall[,562], activity = activity_label)
gooddata <- cbind(subject_activity, cbind(meandata,stddata))
head(gooddata)
##labeled the variables

##5
activity_variable <- split(gooddata, gooddata$activity)
variable_average <- list()
activity_variable_average <- list()
for (i in 1:6){
	temp <- split(activity_variable[[activity$label[i]]],
			activity_variable[[activity$label[i]]]$subject)
	for (j in 1:30){
		activity_variable_average[[j]] <- sapply(temp[[j]][-c(1,2)], mean)
	}
	variable_average[[activity$label[i]]] <- do.call("rbind", activity_variable_average)
}
##made a list with each activity and the row number means each subject
averagelist <- list()
for (i in 1:6){
	averagelist[[i]] <- data.frame(subject = seq(1,30,1),
			activity = activity$label[i],variable_average[[activity$label[i]]])
}
average <- do.call("rbind", averagelist)
##dataframe for each activity and each subject

setwd("/Users/harakonan/Documents/workspace/Getting_and_Cleaning_Data")
write.table(average, "./data/Course_Project/tidy_data.txt", row.name=F)