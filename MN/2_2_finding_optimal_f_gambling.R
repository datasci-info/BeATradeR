##finding_the_optimal_f_for_gamblig##

nbet=50	## number of bidding
odds=2		## odds
pwin=0.5	## win rate
initM=1		## initial capital

Fcapital=rep(0,100);k=1			## The profit when bidding f
dice=sample(0:1,size=nbet,prob=c(0.5,0.5),replace=T)	## Gamble Simulation

for (f in seq(0.01,0.99,by=0.01)){	## all bidding fraction
capital=rep(initM,1)  			## current capital

	for(i in 2:nbet){
	capital[i]=dice[i]*capital[i-1]*f*(1+odds)+capital[i-1]*(1-f)} 	## capital when bidding f  

Fcapital[k]=capital[nbet];k=k+1}		

plot(Fcapital,type="h",col="red",lwd=2,font=2
,xlab="The Bidding Fraction (%)",ylab="Capital"
,main=paste("WinRate",pwin*100,"%,","Odds",odds,", ",nbet,"Games, "
,"Optimal f",tail(order(Fcapital),1),"%"))

abline(h=initM,col="green",lty=2,lwd=3)
abline(v=tail(order(Fcapital),1),col="blue",lty=2,lwd=2)

