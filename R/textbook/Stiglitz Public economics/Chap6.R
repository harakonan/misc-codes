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

#non-rivalrous and market failure
func <- function(x) -x+10
line <- limitRange(func,0,10)
line_limit <- limitRange(func,5,10)
ggplot(data.frame(x=c(0,14)),aes(x)) + 
		stat_function(fun=line,n=200) +
		stat_function(fun=line_limit,n=200,geom="area",fill="black",alpha=0.4) +
		annotate("text",x=7,y=1,label="deadweight loss",colour="white") +
		annotate("text",x=4,y=8,label="demand curve",colour="black") +
		annotate("text",x=10.5,y=8,label="capacity line",colour="black") +
		annotate("text",x=-0.6,y=10,label="price",colour="black") +
		annotate("text",x=13.5,y=-0.5,label="quantity",colour="black") +
		annotate("text",x=-0.5,y=-0.5,label="0",colour="black") +
		annotate("text",x=-0.5,y=5,label="p",colour="black") +
		annotate("text",x=5,y=-0.5,label="Qe",colour="black") +
		annotate("text",x=10,y=-0.5,label="Qm",colour="black") +
		annotate("text",x=12,y=-0.5,label="Qc",colour="black") +
		annotate("segment",x=0,xend=5,y=5,yend=5,linetype="dashed") +
		annotate("segment",x=5,xend=5,y=0,yend=5,linetype="dashed") +
		annotate("segment",x=12,xend=12,y=0,yend=10) +
		annotate("segment",x=0,xend=0,y=0,yend=12) +
		annotate("segment",x=0,xend=14,y=0,yend=0)

#publicly provided private goods
func <- function(x) -x/2+5
func2 <- function(x) -2*x+20
line <- limitRange(func,0,10)
line2 <- limitRange(func2,5,10)
shade <- data.frame(x=c(6,10,10),y=c(2,0,2))
shade2 <- data.frame(x=c(9,10,10),y=c(2,0,2))
ggplot(data.frame(x=c(0,14)),aes(x)) + 
		stat_function(fun=line,n=200) +
		stat_function(fun=line2,n=200) +
		geom_polygon(data=shade,mapping=aes(x=x,y=y),alpha=0.4) +
		geom_polygon(data=shade2,mapping=aes(x=x,y=y)) +
		annotate("text",x=8.6,y=1.7,label="welfare loss",colour="white") +
		annotate("text",x=4,y=5.5,label="demand curve",colour="black") +
		annotate("text",x=-0.6,y=10,label="price",colour="black") +
		annotate("text",x=13.5,y=-0.5,label="quantity",colour="black") +
		annotate("text",x=-0.5,y=-0.5,label="0",colour="black") +
		annotate("text",x=-0.5,y=2,label="c",colour="black") +
		annotate("text",x=6,y=-0.5,label="Qea",colour="black") +
		annotate("text",x=9,y=-0.5,label="Qeb",colour="black") +
		annotate("text",x=10,y=-0.5,label="Qm",colour="black") +
		annotate("text",x=2,y=3.5,label="A",colour="black") +
		annotate("text",x=7,y=7,label="B",colour="black") +
		annotate("segment",x=0,xend=12,y=2,yend=2) +
		annotate("segment",x=6,xend=6,y=0,yend=2,linetype="dashed") +
		annotate("segment",x=9,xend=9,y=0,yend=2,linetype="dashed") +
		annotate("segment",x=0,xend=0,y=0,yend=12) +
		annotate("segment",x=0,xend=14,y=0,yend=0) 

#transaction cost
func <- function(x) -x+10
line <- limitRange(func,0,10)
shade <- data.frame(x=c(8,10,10),y=c(2,0,2))
shade2 <- data.frame(x=c(6,6,8),y=c(2,4,2))
shade3 <- data.frame(x=c(0,0,6,6),y=c(2,4,4,2))
ggplot(data.frame(x=c(0,14)),aes(x)) + 
		stat_function(fun=line,n=200) +
		geom_polygon(data=shade,mapping=aes(x=x,y=y),alpha=0.3) +
		geom_polygon(data=shade2,mapping=aes(x=x,y=y),alpha=0.6) +
		geom_polygon(data=shade3,mapping=aes(x=x,y=y),alpha=0.9) +
		annotate("text",x=4,y=8,label="demand curve",colour="black") +
		annotate("text",x=-0.6,y=10,label="price",colour="black") +
		annotate("text",x=13.5,y=-0.5,label="quantity",colour="black") +
		annotate("text",x=-0.5,y=-0.5,label="0",colour="black") +
		annotate("text",x=-0.5,y=2,label="c",colour="black") +
		annotate("text",x=-0.5,y=4,label="p*",colour="black") +
		annotate("text",x=6,y=-0.5,label="Qe",colour="black") +
		annotate("text",x=8,y=-0.5,label="Qo",colour="black") +
		annotate("text",x=10,y=-0.5,label="Qm",colour="black") +
		annotate("text",x=3,y=3,label="A",colour="white") +
		annotate("text",x=6.7,y=2.7,label="B",colour="white") +
		annotate("text",x=9.2,y=1.5,label="C",colour="white") +
		annotate("segment",x=0,xend=10,y=2,yend=2) +
		annotate("segment",x=0,xend=6,y=4,yend=4) +
		annotate("segment",x=6,xend=6,y=0,yend=2,linetype="dashed") +
		annotate("segment",x=8,xend=8,y=0,yend=2,linetype="dashed") +
		annotate("segment",x=0,xend=0,y=0,yend=12) +
		annotate("segment",x=0,xend=14,y=0,yend=0) 

#demand curve for public goods 1
func <- function(x) -x+10
func2 <- function(x) -2*x/3+10
func3 <- function(x) 25/x
func4 <- function(x) 75/2/x
line <- limitRange(func,0,10)
line2 <- limitRange(func2,0,15)
curve <- limitRange(func3,2.5,13)
curve2 <- limitRange(func4,3.8,13)
ggplot(data.frame(x=c(0,17)),aes(x)) + 
		stat_function(fun=line,n=200) +
		stat_function(fun=line2,n=200) +
		stat_function(fun=curve,n=200) +
		stat_function(fun=curve2,n=200) +
		annotate("text",x=12,y=1,label="budget constraint line",colour="black") +
		annotate("text",x=5,y=10,label="indifference curve",colour="black") +
		annotate("text",x=0,y=11.5,label="private",colour="black") +
		annotate("text",x=16.5,y=-0.5,label="public",colour="black") +
		annotate("text",x=-0.5,y=-0.5,label="0",colour="black") +
		annotate("text",x=5,y=-0.5,label="G1",colour="black") +
		annotate("text",x=7.5,y=-0.5,label="G2",colour="black") +
		annotate("text",x=10,y=-0.5,label="B",colour="black") +
		annotate("text",x=15,y=-0.5,label="B'",colour="black") +
		annotate("text",x=-0.5,y=10,label="B",colour="black") +
		annotate("text",x=4.7,y=4.8,label="E",colour="black") +
		annotate("text",x=7.8,y=5.2,label="E'",colour="black") +
		annotate("segment",x=5,xend=5,y=0,yend=5,linetype="dashed") +
		annotate("segment",x=7.5,xend=7.5,y=0,yend=5,linetype="dashed") +
		annotate("segment",x=0,xend=0,y=0,yend=11) +
		annotate("segment",x=0,xend=16,y=0,yend=0) 

#demand curve for public goods 2
func <- function(x) 25/x
curve <- limitRange(func,2.5,10)
ggplot(data.frame(x=c(0,13)),aes(x)) + 
		stat_function(fun=curve,n=200) +
		annotate("text",x=5.5,y=7.5,label="demand curve for\npublic goods",colour="black") +
		annotate("text",x=0,y=10.5,label="tax price",colour="black") +
		annotate("text",x=11.5,y=-0.5,label="public",colour="black") +
		annotate("text",x=-0.5,y=-0.5,label="0",colour="black") +
		annotate("text",x=5,y=-0.5,label="G1",colour="black") +
		annotate("text",x=7.5,y=-0.5,label="G2",colour="black") +
		annotate("text",x=-0.5,y=5,label="p1",colour="black") +
		annotate("text",x=-0.5,y=10/3,label="p2",colour="black") +
		annotate("text",x=5.3,y=5.3,label="E",colour="black") +
		annotate("text",x=7.8,y=3.6,label="E'",colour="black") +
		annotate("segment",x=5,xend=5,y=0,yend=5,linetype="dashed") +
		annotate("segment",x=7.5,xend=7.5,y=0,yend=10/3,linetype="dashed") +
		annotate("segment",x=0,xend=5,y=5,yend=5,linetype="dashed") +
		annotate("segment",x=0,xend=7.5,y=10/3,yend=10/3,linetype="dashed") +
		annotate("segment",x=0,xend=0,y=0,yend=10) +
		annotate("segment",x=0,xend=12,y=0,yend=0) 

#marginal economic rate of transformation
func <- function(x) -(x^2)/10+10
func2 <- function(x) -2*(x^2)/5+10
curve <- limitRange(func,0,10)
curve2 <- limitRange(func2,0,5)
ggplot(data.frame(x=c(0,12)),aes(x)) + 
		stat_function(fun=curve,n=300) +
		stat_function(fun=curve2,n=1000) +
		annotate("text",x=2.5,y=2.5,label="feasibility curve",colour="black") +
		annotate("text",x=8,y=7.5,label="product possibilities curve",colour="black") +
		annotate("text",x=0,y=11.5,label="private",colour="black") +
		annotate("text",x=11.5,y=-0.5,label="public",colour="black") +
		annotate("text",x=-0.5,y=-0.5,label="0",colour="black") +
		annotate("segment",x=0,xend=0,y=0,yend=11) +
		annotate("segment",x=0,xend=12,y=0,yend=0) 