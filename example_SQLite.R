source('c3h3/quantmod_101/downloadTaifex.R')

TEST_Stock_Data = getSymbols.SQLite("FutureTByT",src="SQLite",auto.assign=FALSE,
                             db.fields = c("date", "price"), 
                             user=NA, password=NA, dbname=TAIFEX_DB_FILE)
