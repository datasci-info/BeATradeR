
######################################################################
### addXXX methods & to.period methods
######################################################################

library(quantmod)
getSymbols("USD/TWD",src="oanda")
chartSeries(USDTWD)
chartSeries(to.weekly(USDTWD))

# add + TAB
add 

addSAR()
addSMA()
addBBands()

######################################################################
### runXXXX methods
######################################################################

k=30
USDTWD_kMin = runMin(USDTWD, n = k, cumulative = FALSE)
USDTWD_kMax = runMax(USDTWD, n = k, cumulative = FALSE)
USDTWD_kMedian = runMedian(USDTWD, n = k, cumulative = FALSE)
USDTWD_kMean = runMean(USDTWD, n = k, cumulative = FALSE)

chartSeries(USDTWD)
addTA(USDTWD_kMin,on=1,type="l",col=2)
addTA(USDTWD_kMax,on=1,type="l",col=4)
addTA(USDTWD_kMedian,on=1,type="l",col=5)
addTA(USDTWD_kMean,on=1,type="l",col=6)


######################################################################
### compute TA directly with TTR
######################################################################

# [hint] TAB with package::
TTR::

Xt = getSymbols("^VIX",auto.assign = F)
BBands(Xt)

# [hint] TAB with func (watching args)
BBands
args(BBands)

bb <- BBands(HLC(Xt),n=60)
tail(bb)

volatility = (bb$up - bb$dn) / bb$dn
chartSeries(Xt,TA = NULL)
addTA(volatility,type="l",col=2)
addTA(diff(volatility),type="l",col=2)

######################################################################
### compute TA directly with TTR
######################################################################

Xt = getSymbols("^TWII",auto.assign = F)

chartSeries(Xt,TA = NULL)
addCCI()
addADX()

tail(ADX(Xt))
tail(CCI(Xt))
CCI
tail(CCI(HLC(Xt)))

######################################################################
### compute KD directly with TTR
######################################################################

# [hint] TAB with package::
TTR::
  
Xt = getSymbols("^TWII",auto.assign = F)
stoch(Xt)

# [hint] TAB with func (watching args)
stoch
args(stoch)

KD <- stoch(HLC(Xt))
tail(KD)
chartSeries(Xt,TA = NULL)
addTA(KD$fastK,type="l",col=2)
addTA(KD$fastD,type="l",col=3,on=2)
addTA(KD$slowD,type="l",col=4,on=2)


