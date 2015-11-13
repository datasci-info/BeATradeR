##profit growth when bidding f##

nbet=40		## number of bidding
odds=2		## odds
pwin=0.5	## win rate
initM=1		## initial capital
f=0.3		## bidding fraction
dice=sample(0:1,size=nbet,prob=c(0.5,0.5),replace=T) ## gamble simulation

capital=rep(initM,1)  		## current capital

for(i in 2:nbet){	## running each game
capital[i]=dice[i-1]*capital[i-1]*f*(1+odds)+capital[i-1]*(1-f)} ## the growth of capital
par(mfcol=c(1,1))
plot(capital,type="l",col="red",lwd=4,font=2
,xlim=c(0,nbet),ylim=c(0,max(capital))
,xlab="The # of Bidding",ylab="The Growth of Capital"
,main=paste("WinRate",pwin*100,"%,","Odds",odds,", Play",nbet,"Games, "
,"Bidding",f*100,"%"))

abline(h=initM,col="green",lty=2,lwd=3)
