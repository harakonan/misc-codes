# TODO: Add comment
# 
# Author: harakonan
###############################################################################

setwd("/Users/harakonan/workspace/Stiglitz Public economics")
library(ggplot2)

#function limitRange
limitRange <- function(fun,min,max){
	function(x){
		y <- fun(x)
		y[x<min | x>max] <- NA
		return(y)
	}
}

#natural monopolies
func <- function(x) -x+12
func2 <- function(x) -2*x+12
func3 <- function(x) 125/2/(x^2)+2
line <- limitRange(func,0,12)
line2 <- limitRange(func2,0,6)
curve <- limitRange(func3,2.5,11)
shade <- data.frame(x=c(0,0,5,5),y=c(4.5,7,7,4.5))
ggplot(data.frame(x=c(0,14)),aes(x)) + 
		stat_function(fun=line,n=500) +
		stat_function(fun=line2,n=500) +
		stat_function(fun=curve,n=200) +
		geom_polygon(data=shade,mapping=aes(x=x,y=y),alpha=0.8) +
		annotate("text",x=6,y=8,label="demand curve",colour="black") +
		annotate("text",x=2.5,y=3,label="marginal revenue",colour="black") +
		annotate("text",x=12,y=3,label="average cost",colour="black") +
		annotate("text",x=13,y=1.7,label="marginal cost",colour="black") +
		annotate("text",x=-0.6,y=12,label="price",colour="black") +
		annotate("text",x=13.5,y=-0.5,label="quantity",colour="black") +
		annotate("text",x=-0.5,y=-0.5,label="0",colour="black") +
		annotate("text",x=-0.5,y=2,label="c",colour="black") +
		annotate("text",x=-0.5,y=4.5,label="c*",colour="black") +
		annotate("text",x=-0.5,y=7,label="p",colour="black") +
		annotate("text",x=5,y=-0.5,label="Q*",colour="black") +
		annotate("text",x=9.27,y=-0.5,label="Q1",colour="black") +
		annotate("text",x=10,y=-0.5,label="Q0",colour="black") +
		annotate("text",x=2.3,y=5.7,label="monopoly profit",colour="white") +
		annotate("segment",x=0,xend=12,y=2,yend=2) +
		annotate("segment",x=5,xend=5,y=0,yend=4.5,linetype="dashed") +
		annotate("segment",x=9.27,xend=9.27,y=0,yend=2.73,linetype="dashed") +
		annotate("segment",x=10,xend=10,y=0,yend=2,linetype="dashed") +
		annotate("segment",x=0,xend=0,y=0,yend=14) +
		annotate("segment",x=0,xend=14,y=0,yend=0) 

