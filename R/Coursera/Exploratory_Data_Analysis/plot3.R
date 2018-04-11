# TODO: Add comment
# 
# Author: harakonan
###############################################################################

fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
download.file(fileUrl, destfile = "./data/Course_Project_2.zip", method = "curl")
unzip("./data/Course_Project_2.zip", exdir = "./data/Course_Project_2")
list.files("./data/Course_Project_2")
NEI <- readRDS("./data/Course_Project_2/summarySCC_PM25.rds")

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


