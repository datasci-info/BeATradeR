##尋找最佳下注比例##

nbet=40	##賭的次數
odds=2	##賠率。賭1元，贏了拿回1+odds元，輸了輸1元
pwin=0.5	##勝率
initM=1	##初始資金
f=0.05	##下注比例

dice=sample(0:1,size=nbet,prob=c(0.5,0.5),replace=T) #產生100組01向量，1代表贏，出現的機會為pwin
capital=rep(initM,1)  		##每次賭局的資金

#Fcapital=rep(0,100)		##記錄不同比例的損益
#k=1
#for (f in seq(0.01,0.99,by=0.01)){

for(i in 2:nbet){
capital[i]=dice[i]*capital[i-1]*f*(1+odds)+capital[i-1]*(1-f)}

#Fcapital[k]=capital[nbet];k=k+1}
#cat("最佳下注比例",tail(order(Fcapital),1),"%","\n")
par(family="STKaiti") #Only for Mac
plot(capital,type="l",col="red",lwd=4
,xlim=c(0,nbet),ylim=c(0,max(capital))
,xlab="下注比例",ylab="資金成長"
,main="尋找最佳下注比例?")

abline(h=initM,col="green",lty=2,lwd=3)
