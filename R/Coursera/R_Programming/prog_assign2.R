# TODO: Add comment
# 
# Author: harakonan
###############################################################################

makeVector <- function(x = numeric()) {
	m <- NULL
	set <- function(y) {
		x <<- y
		m <<- NULL
		x
	}
	get <- function() x
	setmean <- function(mean) m <<- mean
	getmean <- function() m
	list(set = set, get = get,
			setmean = setmean,
			getmean = getmean)
}

cachemean <- function(x, ...) {
	m <- x$getmean()
	if(!is.null(m)) {
		message("getting cached data")
		return(m)
	}
	data <- x$get()
	m <- mean(data, ...)
	x$setmean(m)
	m
}

x <- rnorm(10)
mx <- makeVector(x)#特殊なVectorを用意する
#cachemean(makeVector(x))ではうまく行かない
#mに毎回新たにNULLが代入されてしまうから
cachemean(mx)
cachemean(mx)#繰り返すとcacheから呼び出してくれる

y <- c(1, NA, 3, 4)
my <- makeVector(y)
cachemean(my, na.rm = TRUE)#NAを除くこともできる

x <- matrix(c(1,2,3,4), 2, 2)
solve(x)#逆行列
det(x)#デターミナント

makeCacheMatrix <- function(x = matrix()){
	s <- NULL
	set <- function(y){
		x <<- y
		s <<- NULL
	}
	get <- function() x
	setsolve <- function(solve) s <<- solve
	getsolve <- function() s
	list(set = set, get = get, setsolve = setsolve, getsolve = getsolve)
}

cacheSolve <- function(x, ...){
	s <- x$getsolve()
	if(!is.null(s)){
		message("getting cached data")
		return(s)
	}
	data <- x$get()
	s <- solve(data, ...)
	x$setsolve(s)
	s
}
#完成
#...は必要ない気もする
mtx <- matrix(c(1,2,3,4), 2, 2)
mmtx <- makeCacheMatrix(mtx)
cacheSolve(mmtx)
cacheSolve(mmtx)