# TODO: Add comment
# 
# Author: harakonan
###############################################################################

fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
download.file(fileUrl, destfile = "./data/Course_Project_2.zip", method = "curl")
unzip("./data/Course_Project_2.zip", exdir = "./data/Course_Project_2")
list.files("./data/Course_Project_2")
NEI <- readRDS("./data/Course_Project_2/summarySCC_PM25.rds")
SCC <- readRDS("./data/Course_Project_2/Source_Classification_Code.rds")

#6
#do things as same as plot5.R
#create data frame only include sources from Baltimore
NEI.Bal <- NEI[NEI$fips == "24510",]
#create data frame only include motor vehicle sources from above
Sec <- unique(SCC$EI.Sector)
vehicle <- grep("Vehicles",Sec,value=T)
SCC$SCC <- as.character(SCC$SCC)
vehicle.SCC <- list()
for (i in 1:length(vehicle)){
	vehicle.SCC[[i]] <- SCC$SCC[SCC$EI.Sector == vehicle[i]]
}
vehicle.SCC <- do.call("c",vehicle.SCC)
#there are NAs in vehicle.SCC but no NAs in NEI$SCC
table(is.na(NEI$SCC))#all False
#this means I only need values which are not NA
vehicle.SCC <- na.omit(vehicle.SCC)
NEI.Bal.vehicle <- list()
for (i in 1:length(vehicle.SCC)){
	NEI.Bal.vehicle[[i]] <- NEI.Bal[NEI.Bal$SCC == vehicle.SCC[i],]
}
NEI.Bal.vehicle <- do.call("rbind",NEI.Bal.vehicle)
#sum for each year
NEI.Bal.vehicle.year <- split(NEI.Bal.vehicle,NEI.Bal.vehicle$year)
sum.NEI.Bal.vehicle.year <- sapply(NEI.Bal.vehicle.year,
		function(x) with(x,sum(Emissions)))
#make data frame for plotting
year <- c(1999,2002,2005,2008)
df.sum.NEI.Bal.vehicle.year <- data.frame(Emissions=sum.NEI.Bal.vehicle.year,year=year)
#repeat the process above for Los Angeles
NEI.Los <- NEI[NEI$fips == "06037",]
NEI.Los.vehicle <- list()
for (i in 1:length(vehicle.SCC)){
	NEI.Los.vehicle[[i]] <- NEI.Los[NEI.Los$SCC == vehicle.SCC[i],]
}
NEI.Los.vehicle <- do.call("rbind",NEI.Los.vehicle)
NEI.Los.vehicle.year <- split(NEI.Los.vehicle,NEI.Los.vehicle$year)
sum.NEI.Los.vehicle.year <- sapply(NEI.Los.vehicle.year,
		function(x) with(x,sum(Emissions)))
year <- c(1999,2002,2005,2008)
df.sum.NEI.Los.vehicle.year <- data.frame(Emissions=sum.NEI.Los.vehicle.year,year=year)
#merge data frames of Baltimore and Los
df.sum.NEI.Bal.vehicle.year$place <- "Baltimore"
df.sum.NEI.Los.vehicle.year$place <- "Los Angeles"
Bal.Los.vehicle <- rbind(df.sum.NEI.Bal.vehicle.year,df.sum.NEI.Los.vehicle.year)
#plot
library(ggplot2)
g <- qplot(year,Emissions,data=Bal.Los.vehicle,color=place,geom="line")
g + labs(title="total PM2.5 emissions from motor vehicles") +
		labs(y="PM2.5 emission (tons)")
#create png file
dev.copy(png, file="plot6.png")
dev.off()

