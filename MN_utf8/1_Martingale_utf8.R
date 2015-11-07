num=1000			##最多玩的局數
init=100			##初始籌碼個數
capital=init 	##目前籌碼個數
PL=rep(0,1)		##PL[i]玩第i局的損益(籌碼個數)
i=1				##賭第i局

rout=sample(0:1,size=1,prob=c(19/37,18/37),replace=T)	##模擬輪盤輸贏
bid=1			##一開始賭1枚

while (capital>=bid && i<=num){	##只要手上籌碼>要賭籌碼，且賭局還沒結束就進入迴圈
rout=sample(0:1,size=1,prob=c(19/37,18/37),replace=T)##輪盤輸贏模擬

	if(rout==1){PL[i]=bid		##這次贏，贏bid枚籌碼
	bid=1	 				##贏的話下次賭1枚
	}else{PL[i]=-bid    		##這次輸，輸bid枚籌碼
	bid=bid*2}				##輸的話下次賭加倍
	
capital=capital+PL[i]		##計算第i+1次手上的籌碼
i=i+1}					##準備玩第i局，回去while迴圈
par(family="STKaiti") #Only for Mac
plot(init+cumsum(PL),lwd=3,font=2,type="l",col="red"
,xlab="下注次數",ylab="累計籌碼數",main="輪盤馬丁")
abline(h=init,col="green",lwd=2)