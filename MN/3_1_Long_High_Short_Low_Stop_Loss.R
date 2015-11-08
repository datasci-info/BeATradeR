##Long_High_Short_Low_Stop_Loss##

currenttime=proc.time()	## current time record

tx=read.table("tx.txt",header=TRUE,sep=',',
colClasses=c("NULL","character","character","integer"
,"integer","integer","integer","integer"))	## reading Data

tx=split(tx,factor(tx$Date,levels=unique(tx$Date),ordered=TRUE))	##Split Data

profit=setNames(numeric(length(tx)), names(tx))	## profit vector

SL=30		#Stop Loss Points
SP=5000	# No Stop Profit(or Stop 5000 profit)

last=5000

for (m in names(tx)){
	txToday=tx[[m]]
	todayTime=unique(txToday$Time)
	
	BS=sign(txToday$Open[1]-last)	##Open High is 1,open low is -1

	if (BS==1){long=txToday$Open[1]	##Long price
		j=1	

	while (txToday$High[j]<=long+SP && txToday$Low[j]>=long-SL && j<length(todayTime)){j=j+1}		
		if (j==length(todayTime)){profit[m]=txToday$Close[j]-long}			
		if (txToday$Low[j]<long-SL && j<length(todayTime)){profit[m]=-SL}		
		if (txToday$High[j]>long+SP && j<length(todayTime)){profit[m]=SP}		
	
	}else{short=txToday$Open[1]	##short price
	j=1

	while (txToday$Low[j]>=short-SP && txToday$High[j]<=short+SL && j<length(todayTime)){j=j+1} 	
		if (j==length(todayTime)){profit[m]=short-txToday$Close[j]}			
		if (txToday$High[j]>short+SL && j<length(todayTime)){profit[m]=-SL}		
		if (txToday$Low[j]<short-SP && j<length(todayTime)){profit[m]=SP}		
	}
last=tail(txToday$Close,1)
}

(spttime=proc.time()-currenttime)
########Perofrmance module#######

source("performance.R", encoding = 'BIG5',echo = FALSE)
performance(profit)