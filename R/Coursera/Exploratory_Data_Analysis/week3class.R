# TODO: Add comment
# 
# Author: harakonan
###############################################################################

#Hierarchial Clustering
set.seed(1234)
par(mar=c(0,0,0,0))
x <- rnorm(12,mean=rep(1:3,each=4),sd=0.2)
y <- rnorm(12,mean=rep(c(1,2,1),each=4),sd=0.2)
plot(x,y,col="blue",pch=19,cex=2)
text(x+0.05,y+0.05,labels=as.character(1:12))

dataFrame <- data.frame(x=x,y=y)
distxy <- dist(dataFrame)
hClustering <- hclust(distxy)
plot(hClustering)
head(hClustering)
names(hClustering)

myplclust <- function(hclust, lab=hclust$labels,lab.col=rep(1,length(hclust$labels)),hang=0.1,...){
	y <- rep(hclust$height,2)
	x <- as.numeric(hclust$merge)
	y <- y[which(x<0)]
	x <- x[which(x<0)]
	x <- abs(x)
	y <- y[order(x)]
	x <- x[order(x)]
	plot(hclust,labels=F,hang=hang,...)
	text(x=x,y=y[hclust$order] - (max(hclust$height)*hang),labels=lab[hclust$order],col=lab.col[hclust$order],srt=90,adj=c(1,0.5),xpd=NA,...)
}

myplclust(hClustering,lab=rep(1:3,each=4),lab.col=rep(1:3,each=4))

set.seed(143)
dataMatrix <- as.matrix(dataFrame)[sample(1:12),]
heatmap(dataMatrix)

kmeansObj <- kmeans(dataFrame, centers = 3)
names(kmeansObj)
kmeansObj$cluster
plot(x, y, col=kmeansObj$cluster, pch=19, cex=2)
points(kmeansObj$centers, col=1:3, pch=3, cex=3)

set.seed(12345)
dataMatrix <- matrix(rnorm(400), nrow=40)
image(1:10, 1:40, t(dataMatrix)[, nrow(dataMatrix):1])
heatmap(dataMatrix)

set.seed(678910)
for (i in 1:40){
    coinFlip <- rbinom(1, size=1, prob=0.5)
    if (coinFlip){
        dataMatrix[i, ] <- dataMatrix[i, ] + rep(c(0,3), each=5)
    }
}
image(1:10, 1:40, t(dataMatrix)[, nrow(dataMatrix):1])
heatmap(dataMatrix)

hh <- hclust(dist(dataMatrix))
dataMatrixOrdered <- dataMatrix[hh$order,]
par(mar=c(4,4,2,2))
par(mfrow=c(1,1))
image(t(dataMatrixOrdered)[,nrow(dataMatrixOrdered):1])
plot(rowMeans(dataMatrixOrdered), 40:1, , xlab="Row Mean", ylab="Row", pch=19)
plot(colMeans(dataMatrixOrdered), xlab="Column", ylab="Column Mean", pch=19)

