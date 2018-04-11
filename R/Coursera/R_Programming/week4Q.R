# TODO: Add comment
# 
# Author: harakonan
###############################################################################

set.seed(1)
rpois(5, 2)#1

rnorm(10)
dnorm(0.1)
qnorm(0.1)
normd <- function(x) dnorm(x, sd = 10)
normp <- function(x) pnorm(x, sd = 10)
normq <- function(y) qnorm(y, sd = 10)
plot(normd, -20, 20)
plot(normp, -20, 20)
plot(normq, 0, 1)
#4‚ÉŠÖ‚µ‚Ä‚»‚ê‚¼‚êƒOƒ‰ƒt‚ðì¬‚µ‚½

set.seed(10)
x <- rbinom(10, 10, 0.5)
e <- rnorm(10, 0, 20)
y <- 0.5 + 2 * x + e
plot(x, y)#5