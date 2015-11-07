### 畫損益圖 and 策略績效模組 ### INPUT profit5 向量

performance=function (profit){

DD=rep(0,length(profit))	##累計虧損向量
topprofit=rep(profit[1],length(profit))	##最大獲利

for (m in 2:length(profit)){
	if (sum(profit[1:m])>topprofit[m-1]){
	topprofit[m:length(profit)]=sum(profit[1:m])}##如果創新高，將資產新高設為topprofit

	DD[m]=sum(profit[1:m])-topprofit[m]	##計算目前的連續虧損
}



plot(DD,type="h",col="darkgreen",lwd=2,ylab="Cumulative Profit & Loss",xlab="Trading Day",main="2010.05.25 ~ 2015.08.19",ylim=c(min(DD),max(cumsum(profit
))))
par(new=T)
plot(cumsum(profit),type="h",col="Tomato",lwd=2,ylab="Cumulative Profit & Loss",xlab="Trading Day",main="2010.05.25 ~ 2015.08.19",ylim=c(min(DD),max(cumsum(profit))))

TPT=rep(1,1);i=1

for (m in 2:length(profit)){
	if (topprofit[m]>topprofit[m-1]){points(m,topprofit[m],pch=4,col="red")
	TPT[i]=m
	i=i+1}
}

DDT=rep(TPT[1],1)
for (i in 2:length(TPT)){	DDT[i]=TPT[i]-TPT[i-1]}


cat(" 損益(扣5點手續費):",sum(profit),"\n"
,"交易天數:",length(profit),"\n"
,"總交易次數:",length(profit[profit!=0]),"\n"
,"平均每次損益(扣5點手續費):",sum(profit)/length(profit[profit!=0]),"\n"
,"獲利次數:",length(profit[profit>0]),"\n"
,"勝率:",length(profit[profit>0])*100/length(profit[profit!=0]),"%","\n"
,"平均賺:",mean(profit[profit>0]),"\n"
,"平均賠:",mean(profit[profit<0]),"\n"
,"最大連續虧損:",abs(min(DD)),"\n"
,"最大連續虧損區間(天):",tail(sort(DDT),5),"\n"
,"獲利因子:",sum(profit[profit>0])/-sum(profit[profit<0]),"\n"
,"SQN:",(sum(profit)/length(profit[profit!=0]))*length(profit[profit!=0])^0.5/sd(profit[profit!=0]),"\n"
,"總獲利/MDD:",sum(profit)/abs(min(DD)),"\n")
#,"進度:",kk1,kk2,tt1,tt2,"\n")

}