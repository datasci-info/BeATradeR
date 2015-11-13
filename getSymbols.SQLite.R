getSymbols.SQLite=function (Symbols, env, return.class = "xts", db.fields = c("row_names", 
                                                            "Open", "High", "Low", "Close", "Volume", "Adjusted"), field.names = NULL, 
          dbname = NULL, POSIX = TRUE, ...) 
{
  importDefaults("getSymbols.SQLite")
  this.env <- environment()
  for (var in names(list(...))) {
    assign(var, list(...)[[var]], this.env)
  }
  if (!hasArg(verbose)) 
    verbose <- FALSE
  if (!hasArg(auto.assign)) 
    auto.assign <- TRUE
  if (!requireNamespace("DBI", quietly = TRUE)) 
    stop("package:", dQuote("DBI"), "cannot be loaded.")
  if (!requireNamespace("RSQLite", quietly = TRUE)) 
    stop("package:", dQuote("RSQLite"), "cannot be loaded.")
  drv <- DBI::dbDriver("SQLite")
  con <- DBI::dbConnect(drv, dbname = dbname)
  db.Symbols <- DBI::dbListTables(con)
  if (length(Symbols) != sum(Symbols %in% db.Symbols)) {
    missing.db.symbol <- Symbols[!Symbols %in% db.Symbols]
    warning(paste("could not load symbol(s): ", paste(missing.db.symbol, 
                                                      collapse = ", ")))
    Symbols <- Symbols[Symbols %in% db.Symbols]
  }
  for (i in 1:length(Symbols)) {
    if (verbose) {
      cat(paste("Loading ", Symbols[[i]], paste(rep(".", 
                                                    10 - nchar(Symbols[[i]])), collapse = ""), sep = ""))
    }
    query <- paste("SELECT ", paste(db.fields, collapse = ","), 
                   " FROM ", Symbols[[i]])
    rs <- DBI::dbSendQuery(con, query)
    fr <- DBI::fetch(rs, n = -1)
    if (POSIX) {
      d <- as.numeric(fr[, 1])
      class(d) <- c("POSIXt", "POSIXct")
      fr <- xts(fr[, -1], order.by = d)
    }
    else {
      fr <- xts(fr[, -1], order.by = as.Date(as.numeric(fr[, 
                                                           1]), origin = "1970-01-01"))
    }
    # colnames(fr) <- paste(Symbols[[i]], c("Open", "High", 
                                          # "Low", "Close", "Volume", "Adjusted"), sep = ".")
    fr <- quantmod:::convert.time.series(fr = fr, return.class = return.class)
    if (auto.assign) 
      assign(Symbols[[i]], fr, env)
    if (verbose) 
      cat("done\n")
  }
  DBI::dbDisconnect(con)
  if (auto.assign) 
    return(Symbols)
  return(fr)
}