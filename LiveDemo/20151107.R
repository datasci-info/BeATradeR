install.packages("PerformanceAnalytics")
install.packages("foreach")
install.packages("quantstrat", repos="http://R-Forge.R-project.org")
install.packages("httr")
install.packages("rvest")
library(quantmod)
library(quantmod)
getSymbols("^TWII")
TWII
chartSeries(TWII)
args(addBBands)
addBBands
addBBands()
chartSeries(tail(TWII,100))
addBBands()
args(getSymbols)
X = getSymbols("^TWII",auto.assign = F)
X
colnames(X)
Vo(X)
Vo(X)
Op(X)
Hi(X) - Lo(X)
(Hi(X) - Lo(X))/Lo(X)
args(chartSeries)
chartSeries(tail(TWII,100),TA="addBBands()")
Vol = (Hi(X) - Lo(X))/Lo(X)
?addTA
example(addTA)
addTA(Vol)
addTA(Vol)
addTA(Vol,on=5,col=4)
addTA(Vol,on=3,col=4)
Cl(TWLL)
Cl(TWII)
chartSeries(Cl(TWII))
to.monthly(Cl(TWII))
View(to.monthly(Cl(TWII)))
chartSeries(to.monthly(Cl(TWII)))
chartSeries(to.hourly(Cl(TWII)))
View(to.hourly(Cl(TWII)))
BBands(X)
BBands(HCL(X))
BBands(HLC(X))
View(BBands(HLC(X)))
chartSeries(TWII)
addBBands()
chartSeries(tail(TWII,100),TA="addBBands()")
C = Cl(TWII)
D = BBands(HLC(TWII))$dn
C
D
C-D
sign(C-D)
diff(sign(C-D))
diff(sign(C-D)) < 0
which(diff(sign(C-D)) < 0)
crup_idx = which(diff(sign(C-D)) < 0)
crup_idx = index(TWII)which(diff(sign(C-D)) < 0)
crup_idx = index(TWII)(which(diff(sign(C-D)) < 0))
crup_idx = index(TWII)[which(diff(sign(C-D)) < 0)]
crup_idx
liftRatio = 0.02
TUpDates = index(TWII)[which(diff(sign(C-D)) < 0)]
addTA(Hi(TWII)[TDnDates]*(1+liftRatio),on=1,type="p",col=3,pch=25,bg="green")
addTA(Lo(TWII)[TUpDates]*(1-liftRatio),on=1,type="p",col=2,pch=24,bg="red")
Vol
chartSeries(TWII)
addTA(Vol)
hist(Vol)
hist(Vol,breaks = 100)
hist(Vol,breaks = 1000)
Vol > 0.04
sign(Vol - 0.04)
addTA(sign(Vol - 0.04))
addTA(sign(Vol - 0.04),col=3)
chartSeries(TWII)
addTA(sign(Vol - 0.04),col=3)
chartSeries(TWII,TA=NULL)
addTA(sign(Vol - 0.03),col=3)
debug(chartSeries)
chartSeries(TWII,TA=NULL)
chartSeries(TWII,TA=NULL)
TA
x
addTA(sign(Vol - 0.01),col=3)
addTA(sign(Vol - 0.001),col=3)
addTA(sign(Vol - 0.05),col=3)
?getSymbols
getSymbols("2330.TW")
2330.TW
`2330.TW`
get("2330.TW")
`3008.TW`
get("3008.TW")
getSymbols("3008.TW")
`3008.TW`
chartSeries(`3008.TW`)
undebug(chartSeries)
chartSeries(`3008.TW`)
addTA(TWII)
chartSeries
`<-`
get("3008.TW")
library(quantstrat)
TW2330 = getSymbols('2330.TW', auto.assign = F)
chartSeries(tail(TW2330,300),TA = NULL)
addBBands()
BBandsDN = function(mktdata,n) BBands(mktdata)$dn
TW2330$BBandsDN = BBandsDN(HLC(TW2330),n=20)
TW2330$SMA = SMA(Cl(TW2330),n=20)
clCrossOverBBandDn = sigCrossover(label="Cl.lt.BBandsDN",
data=TW2330,
columns=c("Close","BBandsDN"),
relationship="lt")
clCrossOverSMA60 = sigCrossover(label="Cl.gt.SMA",
data=TW2330,
columns=c("Close","SMA"),
relationship="gt")
clCrossOverBBandDn
View(clCrossOverBBandDn)
liftRatio = 0.02
chartSeries(tail(TW2330,600),TA = NULL)
addBBands()
addTA(Lo(TW2330)[!is.na(clCrossOverBBandDn)]*(1-liftRatio),on=1,type="p",col=2,pch=24,bg="red")
addTA(Hi(TW2330)[!is.na(clCrossOverSMA60)]*(1+liftRatio),on=1,type="p",col=3,pch=25,bg="green")
