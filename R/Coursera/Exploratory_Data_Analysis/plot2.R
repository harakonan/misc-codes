# TODO: Add comment
# 
# Author: harakonan
###############################################################################

fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
download.file(fileUrl, destfile = "./data/Course_Project_2.zip", method = "curl")
unzip("./data/Course_Project_2.zip", exdir = "./data/Course_Project_2")
list.files("./data/Course_Project_2")
NEI <- readRDS("./data/Course_Project_2/summarySCC_PM25.rds")

#2
#sum total emissions in Baltimore City for each year
total.Bal.1999 <- sum(NEI$Emissions[NEI$year == "1999" & NEI$fips == "24510"])
total.Bal.2002 <- sum(NEI$Emissions[NEI$year == "2002" & NEI$fips == "24510"])
total.Bal.2005 <- sum(NEI$Emissions[NEI$year == "2005" & NEI$fips == "24510"])
total.Bal.2008 <- sum(NEI$Emissions[NEI$year == "2008" & NEI$fips == "24510"])
#create coordinate
total.Bal <- c(total.Bal.1999,total.Bal.2002,total.Bal.2005,total.Bal.2008)
year <- c(1999,2002,2005,2008)
#plot line graph
par(bg="white")
plot(year,total.Bal,type="l",ylab="PM2.5 emission (tons)",
		main="total PM2.5 emissions in Baltimore",ylim=c(0,max(total.Bal)))
#create png file
dev.copy(png, file="plot2.png")
dev.off()

