######################################################################
### SubWin_Samplers.Forward_Samplor
######################################################################

SubWin_Samplers.Forward_Samplor = function (x.xts, SubWin_Size = 20, Events_Dates = NULL, normailize = TRUE, 
                                            BasePrice_Gen = NULL) 
{
  if (class(Events_Dates) == "character") 
    Events_Dates <- as.Date(Events_Dates)
  
  XTS_Dates = rownames(as.matrix(x.xts))
  if (is.null(Events_Dates)) {
    SubWins_Dates_Index = 1:length(XTS_Dates)
    SubWins_Dates = XTS_Dates
  }
  else {
    SubWins_Dates_Index = which(XTS_Dates %in% Events_Dates)
    SubWins_Dates = XTS_Dates[SubWins_Dates_Index]
  }
  XTS_Length = length(XTS_Dates)
  if (SubWin_Size > 0) {
    SubWins_Dates_Index = SubWins_Dates_Index[which((XTS_Length - 
                                                       SubWins_Dates_Index) > SubWin_Size)]
    SubWins_Dates = XTS_Dates[SubWins_Dates_Index]
    SubWins_Index = cbind(SubWins_Dates, XTS_Dates[SubWins_Dates_Index + 
                                                     SubWin_Size])
    SubWins_Index = apply(SubWins_Index, 1, function(xx) paste(xx[1], 
                                                               xx[2], sep = "::"))
  }
  else {
    SubWins_Index = paste(SubWins_Dates, "::", sep = "")
  }
  if (normailize) {
    SubWins = lapply(SubWins_Index, function(xx) {
      SubWin_XTS = x.xts[xx, ]
      BasePrice = ifelse(test = is.null(BasePrice_Gen), 
                         yes = as.numeric(SubWin_XTS[1, 1]), no = BasePrice_Gen(SubWin_XTS))
      SubWin_XTS = (SubWin_XTS - BasePrice)/BasePrice
      return(list(BasePrice = BasePrice, ReturnSubWin = SubWin_XTS))
    })
    return(SubWins)
  }
  else {
    SubWins = lapply(SubWins_Index, function(xx) {
      SubWin_XTS = x.xts[xx, ]
      return(list(ReturnSubWin = SubWin_XTS))
    })
    return(SubWins)
  }
}

######################################################################
### try SubWin_Samplers.Forward_Samplor
######################################################################

Xt = getSymbols("^SOX",from="2001-01-01",auto.assign = F)

WinSize = 20
sampleData = SubWin_Samplers.Forward_Samplor(x.xts=Cl(Xt),SubWin_Size=WinSize)
head(sampleData)

######################################################################
### Kmenas Clustering
######################################################################

K_Centers = 5
rawData = do.call(rbind,lapply(sampleData,function(xx) as.numeric(xx$ReturnSubWin)))
model = kmeans(rawData,K_Centers,iter.max=50)

# hint: $+TAB  OR   str
model$ #+TAB
str(model)
names(model)  

######################################################################
### Plot Kmenas Clustering Results
######################################################################

layout(as.matrix(cbind(2:(K_Centers+1),2:(K_Centers+1),1,1)))
layout.show((K_Centers+1))
par(mar=c(3,3,1,1))
barplot(model$size, horiz=TRUE)
for (i in 1:K_Centers){
  par(mar=c(2,2,1,1))
  plot(1:(WinSize+1),model$centers[i,],type="l",col=i)
}

######################################################################
### Plot Centers
######################################################################

par(mar=c(1,1))
plot(1:(WinSize+1),model$centers[1,],type="l",ylim=c(-0.3,0.3))
for (i in 2:K_Centers){
  points(1:(WinSize+1),model$centers[i,],type="l",col=i)
}

######################################################################
### DBSCAN Clustering
######################################################################

library("fpc")

model = dbscan(rawData,eps = 0.15)
model

model <- pamk(rawData,krange=7:9,criterion="asw",critout=TRUE)


layout(as.matrix(cbind(2:(model$nc+1),2:(model$nc+1),1,1)))
layout.show((model$nc+1))

size = 1:model$nc
for (i in 1:model$nc){
  size[i] = sum(model$pamobject$clustering==i)
}
barplot(size, horiz=TRUE)

for (i in 1:model$nc){
  par(mar=c(2,2,1,1))
  plot(1:(WinSize+1),colMeans(rawData[model$pamobject$clustering==i,]),type="l",col=i)
}

