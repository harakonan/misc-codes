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

