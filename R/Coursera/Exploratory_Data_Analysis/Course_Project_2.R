# TODO: Add comment
# 
# Author: harakonan
###############################################################################

setwd("/Users/harakonan/Documents/workspace/Exploratory_Data_Analysis")
list.files()
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
download.file(fileUrl, destfile = "./data/Course_Project_2.zip", method = "curl")
unzip("./data/Course_Project_2.zip", exdir = "./data/Course_Project_2")
list.files("./data/Course_Project_2")
NEI <- readRDS("./data/Course_Project_2/summarySCC_PM25.rds")
SCC <- readRDS("./data/Course_Project_2/Source_Classification_Code.rds")
head(NEI)
head(SCC)

#1
#sum total emissions for each year
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

#different solution
library(plyr)
totalem <- ddply(NEI,.(year),summarize,total.Emissions = sum(Emissions))

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

#different solution
NEI.Bal <- subset(NEI, fips=="24510")
attach(NEI.Bal)
year <- as.factor(year)
total.Bal <- aggregate(Emissions,by=list(year),FUN=sum)
detach(NEI.Bal)

#3
#create data frame only include sources from Baltimore
NEI.Bal <- NEI[NEI$fips == "24510",]
#prepare for analysing
NEI.Bal$type <- as.factor(NEI.Bal$type)
NEI.Bal.year <- split(NEI.Bal,NEI.Bal$year)
#sum for each year and type
sum.year.type <- sapply(NEI.Bal.year,function(x) with(x,tapply(Emissions,type,sum)))
#make data frame for plotting
year <- c(1999,2002,2005,2008)
type <- as.factor(c("NON-ROAD","NONPOINT","ON-ROAD","POINT"))
df.sum.year.type <- data.frame(Emissions = as.vector(sum.year.type),
		year = rep(year,each=4),type = rep(type,4))
#plot
library(ggplot2)
g <- qplot(year,Emissions,data=df.sum.year.type,color=type,geom="line")
g + labs(title="total PM2.5 emissions in Baltimore") +
		labs(y="PM2.5 emission (tons)")
#create png file
dev.copy(png, file="plot3.png")
dev.off()

#different solution
library(reshape)
library(reshape2)
meltdata <- melt(NEI.Bal,c("year","type"),measure.vars="Emissions")
head(NEI.Bal)
head(meltdata)
sum.year.type <- dcast(meltdata,year + type ~ variable,sum)

#4
#create data frame only include sources related to coal combustion
Sec <- unique(SCC$EI.Sector)
coal <- grep("Coal",Sec,value=T)
SCC$SCC <- as.character(SCC$SCC)
coal.SCC <- list()
for (i in 1:length(coal)){
	coal.SCC[[i]] <- SCC$SCC[SCC$EI.Sector == coal[i]]
}
coal.SCC <- do.call("c",coal.SCC)
NEI.coal <- list()
for (i in 1:length(coal.SCC)){
	NEI.coal[[i]] <- NEI[NEI$SCC == coal.SCC[i],]
}
NEI.coal <- do.call("rbind",NEI.coal)
#sum for each year
NEI.coal.year <- split(NEI.coal,NEI.coal$year)
sum.NEI.coal.year <- sapply(NEI.coal.year,function(x) with(x,sum(Emissions)))
#make data frame for plotting
year <- c(1999,2002,2005,2008)
df.sum.NEI.coal.year <- data.frame(Emissions=sum.NEI.coal.year,year=year)
#plot
library(ggplot2)
g <- qplot(year,Emissions,data=df.sum.NEI.coal.year,geom="line")
g + labs(title="total PM2.5 emissions related to coal combustion") +
		labs(y="PM2.5 emission (tons)")
#create png file
dev.copy(png, file="plot4.png")
dev.off()

#different solution
coal.SCC <- SCC[grepl("Coal",SCC$EI.Sector),"SCC"]
NEI.coal <- subset(NEI,SCC %in% coal.SCC)
meltdata <- melt(NEI.coal,"year",measure.vars="Emissions")
NEI.coal.year <- dcast(meltdata,year~variable,sum)

#5
head(SCC)
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
#plot
library(ggplot2)
g <- qplot(year,Emissions,data=df.sum.NEI.Bal.vehicle.year,geom="line")
g + labs(title="total PM2.5 emissions from motor vehicles in Baltimore") +
		labs(y="PM2.5 emission (tons)")
#create png file
dev.copy(png, file="plot5.png")
dev.off()

#6
#repeat the process of #5 for Los Angeles
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