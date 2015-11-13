library(quantmod)


getSymbols("^TWII")
View(TWII)
chartSeries(TWII, theme = "white")

getSymbols("0050.TW")
0050.TW

TW0050 <- get("0050.TW")

assign("b",123)
b=123
b<-123
`<-`("c",123)

TW0050 = getSymbols("0050.TW",auto.assign = F)

F == FALSE
T == TRUE

?getSymbols.FI
?getSymbols.FRED
?getSymbols.oanda

getSymbols("USD/TWD",src="oanda",from="2000-01-01")
chartSeries(USDTWD, theme = "white")

debug(getSymbols)
getSymbols("^TWII")
undebug(getSymbols)

debug(download.file)
getSymbols("^TWII")
undebug(download.file)


as.list(body(getSymbols))
as.list(body(download.file))
# print(getsymbols.returned) at the bigenning of BLOCK 14
trace(download.file, quote(print(url)),at=c(1))
getSymbols("^TWII")
untrace(download.file)


f = function(x,y) c(x,y)
f(1,2)
do.call(f,list(3,4))
do.call(f,list(y=3,x=4))

g = function(...) list(...)
g(a=1,b=10,c=31,12,321)
do.call(g, list(a=1,b=10,c=31,12,321))
