###尋找 策略實際最佳下注f ###
###需要 profit損益向量  ###

initM=150000		##初始資金
loss=1500			##策略最大停損
F=seq(0.0001,0.20,by=0.0001)
capital=rep(initM,length(F))	##不同下注比例的資金記錄
k=1

for (risk in F){	##風險比例

PS=1			##下單口數
m=1			##第m天

while (PS>=1 && m<length(profit) ){		
PS=floor(capital[k]*risk/loss)		## 計算第m天的下單口數
capital[k]=capital[k]+PS*profit[m]*50	## 計算第m天的資金損益
m=m+1
}

k=k+1
}

###############績效模組#######
par(family="STKaiti")
plot(capital,type="h",lwd=5,font=2,col="pink"
,main="不同資金比例的最後損益",xlab="下注百分比(%)",ylab="損益",xaxt="n")

axis(1, 1:length(F),F,font=2,col.axis="black",lwd=1)

abline(h=initM,col="green",lty=1,lwd=2)	##損益兩平線

OptF=tail(order(capital),1)/10000

