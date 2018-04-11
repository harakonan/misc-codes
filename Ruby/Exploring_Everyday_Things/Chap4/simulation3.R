setwd("./Documents/workspace/Ruby/Exploring_Everyday_Things/Chap4")

library(ggplot2)
library(reshape2)

options(digits=1, scipen=10)

data <- data.frame(population=seq(10,600,10))
for (i in 1:4){
    rawdata <- read.csv(paste("simulation3-",i,".csv",sep=""))
    data[paste("max",i,sep="")] <- sapply(rawdata,max)
}
datamelt <- melt(data, id.vars="population", variable.name="number_of_restroom",
                 value.name="max_queue_size")

ggplot(datamelt, aes(x=population, y=max_queue_size,
                     shape=number_of_restroom)) +
    scale_shape_manual(values=c(2,3,4,5)) +
    geom_point() + geom_smooth(method=loess)

ggplot(datamelt, aes(x=population, y=max_queue_size,
                     colour=number_of_restroom)) +
    geom_point() + geom_smooth(method=loess)
