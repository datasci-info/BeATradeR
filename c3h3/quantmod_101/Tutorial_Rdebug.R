library(quantmod)

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