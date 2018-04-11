# TODO: Add comment
# 
# Author: harakonan
###############################################################################


cube <- function(x, n){
	x^3
}
cube(3) #1

x <- 1:10
for(i in 1:10){
	if(x[i] > 5){ #if‚ÉƒXƒJƒ‰[‚Í“ü‚ê‚ç‚ê‚È‚¢
		x[i] <- 0
	}
}
x #2

f <- function(x) {
	g <- function(y) {
		y + z
	}
	z <- 4
	x + g(x)
}
z <- 10
f(3) #3

x <- 5
y <- if(x < 3) {
	NA
} else {
	10
}
y

x=3L #L‚Åinteger‚É‚È‚é
x
class(x)