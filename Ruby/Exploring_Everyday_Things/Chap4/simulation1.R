getwd()
setwd("./Documents/workspace/Ruby/Exploring_Everyday_Things/Chap4")

library(ggplot2)
library(reshape2)

options(digits=1, scipen=10)

data <- read.csv("simulation1.csv")
datasum <- data.frame(population=as.numeric(gsub("X", "", names(data))))
datasum$mean <- colMeans(data)
datasum$median <- sapply(data, median)
datasum$max  <- sapply(data, max)
datasummelt <- melt(datasum, id.vars="population", variable.name="summarize",
                    value.name="queue_size")

ggplot(datasummelt, aes(x=population, y=queue_size, shape=summarize)) +
    scale_shape_manual(values=c(2,3,4)) +
    geom_point() + geom_smooth(method=loess)

ggplot(datasummelt, aes(x=population, y=queue_size, colour=summarize)) +
    geom_point() + geom_smooth(method=loess)

proptab200 <- data.frame(prop.table(table(data$X200)))
ggplot(proptab200, aes(x=Var1, y=Freq)) + geom_bar(stat="identity") +
    geom_text(aes(label=paste(round(Freq,3)*100, "%",sep=""), vjust=-0.2))

