##開高買開低賣30點停損不停利

tx=read.csv("tx.txt")#讀檔
tx=tx[,-1]

allDate=unique(tx$Date)#交易日期的向量
profit=rep(0,1)	#損益向量

SL=30		#停損30點
SP=5000	#不停利(5000點才停利)
last=tx[tx$Date==allDate[1],]$Open[1]	##先寄錄第一天的收盤價

for (m in 2:length(allDate)) {
	txToday=tx[tx$Date==allDate[m],]
	todayTime=unique(txToday$Time)

	BS=sign(txToday$Open[1]-last)	##開高設為1,開低設為-1

	if (BS==1){long=txToday$Open[1]	##開高買進
		j=1	##第m天的第1分鐘

	while (txToday$High[j]<=long+SP && txToday$Low[j]>=long-SL && j<length(todayTime)){j=j+1}##先到停損還是停利，收盤平倉			
		if (j==length(todayTime)){profit[m]=txToday$Close[j]-long}			##收盤平倉 (-SL<損益<30)
		if (txToday$Low[j]<long-SL && j<length(todayTime)){profit[m]=-SL}		##停損
		if (txToday$High[j]>long+SP && j<length(todayTime)){profit[m]=SP}		##停損
	
	}else{short=txToday$Open[1]	##開低賣出
	j=1

	while (txToday$Low[j]>=short-SP && txToday$High[j]<=short+SL && j<length(todayTime)){j=j+1} 	##check先到停損還是停利，收盤平倉	
		if (j==length(todayTime)){profit[m]=short-txToday$Close[j]}			##收盤平倉 (-SL<損益<30)
		if (txToday$High[j]>short+SL && j<length(todayTime)){profit[m]=-SL}		##停損
		if (txToday$Low[j]<short-SP && j<length(todayTime)){profit[m]=SP}		##停損
	}
last=tail(txToday$Close,1)	##記錄今天收盤價
}

###############績效模組#######

source("performance.R", encoding = 'BIG5',echo = FALSE)
