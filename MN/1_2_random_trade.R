##Random Trade, StopLoss and Profit##

currenttime=proc.time()	## current time record

tx=read.table("tx.txt",header=TRUE,sep=',',
colClasses=c("NULL","character","character","integer"
,"integer","integer","integer","integer"))	## reading Data

tx=split(tx,factor(tx$Date,levels=unique(tx$Date),ordered=TRUE))	##Split Data

profit=setNames(numeric(length(tx)), names(tx))	## profit vector

SL=10	#Stop Loss Points
SP=10	#Stop Profit Points

for (m in names(tx)) {
	txToday=tx[[m]]
	todayTime=unique(txToday$Time)
	rd=sample(0:1,size=1,prob=c(0.5,0.5))	## Random Trade
	if (rd==1){long=txToday$Open[1]		## long price
		j=1					## the j minuts in m day

	while (txToday$High[j]<=long+SP && txToday$Low[j]>=long-SL && j<length(todayTime)){j=j+1} ##when stopLoss&Profit or Close			
		if (j==length(todayTime)){profit[m]=txToday$Close[j]-long}			##Close end (-SL<profit<30)
		if (txToday$Low[j]<long-SL && j<length(todayTime)){profit[m]=-SL}		##Stop Loss
		if (txToday$High[j]>long+SP && j<length(todayTime)){profit[m]=SP}		##Stop Profit
	
	}else{short=txToday$Open[1]	##short price
	j=1

	while (txToday$Low[j]>=short-SP && txToday$High[j]<=short+SL && j<length(todayTime)){j=j+1} 	 ##when stopLoss&Profit or Close			
		if (j==length(todayTime)){profit[m]=short-txToday$Close[j]}			##Close end (-SL<profit<30)
		if (txToday$High[j]>short+SL && j<length(todayTime)){profit[m]=-SL}		##Stop Loss
		if (txToday$Low[j]<short-SP && j<length(todayTime)){profit[m]=SP}		##Stop Loss
	}
}


(spttime=proc.time()-currenttime)

###performance module######

source('performance.R', encoding = 'BIG5',echo = FALSE)
performance(profit)