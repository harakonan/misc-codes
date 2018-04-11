# TODO: Add comment
# 
# Author: harakonan
###############################################################################

hundredballs <- c(rep("red", 25), rep("black", 75))
s <- sample(hundredballs, 15, replace = TRUE)
length(s[s == "red"])
##sampling and count how many "red"s

hundredballs <- c(rep("red", 25), rep("black", 75))
ballsamples <- vector()
for (i in 1:20){
	s <- sample(hundredballs, 15, replace = TRUE)
	ballsamples[i] <- length(s[s == "red"])
}
ballsamples
##sampling 20 times 15 balls from hundred balls

rbinom(20, 15, prob=0.25)
##this does same as above

b <- binom.test(3, 15, p = 0.25)
b$conf.int##extract confidence interval(this sample's "red" is 3 times)
b$conf.int[1]
c(3, b$conf.int[1], b$conf.int[2])
##tabulate result & confidence interval

binom.conf <- function(x, y, p = 0.5){
	b <- binom.test(x, y, p = p)
	b$conf.int
}
##function outputs confidence interval of binomial distribution
binom.conf(3, 15, p = 0.25)

binom.conf <- function(x, y, p = 0.5, conf.level = 0.95){
	b <- binom.test(x, y, p = p, conf.level = conf.level)
	c(x/y, b$conf.int[1], b$conf.int[2])
}
##function outputs tablulated result & confidence interval
binom.conf(3, 15, p = 0.25)

ballsamples <- rbinom(20, 15, prob = 0.25)
binom.conf <- function(x, y, p = 0.5, conf.level = 0.95){
	b <- binom.test(x, y, p = p, conf.level = conf.level)
	c(x/y, b$conf.int[1], b$conf.int[2])
}
databi <- t(sapply(ballsamples, function(x) binom.conf(x, 15, p = 0.25)))
head(databi)
##data table to plot

plotCI <- function(table, prob = prob, las = 0, xlab = "", ylab = "", pch = 1){
	plot(1:nrow(table), table[, 1], ylim = c(min(table), max(table)), type = "p"
			, axes = F, xlab = xlab, ylab = ylab, pch = pch)
	axis(1, 1:nrow(table), rownames(table), las = las)
	axis(2, las = las)
	box()
	arrows(1:nrow(table), table[, 2], 1:nrow(table), table[, 3]
			, length = 0.05, angle = 90, code = 3, col = "grey")
	abline(h = prob, lty = 2)
}
##plot the result & error bar
plotCI(databi, prob = 0.25)

samplingbinomCI <- function(a, b, prob = 0.5, conf.level = 0.95, ...){
	samples <- rbinom(a, b, prob = prob)
	binom.conf <- function(x, y, p = 0.5, conf.level = 0.95){
		b <- binom.test(x, y, p = p, conf.level = conf.level)
		c(x/y, b$conf.int[1], b$conf.int[2])
	}
	databi <- t(sapply(samples, function(x)
						binom.conf(x, b, p = prob, conf.level = conf.level)))
	plotCI(databi, prob = prob, ...)
}
##a=number of observations, b=number of trials
##prob=probability of success on each trial
##conf.level=confidence level of CI
##...=assign values to plotCI function 
samplingbinomCI(100, 30)
samplingbinomCI(100, 30, prob = 0.25)
samplingbinomCI(100, 30, prob = 0.25, conf.level = 0.9)

ballsamples <- rbinom(20, 15, prob = 0.25)
binom.conf.test <- function(x, y, p = 0.5, conf.level = 0.95){
	b <- binom.test(x, y, p = p, conf.level = conf.level)
	!(p < b$conf.int[1] || p > b$conf.int[2])
}
databi.test <- sapply(ballsamples, function(x) binom.conf.test(x, 15, p = 0.25))
head(databi.test)
sum(databi.test)/length(databi.test)
##test the confidence level

binom.conf.test <- function(x, y, p = 0.5, conf.level = 0.95){
	b <- binom.test(x, y, p = p, conf.level = conf.level)
	!(p < b$conf.int[1] || p > b$conf.int[2])
}
testingbinomCI <- function(a, b, prob = 0.5, conf.level = 0.95){
	samples <- rbinom(a, b, prob = prob)
	databi.test <- sapply(samples, function(x)
				binom.conf.test(x, b, p = prob, conf.level = conf.level))
	sum(databi.test)/length(databi.test)
}
##testing confidence level
##values are identical to samplingbinomCI function
testingbinomCI(20, 15, prob = 0.25)

testbinomtab <- vector()
for (i in 1:20){
	testbinomtab[i] <- testingbinomCI(20, 15, prob = 0.25)
}
mean(testbinomtab)
##testing for many times and calculate the mean

binom.conf.test <- function(x, y, p = 0.5, conf.level = 0.95){
	b <- binom.test(x, y, p = p, conf.level = conf.level)
	!(p < b$conf.int[1] || p > b$conf.int[2])
}
testingbinomCI <- function(a, b, prob = 0.5, conf.level = 0.95){
	samples <- rbinom(a, b, prob = prob)
	databi.test <- sapply(samples, function(x)
				binom.conf.test(x, b, p = prob, conf.level = conf.level))
	sum(databi.test)/length(databi.test)
}
multtestbinomCI <- function(n, a, b, prob = 0.5, conf.level = 0.95){
	testbinomtab <- vector()
	for (i in 1:n){
		testbinomtab[i] <- testingbinomCI(a, b, prob = prob, conf.level = conf.level)
	}
	mean(testbinomtab)
}
##n=number of testing confidence level
multtestbinomCI(100, 25, 15, prob = 0.25)
multtestbinomCI(100, 25, 15, prob = 0.25, conf.level = 0.50)
multtestbinomCI(100, 25, 15, prob = 0.25, conf.level = 0.75)
multtestbinomCI(100, 25, 15, prob = 0.25, conf.level = 0.90)
multtestbinomCI(100, 25, 15, prob = 0.25, conf.level = 0.99)
multtestbinomCI(100, 25, 15)
multtestbinomCI(100, 25, 15, conf.level = 0.90)
multtestbinomCI(100, 25, 15, conf.level = 0.99)
multtestbinomCI(100, 100, 30, prob = 0.25)
multtestbinomCI(100, 100, 30, prob = 0.25, conf.level = 0.90)
multtestbinomCI(100, 100, 30, prob = 0.25, conf.level = 0.99)
