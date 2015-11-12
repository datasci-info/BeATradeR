num=1000			## number of bidding
init=100			## initial # of chip
capital=init 		## current # of chip
PL=rep(0,1)			## the profit vector of the game
i=1			

bid=1				## bidding 1 chip when winning

while (capital>=bid && i<=num){	## the requirement of bidding on the table
rout=sample(0:1,size=1,prob=c(19/37,18/37),replace=T)	##rouletee simulation

	if(rout==1){PL[i]=bid	## win "bid" chips
	bid=1	 		## bidding 1 chip in the next game
	}else{PL[i]=-bid    	## lossing "bid" chips
	bid=bid*2}		## double bid
	
capital=capital+PL[i]		## the capital 
i=i+1}				## go to the next game


plot(init+cumsum(PL),lwd=3,font=2,type="l",col="red"
,xlab="The # of Bidding",ylab="Cumulative Chips",main="Martingale")
abline(h=init,col="green",lwd=2)