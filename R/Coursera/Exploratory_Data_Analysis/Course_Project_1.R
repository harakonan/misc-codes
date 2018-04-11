# TODO: Add comment
# 
# Author: harakonan
###############################################################################
getwd()
setwd("/Users/harakonan/Documents/workspace/Exploratory_Data_Analysis")
dir.create("data")
#download file
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileUrl, destfile = "./data/Course_Project_1.zip", method = "curl")
unzip("./data/Course_Project_1.zip", exdir = "./data/Course_Project_1")
list.files("./data/Course_Project_1")
#reading file to R console
raw <- read.csv2("./data/Course_Project_1/household_power_consumption.txt",
		stringsAsFactors=F)
#extract only the row we need
raw <- raw[(raw$Date == "1/2/2007") | (raw$Date == "2/2/2007"),]

#prepare for plotting
par("bg")
#when parameter bg="transparent" the back ground color will be grey in png file
#because png file cannot use transparent for default
par(bg="white")
#change back ground color to white

#plot1
hist(as.numeric(raw$Global_active_power), col="red", main="Global Active Power",
		xlab="Global Active Power(kilowatts)")

#creating png file
dev.copy(png, file="plot1.png")
dev.off()

#when pdf file you can leave the bg to "transparent"
dev.copy(pdf, file="plot1.pdf")
dev.off()

#plot2
#convert "Date" & "Time" to class "POSIXlt" and make variable "Date_time"
raw$Date_time <- strptime(paste(raw$Date,raw$Time), "%d/%m/%Y %H:%M:%S")
with(raw, plot(Date_time, Global_active_power, type="l", xlab="",
				ylab="Global Active Power(kilowatts)"))

#creating png file
dev.copy(png, file="plot2.png")
dev.off()

#plot3
with(raw, plot(Date_time, Sub_metering_1, type="l", xlab="",
				ylab="Energy sub metering"))
with(raw, points(Date_time, Sub_metering_2, type="l", col="red"))
with(raw, points(Date_time, Sub_metering_3, type="l", col="blue"))
legend("topright", legend=c("Sub_metering_1 ","Sub_metering_2 ","Sub_metering_3 "),
		lwd=1, col=c(par("col"),"red","purple3"))

#creating png file
dev.copy(png, file="plot3.png")
dev.off()

#plot4
par(mfcol=c(2,2))
par(bg="white")
with(raw, plot(Date_time, Global_active_power, type="l", xlab="",
				ylab="Global Active Power"))
with(raw, plot(Date_time, Sub_metering_1, type="l", xlab="",
				ylab="Energy sub metering"))
with(raw, points(Date_time, Sub_metering_2, type="l", col="red"))
with(raw, points(Date_time, Sub_metering_3, type="l", col="blue"))
legend("topright", legend=c("Sub_metering_1 ","Sub_metering_2 ","Sub_metering_3 "),
		lwd=1, col=c(par("col"),"red","purple3"), bty="n", inset=c(0.02,0))
with(raw, plot(Date_time, Voltage, type="l", xlab="datetime", ylab="Voltage"))
with(raw, plot(Date_time, Global_reactive_power, type="l", xlab="datetime",
				ylab="Global_reactive_power"))

#creating png file
dev.copy(png, file="plot4.png")
dev.off()

getwd()