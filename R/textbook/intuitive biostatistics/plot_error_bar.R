# TODO: Add comment
# 
# Author: harakonan
###############################################################################

x <- 1:10
y <- 1:10
plot(x, y)
##scatter plot
plot(x, y, pch=2)
##triangle plot

plot(x, y, axes=F)##delete axes
axis(2,1:10)##y-axis = 1 to 10
axis(1,1:10,LETTERS[1:10])## x-axis = A to J
box()##look graph as usual type

plot(x, y, xlim = c(10, 1))
##xlim is range
plot(x, y, xlab="X-Label",ylab="Y-Label")
##set label's name
plot(x, y, xlab="X-Label",ylab="Y-Label", las=1)
##set label horizontal

plot(x, y)
arrows(1:10, y-1, 1:10, y+1)##write arrows from y-1 to y+1
plot(x, y)
arrows(1:10, y-1, 1:10, y+1, code=3)##write double arrow
plot(x, y)
arrows(1:10, y-1, 1:10, y+1, angle=90, code=3)##change arrows to error bars
plot(x, y, ylim=c(0,11))
arrows(1:10, y-1, 1:10, y+1, length=0.05, angle=90, code=3, col="grey")
##change bar thinner and grey

plot(sin,-pi,2*pi)
##plot function. plot(function,min,max)

x <- rnorm(10)
plot(x, type="l")
##plot line graph

plotCI <- function(table, las = 0, xlab = "", ylab = "", pch = 1){
	plot(1:nrow(table), table[, 1], ylim = c(min(table), max(table)), type = "p"
	, axes = F, xlab = xlab, ylab = ylab, pch = pch)
	axis(1, 1:nrow(table), rownames(table), las = las)
	axis(2, las = las)
	box()
	arrows(1:nrow(table), table[, 2], 1:nrow(table), table[, 3]
	, length = 0.05, angle = 90, code = 3, col = "grey")
}
##plot point with error bar (confidence interval)