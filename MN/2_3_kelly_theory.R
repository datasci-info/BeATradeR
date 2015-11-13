pwin=0.3	## win rate
odds=3		## odds
nbet=40		## the numebr of bidding

PL=rep(1,nbet)	## profit vector

for (f in 1:100){	## all biddging fraction
PL[f]=((1+odds*f/100)^(nbet*pwin))*((1-f/100)^(nbet*(1-pwin)))
}			## the expectation growth of capital

plot (PL, type="l",col="red",xlab="The Bidding Fraction",ylab="The Growth Rate",font=2
,main=paste("Odds=",odds,", WinRate",pwin*100,"%",", ",nbet,"Games"),lwd=4)

abline(h=1,col="green",lty=1,lwd=2)	## drawing the inital capital
abline(v=(pwin*(1+odds)-1)*100/odds,col="blue",lty=2,lwd=2)	## drawing the kelly fraction 