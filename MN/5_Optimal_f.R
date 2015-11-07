##給定損益向量，尋找最佳下注比例f

#PL=c(19,8,-7,10,11,5,-3,20,12,-15)	##給定益向量
PL=c(2,-1)
TWR=rep(0,100)	# 記錄每一個下注比例的平均報酬率(1%~100%)

for (f in 1:100){HPR=1	
	for (i in 1:length(PL)){HPR=HPR*(1+(f/100)*(-PL[i]/min(PL)))}	##計算下注f比例的報酬
TWR[f]=HPR^(1/length(PL))	##將計算出來的報酬率取幾何平均
}
par(family="STKaiti") #Only for Mac
plot(TWR,col="red",type="l",font=2,lwd=3,xlab="下注比例(%)"
,main="Optimal f",ylab="報酬率")

points(tail(order(TWR),1),max(TWR),col="blue",pch=16)


abline(h=1,col="green",lty=1,lwd=2)	##損益兩平線
abline(v=tail(order(TWR),1),col="blue",lty=1,lwd=1)	##最佳下注比例



text(tail(order(TWR),1)+20,max(TWR-0.3),labels=paste("當f=",tail(order(TWR),1),"%，發生最大值",max(TWR)))

