######################################################################
### Luxor Strategy
######################################################################

library(quantmod)

Xt = getSymbols("2330.TW",auto.assign = F)
chartSeries(Xt,TA=NULL)
addSMA(n = 5,col = 2)
addSMA(n = 60, col = 5)

Cl5SMA = SMA(Cl(Xt),n = 5)
Cl60SMA = SMA(Cl(Xt),n = 60)
addTA(Cl5SMA - Cl60SMA,col=4)
addTA(sign(Cl5SMA - Cl60SMA),col=5)

# re-draw with two SMAs
chartSeries(Cl5SMA)
addTA(Cl60SMA,col=5,on = 1)
addTA(Cl5SMA - Cl60SMA,col=6)
addTA(sign(Cl5SMA - Cl60SMA),col=7)
addTA(diff(sign(Cl5SMA - Cl60SMA)),col=8)

diff(sign(Cl5SMA - Cl60SMA)) > 0 
which(diff(sign(Cl5SMA - Cl60SMA)) > 0 )

TDnDates <- index(Cl5SMA)[which(diff(sign(Cl5SMA - Cl60SMA)) > 0 )]
TUpDates <- index(Cl5SMA)[which(diff(sign(Cl5SMA - Cl60SMA)) < 0 )]

liftRatio = 0.02
addTA(Hi(Xt)[TDnDates]*(1+liftRatio),on=1,type="p",col=3,pch=25,bg="green")
addTA(Lo(Xt)[TUpDates]*(1-liftRatio),on=1,type="p",col=2,pch=24,bg="red")

######################################################################
### Crossover Events Detection
######################################################################

library(quantmod)

Xt = getSymbols("^TWII",auto.assign = F)
chartSeries(Xt,TA=NULL)

k=60
Xt_kMin = runMin(Xt, n = k, cumulative = FALSE)
Xt_kMax = runMax(Xt, n = k, cumulative = FALSE)
addTA(Xt_kMin,on=1,type="l",col=2)
addTA(Xt_kMax,on=1,type="l",col=4)

# re-draw with close and channel bottom
chartSeries(Cl(Xt))
addTA(Xt_kMin,on=1,type="l",col=2)
addTA(Cl(Xt) - Xt_kMin,type="l",col=3)
addTA(sign(Cl(Xt) - Xt_kMin),type="l",col=4)
addTA(diff(sign(Cl(Xt) - Xt_kMin)),type="l",col=5)

ClCrossMinGtDates <- index(Xt)[which(diff(sign(Cl(Xt) - Xt_kMin)) > 0 )]
ClCrossMinLtDates <- index(Xt)[which(diff(sign(Cl(Xt) - Xt_kMin)) < 0 )]

liftRatio = 0.02
chartSeries(Cl(Xt))
addTA(Xt_kMin,on=1,type="l",col=2)
addTA(Cl(Xt)[ClCrossMinLtDates]*(1+liftRatio),on=1,type="p",col=3,pch=25,bg="green")
addTA(Cl(Xt)[ClCrossMinGtDates]*(1-liftRatio),on=1,type="p",col=2,pch=24,bg="red")


# re-draw with close and channel bottom
chartSeries(Cl(Xt))
addTA(Xt_kMax,on=1,type="l",col=2)
addTA(Cl(Xt) - Xt_kMax,type="l",col=3)
addTA(sign(Cl(Xt) - Xt_kMax),type="l",col=4)
addTA(diff(sign(Cl(Xt) - Xt_kMax)),type="l",col=5)

ClCrossMaxGtDates <- index(Xt)[which(diff(sign(Cl(Xt) - Xt_kMax)) > 0 )]
ClCrossMaxLtDates <- index(Xt)[which(diff(sign(Cl(Xt) - Xt_kMax)) < 0 )]

liftRatio = 0.02
chartSeries(Cl(Xt))
addTA(Xt_kMax,on=1,type="l",col=2)
addTA(Cl(Xt)[ClCrossMaxLtDates]*(1+liftRatio),on=1,type="p",col=3,pch=25,bg="green")
addTA(Cl(Xt)[ClCrossMaxGtDates]*(1-liftRatio),on=1,type="p",col=2,pch=24,bg="red")


# Summary
chartSeries(Cl(Xt))
addTA(Xt_kMin,on=1,type="l",col=2)
addTA(Xt_kMax,on=1,type="l",col=4)
addTA(Hi(Xt)[ClCrossMaxLtDates]*(1+liftRatio),on=1,type="p",col=3,pch=25,bg="green")
addTA(Cl(Xt)[ClCrossMinGtDates]*(1-liftRatio),on=1,type="p",col=2,pch=24,bg="red")

######################################################################
### Volatility Thresholds Breaking
######################################################################

library(quantmod)

Xt = getSymbols("^TWII",auto.assign = F)
chartSeries(Xt,TA=NULL)

k=30
Xt_kMin = runMin(Xt, n = k, cumulative = FALSE)
Xt_kMax = runMax(Xt, n = k, cumulative = FALSE)
addTA(Xt_kMin,on=1,type="l",col=2)
addTA(Xt_kMax,on=1,type="l",col=4)

volatility = (Xt_kMax - Xt_kMin)/Xt_kMin
addTA( volatility ,type="l",col=4)
hist(volatility,breaks = 200)

addTA( diff(volatility) ,type="l",col=5)

######################################################################
### Volatility Thresholds Breaking
######################################################################

library(quantmod)

Xt = getSymbols("^TWII",auto.assign = F)
chartSeries(Xt,TA="addBBands(n=30)")
addTA(Xt_kMin,on=1,type="l",col=8)
addTA(Xt_kMax,on=1,type="l",col=8)


bb = BBands(HLC(Xt),n=30)
tail(bb)
BBvolatility = (bb$up - bb$dn)/bb$dn
addTA( BBvolatility ,type="l",col=4)
# hist(BBvolatility,breaks = 200)
addTA( volatility ,type="l",col=5)


addTA( diff(BBvolatility) ,type="l",col=6)
addTA( diff(volatility) ,type="l",col=7)


# Clean up 
chartSeries(Xt,TA="addBBands(n=60)")
bb = BBands(HLC(Xt),n=60)
BBvolatility = (bb$up - bb$dn)/bb$dn
hist(BBvolatility,breaks = 200)
quantile(BBvolatility,probs = 0.8,na.rm = T)
addTA( BBvolatility ,type="l",col=4)
addTA( sign(BBvolatility - 0.2) ,type="l",col=4)



