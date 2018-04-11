setwd("./Documents/workspace/Ruby/Exploring_Everyday_Things/Chap4")

library(ggplot2)
library(reshape2)

options(digits=1, scipen=10)

data <- read.csv("simulation2.csv")
head(data)
datasum <- data.frame(restroom=as.numeric(gsub("X", "", names(data))))
head(datasum)
datasum$mean <- colMeans(data)
datasum$median <- sapply(data, median)
datasum$max  <- sapply(data, max)
datasummelt <- melt(datasum, id.vars="restroom", variable.name="summarize",
                    value.name="queue_size")

ggplot(datasummelt, aes(x=restroom, y=queue_size, shape=summarize)) +
    scale_shape_manual(values=c(2,3,4)) +
    geom_point() + geom_smooth(method=loess)

proptab19 <- data.frame(prop.table(table(data$X19)))
ggplot(proptab19, aes(x=Var1, y=Freq)) + geom_bar(stat="identity") +
    geom_text(aes(label=paste(round(Freq,3)*100, "%",sep=""), vjust=-0.2))