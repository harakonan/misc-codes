library(ggplot2)

#function limitRange
limitRange <- function(fun,min,max){
    function(x){
        y <- fun(x)
        y[x<min | x>max] <- NA
        return(y)
    }
}

#question 10
func <- function(x) -x+10
func2 <- function(x) -x+12
func3 <- function(x) 25/x
func4 <- function(x) 36/x
line <- limitRange(func,0,10)
line2 <- limitRange(func2,0,12)
curve <- limitRange(func3,2.5,11)
curve2 <- limitRange(func4,3.8,11)
ggplot(data.frame(x=c(0,15)),aes(x)) + 
    stat_function(fun=line,n=200) +
    stat_function(fun=line2,n=200) +
    stat_function(fun=curve,n=200) +
    stat_function(fun=curve2,n=200) +
    annotate("text",x=12,y=1,label="budget constraint line",colour="black") +
    annotate("text",x=5,y=10,label="indifference curve",colour="black") +
    annotate("text",x=0,y=13.5,label="C2",colour="black") +
    annotate("text",x=13.5,y=-0.5,label="C1",colour="black") +
    annotate("text",x=-0.5,y=-0.5,label="0",colour="black") +
    annotate("text",x=5,y=-0.5,label="c1",colour="black") +
    annotate("text",x=6,y=-0.5,label="c1'",colour="black") +
    annotate("text",x=-0.5,y=5,label="c2",colour="black") +
    annotate("text",x=-0.5,y=6,label="c2'",colour="black") +
    annotate("text",x=11,y=-0.5,label="w",colour="black") +
    annotate("text",x=-1,y=11,label="w(1+r)",colour="black") +
    annotate("segment",x=5,xend=5,y=0,yend=5,linetype="dashed") +
    annotate("segment",x=6,xend=6,y=0,yend=6,linetype="dashed") +
    annotate("segment",x=0,xend=5,y=5,yend=5,linetype="dashed") +
    annotate("segment",x=0,xend=6,y=6,yend=6,linetype="dashed") +
    annotate("segment",x=0,xend=0,y=0,yend=13) +
    annotate("segment",x=0,xend=13,y=0,yend=0) 