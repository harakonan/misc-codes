# TODO: Add comment
# 
# Author: harakonan
###############################################################################

n <- 100
sample <- rnorm(n)
m <- mean(sample)
s <- sd(sample)
normCIdif <- qnorm(0.975)*s/sqrt(n)
normCI <- c(m-normCIdif, m+normCIdif)
normCI
##95%CI from normal distribution

n <- 100
sample <- rnorm(n)
m <- mean(sample)
s <- sd(sample)
tCIdif <- qt(0.975, df = n-1)*s/sqrt(n)
tCI <- c(m-tCIdif, m+tCIdif)
tCI
##95%CI from t-distribution

n <- 100
sample <- rnorm(n)
m <- mean(sample)
resamplenum <- 100
meanresample <- vector()
for (i in 1:resamplenum){
	meanresample[i] <- mean(sample(sample, n, replace = T))
}
quantile(meanresample, probs=c(0.025, 0.975))
##95%CI from bootstrapping

norm.conf.test <- function(n, mean = 0, sd = 1, conf.level = 0.95){
	sample <- rnorm(n, mean = mean, sd = sd)
	m <- mean(sample)
	s <- sd(sample)
	normCIdif <- qnorm((1+conf.level)/2)*s/sqrt(n)
	normCI <- c(m-normCIdif, m+normCIdif)
	mean > normCI[1] && mean < normCI[2]
}
##calculate 95%CI from normal distribution 
##and assess whether 95%CI include the population mean
t.conf.test <- function(n, mean = 0, sd = 1, conf.level = 0.95){
	sample <- rnorm(n, mean = mean, sd = sd)
	m <- mean(sample)
	s <- sd(sample)
	tCIdif <- qt((1+conf.level)/2, df = n-1)*s/sqrt(n)
	tCI <- c(m-tCIdif, m+tCIdif)
	mean > tCI[1] && mean < tCI[2]
}
##calculate 95%CI from t distribution and assess same as above
bootstrap.conf.test <- function(rn, n, mean = 0, sd = 1, conf.level = 0.95){
	sample <- rnorm(n, mean = mean, sd = sd)
	m <- mean(sample)
	meanresample <- vector()
	for (i in 1:rn){
		meanresample[i] <- mean(sample(sample, n, replace = T))
	}
	bootCI <- quantile(meanresample, probs=c((1-conf.level)/2, (1+conf.level)/2))
	mean > bootCI[1] && mean < bootCI[2]
}
##calculate 95%CI from bootstrapping and assess same as above
##rn=number of resampling for bootstrapping
testCI <- function(m, rn, n, mean = 0, sd = 1, conf.level = 0.95){
	CI.test <- list()
	CI.test1 <- vector()
	CI.test2 <- vector()
	CI.test3 <- vector()
	for (i in 1:m){
		CI.test1[[i]] <- norm.conf.test(n, mean = mean, sd = sd, conf.level = conf.level)
		CI.test2[[i]] <- t.conf.test(n, mean = mean, sd = sd, conf.level = conf.level)
		CI.test3[[i]] <- bootstrap.conf.test(rn, n, mean = mean, sd = sd, conf.level = conf.level)
	}
	CI.test[[1]] <- CI.test1
	CI.test[[2]] <- CI.test2
	CI.test[[3]] <- CI.test3
	CI.result <- sapply(CI.test, sum)/sapply(CI.test, length)
	names(CI.result) <- c("norm", "t", "bootstrap")
	CI.result
}
##display the result of testing CIs
##CIs are calculated from three methods
##m=number of sampling CI
##rn=number of resampling for bootstrapping
##n=number of sampling from population
##mean/sd=population mean/sd
testCI(1000, 100, 100)
testCI(1000, 500, 100)
testCI(1000, 100, 100, conf.level = 0.90)
testCI(1000, 100, 100, conf.level = 0.99)
testCI(1000, 100, 100, mean = 10, sd = 10)
testCI(1000, 100, 100, mean = 10, sd = 10, conf.level = 0.90)