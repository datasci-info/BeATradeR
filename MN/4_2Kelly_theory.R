pwin=0.5	##勝率
odds=2		##賠率,賭1元，贏了拿回1+odds元，輸了輸1元
nbet=40		##賭的次數

PL=rep(1,nbet)	##損益向量

for (f in 1:100){	##計算各種下注比例
PL[f]=((1+odds*f/100)^(nbet*pwin))*((1-f/100)^(nbet*(1-pwin)))
}
par(family="STKaiti") #Only for Mac
plot (PL, type="l",col="red",xlab="押注比例",ylab="報酬率",
main=paste("賠率=",odds,", 勝率=",pwin*100,"%",", 押注次數",nbet),lwd=4)

abline(h=1,col="green",lty=1,lwd=2)	##損益兩平線
abline(v=(pwin*(1+odds)-1)*100/odds,col="blue",lty=1,lwd=1)	##最佳下注比例