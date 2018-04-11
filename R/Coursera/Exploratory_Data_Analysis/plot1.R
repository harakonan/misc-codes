# TODO: Add comment
# 
# Author: harakonan
###############################################################################

fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
download.file(fileUrl, destfile = "./data/Course_Project_2.zip", method = "curl")
unzip("./data/Course_Project_2.zip", exdir = "./data/Course_Project_2")
list.files("./data/Course_Project_2")
NEI <- readRDS("./data/Course_Project_2/summarySCC_PM25.rds")

#1
#sum total emissions of each year
total.1999 <- sum(NEI$Emissions[NEI$year == "1999"])
total.2002 <- sum(NEI$Emissions[NEI$year == "2002"])
total.2005 <- sum(NEI$Emissions[NEI$year == "2005"])
total.2008 <- sum(NEI$Emissions[NEI$year == "2008"])
#create coordinate
totalem <- c(total.1999,total.2002,total.2005,total.2008)
year <- c(1999,2002,2005,2008)
#plot line graph
par(bg="white")
plot(year,totalem/(10^5),type="l",ylab="PM2.5 emission (*10^5 tons)",
		main="total PM2.5 emissions",ylim=c(0,max(totalem)/(10^5)))
#create png file
dev.copy(png, file="plot1.png")
dev.off()

