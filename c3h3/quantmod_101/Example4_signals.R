######################################################################
### Crossover Events Detection
######################################################################

library(quantstrat)

Xt = getSymbols('2330.TW', auto.assign = F)
chartSeries(tail(Xt,300),TA = NULL)
addBBands()

BBandsDN = function(mktdata,n) BBands(mktdata)$dn

Xt$BBandsDN = BBandsDN(HLC(Xt),n=20)
Xt$SMA = SMA(Cl(Xt),n=20)

clCrossOverBBandDn = sigCrossover(label="Cl.lt.BBandsDN",
                                  data=Xt,
                                  columns=c("Close","BBandsDN"),
                                  relationship="lt")

clCrossOverSMA60 = sigCrossover(label="Cl.gt.SMA",
                                data=Xt,
                                columns=c("Close","SMA"),
                                relationship="gt")

liftRatio = 0.02
chartSeries(tail(Xt,600),TA = NULL)
addBBands()
addTA(Lo(Xt)[!is.na(clCrossOverBBandDn)]*(1-liftRatio),on=1,type="p",col=2,pch=24,bg="red")
addTA(Hi(Xt)[!is.na(clCrossOverSMA60)]*(1+liftRatio),on=1,type="p",col=3,pch=25,bg="green")

######################################################################
### Volatility Thresholds Breaking
######################################################################

Xt = getSymbols("^TWII",auto.assign = F)
bb = BBands(HLC(Xt),n=30)
Xt$BBvolatility = (bb$up - bb$dn)/bb$dn

crxLtThSig = sigThreshold(label = "Xt.Lt.Th",data = Xt,column = "BBvolatility",threshold = 0.2,relationship = "lt",cross = T)
crxGtThSig = sigThreshold(label = "Xt.Gt.Th",data = Xt,column = "BBvolatility",threshold = 0.2,relationship = "gt",cross = T)

# Draw it
chartSeries(Xt,TA="addBBands(n=30)")
addTA( Xt$BBvolatility ,type="l",col=4)
addTA( sign(Xt$BBvolatility - 0.2) ,type="l",col=5)
addTA(crxLtThSig,col=7)
addTA(crxGtThSig,col=7)


######################################################################
### Other Signals in quantstrat
######################################################################

?sigComparison
?sigCrossover
?sigFormula
?sigPeak
?sigThreshold

