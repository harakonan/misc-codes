library(ggplot2)

#function limitRange
limitRange <- function(fun,min,max){
    function(x){
        y <- fun(x)
        y[x<min | x>max] <- NA
        return(y)
    }
}

#Consumer Surplus
func <- function(x) -x+12
line <- limitRange(func,0,12)
shade <- data.frame(x=c(0,6,0),y=c(6,6,12))
ggplot(data.frame(x=c(-2,15)),aes(x)) + 
    stat_function(fun=line,n=200) +
    geom_polygon(data=shade,mapping=aes(x=x,y=y),alpha=0.3) +
    annotate("text",x=2,y=8,label=as.character(expression(CS[i])),size=7,parse=T,colour="black") +
    annotate("text",x=6,y=10,label="Demand curve of person i",colour="black") +
    annotate("text",x=0,y=13.5,label=as.character(expression(c[bi]-c[gi])),parse=T,colour="black") +
    annotate("text",x=13.5,y=-0.5,label=as.character(expression(S[bi])),parse=T,colour="black") +
    annotate("text",x=-0.5,y=-0.5,label="0",colour="black") +
    annotate("text",x=6,y=-0.5,label=as.character(expression(S[bi]^"*")),parse=T,colour="black") +
    annotate("text",x=-1,y=6,label=as.character(expression(c[bi]^"*"-c[gi]^"*")),parse=T,colour="black") +
    annotate("segment",x=0,xend=6,y=6,yend=6,linetype="dashed") +
    annotate("segment",x=6,xend=6,y=0,yend=6,linetype="dashed") +
    annotate("segment",x=0,xend=0,y=0,yend=13) +
    annotate("segment",x=0,xend=13,y=0,yend=0) 
