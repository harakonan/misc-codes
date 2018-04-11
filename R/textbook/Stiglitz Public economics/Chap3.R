# TODO: ƒRƒƒ“ƒg‚Ì’Ç‰Á
# 
# ì¬Ò: harakonan
###############################################################################
setwd("/Users/harakonan/Documents/workspace/Stiglitz Public economics")

#7
indif <- data.frame(public=seq(1,6,by=1),private=c(16,11,7,4,3,2),attr="indif")
library(ggplot2)
ggplot(indif,aes(x=public,y=private)) + geom_line() + geom_point()
prob <- data.frame(public=seq(0,6,by=1),private=seq(12,0,by=-2),attr="prob")
ggplot(prob,aes(x=public,y=private)) + geom_line() + geom_point()
bind <- rbind(indif,prob)
ggplot(bind,aes(x=public,y=private,linetype=attr)) + geom_line() + geom_point()
ggsave("Chap3Q7.pdf", width=12, height=12, units="cm")
