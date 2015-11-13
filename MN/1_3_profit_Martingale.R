source("1_2_random_trade.R")

init=1000000	## inital money
PS=1		## 1 contract for new position
capital=init	## current money
prem=25000	## premium
m=1		## the m days of trading
PL=rep(0,1)	## profit vector after martingale

while (PS*prem<=capital && m<=length(profit)){	## requirement for trading

	if(profit[m]>0){		
		PL[m]=PS*profit[m]    	## the PS profit if win
		PS=1 			## if win, 1 contract next time
	}else{      		
		PL[m]=PS*profit[m]   
		PS=PS*2			##if lose, double contract
	}	
capital=capital+(PL[m]*50)	## update current money
m=m+1}

#### Performance Module ###

source('performance.R')
par(mfrow=c(1,2))
performance(profit)
performance(PL)