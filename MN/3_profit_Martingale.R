source("2_open_random.R")

init=1000000	#初始資金
PS=1			##一開始下一口
capital=init		##目前資本
prem=25000		##保證金
m=1			##從第一天開始
PL=rep(0,1)		##每天PS後的損益向量

while (PS*prem<=capital && m<=length(profit)){	##資金大於該買的口數保鎮金

	if(profit[m]>0){		##這次贏
		PL[m]=PS*profit[m]    
		PS=1 			##贏的話下次下一口
	}else{      		##這次輸
		PL[m]=PS*profit[m]   
		PS=PS*2		##輸的話下次口數加倍
	}
	capital=capital+(PL[m]*50)	##計算第i+1次手上的籌碼
	m=m+1
}

profit=PL	##將馬丁格爾後的損益向量設為 profit向量，放進performance分析
source('performance.R', encoding = 'BIG5',echo = FALSE)
