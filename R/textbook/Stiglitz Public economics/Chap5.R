# TODO: Add comment
# 
# Author: harakonan
###############################################################################

#Atkinson's utility curve
a <- 1.5
curve(x^(1-a)/(1-a),0,10^8)
ggplot(data.frame(x=c(0,10^8)),aes(x)) + stat_function(fun=function(x) x^(1-a)/(1-a))

a <- seq(1.1,2.0,by=0.1)
curve(x^(1-a[1])/(1-a[1]),0,10^8,ylim=c(-3.0,0))
curve(x^(1-a[2])/(1-a[2]),0,10^8,add=TRUE)
for (i in 1:10){
	curve(x^(1-a[i])/(1-a[i]),0,10^8,ylim=c(-3,0),col=i,add=if (i == 1) FALSE else TRUE)
}

