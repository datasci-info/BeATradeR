### 比較 凱利理論_凱利實際_最佳化比例實際_三者的差別  ##

source("6_Stop_no_Limit.R", encoding = 'BIG5',echo = FALSE) ### 需要輸入profit損益向量 ##	 

initM=150000		## 初始資金
loss=1500		## 策略最大停損

## 凱利理論
pwin=length(profit[profit>0])/length(profit[profit!=0])	##勝率
odds=mean(profit[profit>0])/abs(mean(profit[profit<0]))	##賠率,賭1元，贏了拿回1+odds元，輸了輸1元
KellyCap=rep(initM,1)		##記錄凱利理論的資金成長

kelly=(pwin*(1+odds)-1)/odds	##凱利比例

for (i in 2:length(profit)){
KellyCap[i]=KellyCap[i-1]*((1+kelly*odds)^pwin)*((1-kelly)^(1-pwin))
}

## 凱利實際
risk=kelly		##將凱利比例設為風險比例
KellyPL=rep(0,1)	##記錄凱利實際的每筆損益
capital=initM	##設定資金
PS=1
m=1			##第m天開始

while (PS>=1 && m<length(profit) ){PS=floor(capital*risk/loss)	##計算第m天的下單口數
KellyPL[m]=PS*profit[m]		##計算第m天的實際損益點數
capital=capital+KellyPL[m]*50	##計算目前的資金
m=m+1}

##最佳化比例實際

source("8_violent_optimal_f.R", encoding = 'BIG5',echo = FALSE)	##先計算最佳下注比例

risk=OptF			##將最佳化比例設為風險比例
OptPL=rep(initM,1)		##記錄最佳化比例實際的每筆損益
capital=initM		##設定資金
PS=1
m=1				##第m天開始

while (PS>=1 && m<length(profit) ){PS=floor(capital*risk/loss)	## 計算第m天的下單口數
OptPL[m]=PS*profit[m]		##計算第m天的實際損益點數
capital=capital+OptPL[m]*50	##計算目前的資金
m=m+1}

##畫出原始策略，凱利理論、凱利實際、最佳化實際損益圖
par(family="STKaiti") #Only for Mac
plot(initM+cumsum(profit)*50,type="h",col="lightgreen" ##畫原始策略損益
,ylim=c(0,max(KellyCap,KellyPL,OptPL))
,ylab="Profits",xlab="交易天數") 

par(new=T)

plot(KellyCap,type="l",lwd=3,col="red",font=2
,ylim=c(0,max(KellyCap,KellyPL,OptPL))
,ylab="Profits",xlab="交易天數"
,main="凱利理論(紅)_凱利實際(藍)_最佳化比例(紫)")	##畫凱利理論的資金成長曲線

par(new=T)

plot(initM+cumsum(KellyPL)*50,type="l",lwd=2,col="blue"
,ylim=c(0,max(KellyCap,KellyPL,OptPL))
,ylab="Profits",xlab="交易天數") ##畫凱利實際的資金成長曲線

par(new=T)

plot(initM+cumsum(OptPL)*50,type="l",lwd=2,col="purple"
,ylim=c(0,max(KellyCap,KellyPL,OptPL))
,ylab="Profits",xlab="交易天數") ##畫最佳化實際的資金成長曲線

abline(h=initM,col="black",lty=1,lwd=2)	##成本線

#source("performance.R")
