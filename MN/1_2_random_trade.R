#!/usr/bin/env Rscript

# set random seed
set.seed(666)

# set parameters
SL=10
SP=10

# read historical data
tx_full=read.table("tx.txt", header=TRUE, sep=',',
                      colClasses=c("NULL", 
                                   "character",
                                   "character",
                                   "integer",
                                   "integer",
                                   "integer",
                                   "integer",
                                   "integer"))

# note : 
#   datetime stirng format is ugly in raw data, 
#   e.g., "2011103" which should be "20110103"
tx_split <- split(tx_full, factor(tx_full$Date, levels=unique(tx_full$Date), ordered=TRUE))

# main
profit <- setNames(numeric(length(tx_split)), names(tx_split))
for ( d in names(tx_split) ) {
  nt <- length(unique(tx_split[[d]]$Time))
  rd <- sample(0:1, size=1, prob=c(0.5,0.5))
  if ( rd ) { 
    long <- tx_split[[d]]$Open[1]
    hit_H <- ifelse(length(hcond <- which(tx_split[[d]]$High > long + SP)), min(hcond), Inf)
    hit_L <- ifelse(length(lcond <- which(tx_split[[d]]$Low < long - SL)), min(lcond), Inf)
    j <- min(c(hit_H, hit_L, nt))
    profit[d] <- 
      if ( j == hit_H ) {
        SP     
      } else if ( j == hit_L ) {
        -SL
      } else {
        tail(tx_split[[d]]$Close, 1) - long 
      }
  } else {
    short <- tx_split[[d]]$Open[1]
    hit_H <- ifelse(length(hcond <- which(tx_split[[d]]$High > short + SL)), min(hcond), Inf)
    hit_L <- ifelse(length(lcond <- which(tx_split[[d]]$Low < short - SP)), min(lcond), Inf)
    j <- min(c(hit_H, hit_L, nt))
    profit[d] <- 
      if ( j == hit_L ) {
        SP     
      } else if ( j == hit_H ) {
        -SL
      } else {
        short - tail(tx_split[[d]]$Close, 1)
      }
  }
}

source('performance.R', encoding = 'BIG5',echo = FALSE)

