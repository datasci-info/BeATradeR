##開盤隨機交易，10點停損，10點停利

tx=read.csv("tx.txt")#讀檔
tx=tx[,-1]

allDate=unique(tx$Date)#交易日期的向量
profit=rep(0,1)	#損益向量

SL=10	#停損10點
SP=10	#停利10點

for (m in 1:length(allDate)) {
	txToday=tx[tx$Date==allDate[m],]
	todayTime=unique(txToday$Time)
	rd=sample(0:1,size=1,prob=c(0.5,0.5))##丟銅板隨機買賣
	if (rd==1){long=txToday$Open[1]	##開盤買進價位
		j=1	##第m天的第1分鐘

	while (txToday$High[j]<=long+SP && txToday$Low[j]>=long-SL && j<length(todayTime)){j=j+1}##check先到停損還是停利，還是收盤平倉			
		if (j==length(todayTime)){profit[m]=txToday$Close[j]-long}			##試單收盤平倉 (-SL<損益<30)
		if (txToday$Low[j]<long-SL && j<length(todayTime)){profit[m]=-SL}		##試單停損
		if (txToday$High[j]>long+SP && j<length(todayTime)){profit[m]=SP}		##試單停損
	
	}else{short=txToday$Open[1]	##開盤賣出價位
	j=1

	while (txToday$Low[j]>=short-SP && txToday$High[j]<=short+SL && j<length(todayTime)){j=j+1} 	##check先到停損還是停利，還是收盤平倉			
		if (j==length(todayTime)){profit[m]=short-txToday$Close[j]}			##試單收盤平倉 (-SL<損益<30)
		if (txToday$High[j]>short+SL && j<length(todayTime)){profit[m]=-SL}		##試單停損
		if (txToday$Low[j]<short-SP && j<length(todayTime)){profit[m]=SP}		##試單停損
	}
}

###############績效模組#######

source('performance.R', encoding = 'BIG5',echo = FALSE)
