###固定分數(Fixed Fraction)###
###需要輸入profit損益向量###

source("6_Stop_no_Limit.R", encoding = 'BIG5',echo = FALSE) ### 需要輸入profit損益向量 ##	 

initM=150000		##初始資金

capital=initM	##現有資金
delta=30000
risk=0.02		##風險比例

FixedRat=rep(0,length(profit))
m=1			##第m天開始
PS=1

while (PS>=1 && m<length(profit)){
	if (capital<initM){PS=1}else{
	PS=floor((1+(1+8*(capital-initM)/delta)^0.5)/2)}	## 計算第m天的下單口數
capital=capital+PS*profit[m]*50				## 計算第m天的資金
FixedRat[m]=PS*profit[m]
m=m+1}

###############績效模組#######
source("performance Fun.R", encoding = 'BIG5',echo = FALSE)
par(mfrow=c(1,2))
performance(profit)
performance(FixedRat)
