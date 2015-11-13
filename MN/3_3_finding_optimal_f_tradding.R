##finding_the_optimal_f_for_gamblig##

###input profit vector  ###
source("3_1_Long_High_Short_Low_Stop_Loss.R")

initM=150000		## initial money
loss=1500		## the stop loss of the original strategy
F=seq(0.01,1,by=0.002)	## risk fraction
capital=rep(initM,length(F))	## the capital for all risk fraction
k=1

for (risk in F){	## run all risk fraction
PS=1;m=1		## the m days

	while (PS>=1 && m<=length(profit) ){ 	## the requirement for trading		
	PS=floor(capital[k]*risk/loss)		## the number of contract with risk fraction
	capital[k]=capital[k]+PS*profit[m]*50	## the capital in the m days
	m=m+1}

k=k+1}

OptF=F[1]+0.002*(tail(order(capital),1)-1)	## fing the optimal risk fraction

### performance module ###

plot(capital[1:50],type="h",lwd=5,font=2,col="red"
,main=paste("OptimalRiskFraction",OptF*100,"%"),xlab="Risk Fraction (%)"
,ylab="Capital",xaxt="n")

axis(1, 1:length(F),F,font=2,col.axis="black",lwd=2)

abline(h=initM,col="green",lty=1,lwd=2)				
abline(v=tail(order(capital),1),col="blue",lty=2,lwd=2)	## Optimal Risk Fraction


