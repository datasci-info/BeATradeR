
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

######################################################################
### Write xts into MySQL
######################################################################

library(quantmod)
Stock_Data = getSymbols("^TWII",auto.assign=FALSE)
head(Stock_Data)
# chartSeries(Stock_Data)


Stock_Data_DF = data.frame(Date = index(Stock_Data),Stock_Data)
colnames(Stock_Data_DF)[-1] = sapply(colnames(Stock_Data_DF)[-1],function(xx) unlist(strsplit(xx,split="\\."))[2])
colnames(Stock_Data_DF)
head(Stock_Data_DF)
# View(Stock_Data_DF)

library(RMySQL)
drv = dbDriver("MySQL")
con = dbConnect(drv, user="root", password="BeATradeR", dbname="BATR",
                host="45.33.57.118")
dbSendQuery(con,'SET NAMES utf8 ')
dbListTables(con)
# dbRemoveTable(con, "TWII")
dbWriteTable(con, "TWII", Stock_Data_DF ,row.names=FALSE,append=TRUE)  
dbDisconnect(con)

######################################################################
### get TWII from MySQL
######################################################################

TEST_Stock_Data = getSymbols("TWII",src="mysql",auto.assign=FALSE,
                             db.fields = c("Date", "Open", "High", "Low", "Close", "Volume", "Adjusted"), 
                             user="root", password="BeATradeR", dbname="BATR",
                             host="45.33.57.118")
head(TEST_Stock_Data)


######################################################################
### read data from DB and convert to xts
######################################################################

TAIFEX_DB_FILE = Sys.getenv(x = "DB_PATH", unset = "data/TAIFEX/TaifexDaily.sqlite", names = NA)

library(RSQLite)
library(quantmod)
sqliteDrv <- dbDriver("SQLite")
conn <- dbConnect(sqliteDrv,TAIFEX_DB_FILE)
df = dbGetQuery(conn,sprintf("select time, price, volume from FutureTByT where pcode = 'TX' and exMW = '201511'", dataDate))
Xt = xts(df$price, order.by = as.POSIXct(df$time,origin = "1970-01-01",tz = "CST"))
chartSeries(to.minutes(Xt))
addCCI()
addBBands()

chartSeries(Xt["2015-11-11"])
chartSeries(to.minutes(Xt["2015-11-11"]))
chartSeries(to.minutes10(Xt["2015-11-11"]))





