###固定分數(Fixed Fraction)###
### 輸入 profit 損益向量###

source("6_Stop_no_Limit.R", encoding = 'BIG5',echo = FALSE)

initM=150000	##初始資金
loss=1500		##策略最大停損
capital=initM	##現有資金
risk=0.02		##風險比例

FixedFra=rep(0,length(profit))	##固定分數每筆損益點數
PS=1
m=1			##第m天開始

while(PS>=1 && m<=length(profit)){
PS=floor(capital*risk/loss)		## 計算第m天的下單口數
capital=capital+PS*profit[m]*50	## 計算第m天的資金
FixedFra[m]=PS*profit[m]
m=m+1}

###############績效模組#######
source("performance Fun.R", encoding = 'BIG5',echo = FALSE)
par(mfcol=c(1,2))
performance(profit)
performance(FixedFra)