##畫出同時玩1,2,3局數玩40次的的報酬率，表現槓桿空間模型的不可思議
pwin=0.5	##勝率
odds=2		##賠率,賭1元，贏了拿回1+odds元，輸了輸1元
nbet=40	##賭的次數

#####玩一場賭局
LSM1=rep(1,100)

for (f in 1:100){
LSM1[f]=((1+(odds*f/100))^(nbet*pwin))*((1-(f/100))^(nbet*(1-pwin)))
}
par(family="STKaiti") #Only for Mac

plot (LSM1,type="l",lwd=3,col="red",font=2
,xlab="押注比例(%)",ylab="報酬率",main="玩一場賭局40次 (勝率50%，賠率為2)")

points(tail(order(LSM1),1),max(LSM1),col="red",pch=16)
abline(h=1,col="green",lty=1,lwd=2)
abline(v=25,col="blue",lty=2,lwd=2)


###同時玩兩場

LSM2=rep(1,100)

for (f in 1:100){
LSM2[f]=((1+(2*odds*f/100))^10)*((1+(f/100))^20)*((1-(odds*f/100))^10)
}

plot (LSM2,type="l",lwd=3,font=2,col="Dodgerblue"
,xlab="押注比例(%)",xlim=c(0,100),ylab="報酬率",main="同時玩兩場賭局40次 (勝率50%，賠率為2)")

points(order(LSM2[1:50])[50],max(LSM2[1:50]),col="green",pch=16)

abline(h=1,col="green",lty=1,lwd=2)
abline(v=23,col="blue",lty=2,lwd=2)

### 同時玩三場

LSM3=rep(1,100)

for (f in 1:100){
LSM3[f]=((1+(6*f/100))^5)*((1+(3*f/100))^15)*((1-(3*f/100))^5)
}

plot (LSM3[1:34],type="l",font=2,col="purple",lwd=3
,xlab="押注比例(%)",ylab="報酬率"
,main="同時玩三場賭局40次 (勝率50%，賠率為2)")

points(tail(order(LSM3),1),max(LSM3),col="red",pch=16)

abline(h=1,col="green",lty=1,lwd=2)
abline(v=21,col="plum",lty=2,lwd=2)

########################

plot (log2(LSM1),col="red",xlab="押注比例(%)",xlim=c(0,100),ylim=c(0,9.5),ylab="報酬率",main="玩一場賭局40次 (勝率50%，賠率為2)")
points(order(LSM1)[100],log2(max(LSM1)),col="red",pch=16)
par(new=TRUE)
plot (log2(LSM2[1:50]),col="Dodgerblue",xlim=c(0,100),ylim=c(0,9.5),pch=20,xlab="",ylab="")
points(order(LSM2[1:50])[50],log2(max(LSM2[1:50])),col="red",pch=16)
par(new=TRUE)
plot (log2(LSM3[1:34]),col="purple",pch=20,xlim=c(0,100),ylim=c(0,9.5),xlab="",ylab="")
abline(h=0,col="green",lty=1,lwd=2)
points(order(LSM3)[100],log2(max(LSM3)),col="red",pch=16)

