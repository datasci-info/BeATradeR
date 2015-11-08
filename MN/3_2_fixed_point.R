### Fixed Fraction ###
### Input profit vector ##

source("3_1_Long_High_Short_Low_Stop_LossR", encoding = 'BIG5',echo = FALSE)

initM=150000	## initial money
loss=1500	## the stop loss of the strategy
capital=initM	## current money
risk=0.02	## risk fraction 

FixedFra=rep(0,length(profit))	## the profit vector after PS
PS=1; m=1			## the m days

while(PS>=1 && m<=length(profit)){	## the requirement for trading
PS=floor(capital*risk/loss)		## the number of contract for fixed fraction
capital=capital+PS*profit[m]*50		## the capital of the m days after PS
FixedFra[m]=PS*profit[m]		## the profit of the m days after PS
m=m+1}

### performance module ###
source("performance.R", encoding = 'BIG5',echo = FALSE)
par(mfcol=c(1,2))
performance(profit)
performance(FixedFra)