
######################################################################
### Hello ! quantmod !
######################################################################

library(quantmod)
getSymbols("^TWII")
View(TWII)
chartSeries(TWII)

######################################################################
### get 3008,TW
######################################################################

getSymbols("3008.TW")
3008.TW

`3008.TW`
get("3008.TW")
chartSeries(`3008.TW`)

Xt = getSymbols("2330.TW",auto.assign = F)
chartSeries(Xt)

######################################################################
### R Helpers Remind ......
######################################################################

?getSymbols
args(getSymbols)
example(getSymbols)

# TAB
?getSymbols.yahoo
?getSymbols.oanda
?getSymbols.SQLite
?getSymbols.csv


######################################################################
### R Basic Remind ......
######################################################################

# show variables (in a env)
ls()
?ls
example(ls)

# assign value of varibles:
assign("b",123)
b=123
b<-123
`<-`("c",123)

ls()

# get value of varibles: 
c
get("c")
`c`


######################################################################
### get USD/TWD from oanda
######################################################################

getSymbols("USD/TWD",src="oanda",from="2000-01-01")
chartSeries(USDTWD)


