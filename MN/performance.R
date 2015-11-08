### Performance Module, Drawing ##
### INPUT profit vector

performance=function (profit){

DD=rep(0,length(profit))	## Draw Down
topprofit=rep(profit[1],length(profit))	## temp maximum profit

for (m in 2:length(profit)){
	if (sum(profit[1:m])>topprofit[m-1]){
	topprofit[m:length(profit)]=sum(profit[1:m])} ## setting top profit

	DD[m]=sum(profit[1:m])-topprofit[m]	## current draw down
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
for (i in 2:length(TPT)){DDT[i]=TPT[i]-TPT[i-1]}

cat(" 損益:",sum(profit),"\n"
,"交易天數:",length(profit),"\n"
,"平均每次損益:",sum(profit)/length(profit[profit!=0]),"\n"
,"獲利次數:",length(profit[profit>0]),"\n"
,"勝率:",length(profit[profit>0])*100/length(profit[profit!=0]),"%","\n"
,"平均賺:",mean(profit[profit>0]),"\n"
,"平均賠:",mean(profit[profit<0]),"\n"
,"最大連續虧損:",abs(min(DD)),"\n"
,"最大連續虧損區間(天):",tail(sort(DDT),5),"\n"
,"獲利因子:",sum(profit[profit>0])/-sum(profit[profit<0]),"\n"
,"總獲利/MDD:",sum(profit)/abs(min(DD)),"\n")

cat(" Total Profit:",sum(profit),"\n"
,"Trading Days:",length(profit),"\n"
,"Profit Per Trade:",sum(profit)/length(profit[profit!=0]),"\n"
,"# of Win:",length(profit[profit>0]),"\n"
,"Win Rate:",length(profit[profit>0])*100/length(profit[profit!=0]),"%","\n"
,"Winning Average:",mean(profit[profit>0]),"\n"
,"Lossing Average:",mean(profit[profit<0]),"\n"
,"Maximum Draw Down:",abs(min(DD)),"\n"
,"The Periods of MDD:",tail(sort(DDT),5),"\n"
,"Profit Factor:",sum(profit[profit>0])/-sum(profit[profit<0]),"\n"
,"Total Profit/MDD:",sum(profit)/abs(min(DD)),"\n")
}