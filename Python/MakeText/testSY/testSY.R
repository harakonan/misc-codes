library(data.table)

?fread
testSY <- fread("~/Dropbox/Workspace/Python/MakeText/testSY.csv",header = F)
testSY <- copy(unique(testSY))
fwrite(testSY,"~/Dropbox/Workspace/Python/MakeText/testSYuni.csv")
