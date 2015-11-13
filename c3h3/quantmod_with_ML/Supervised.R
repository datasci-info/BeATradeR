
######################################################################
### try SubWin_Samplers.Forward_Samplor
######################################################################

library(quantmod)

Xt = getSymbols("^SOX",from="2001-01-01",auto.assign = F)

# lag(xts)
head(Xt)
head(lag(Xt))
head(lag(Xt,3))

head(Xt)
head(lag(Xt,-3))

######################################################################
### Labeling Events
######################################################################

Diff = lag(Cl(Xt),-1) - Cl(Xt)
Diff = Diff[-NROW(Xt)]
Labels = sign(Diff)

######################################################################
### Feature Engineering
######################################################################

# MAs 
MA_Series = c(5,10,20,60)
MA_Series_Features = SMA(Cl(Xt),5)

for (i in MA_Series[-1]){
  MA_Series_Features = cbind(MA_Series_Features,SMA(Cl(Xt),i))
}

colnames(MA_Series_Features)=unlist(lapply(MA_Series,function(x) paste("MA",x,sep="")))
head(MA_Series_Features,100)


# KDs 
KD_Features = stoch(HLC(Xt))

# MACD
MACD_Features = MACD(Cl(Xt))


Total_Features = cbind(MA_Series_Features,KD_Features,MACD_Features)

######################################################################
### combine Labels and Features
######################################################################

Total_Data = as.data.frame(cbind(Labels,Total_Features)["2007-04-09::"])
head(Total_Data,100)
colnames(Total_Data)[1] = "Labels"
tail(Total_Data)
Total_Data = Total_Data[!is.na(Total_Data$Labels),]
Total_Data = Total_Data[!is.na(Total_Data$MA60),]


######################################################################
### split Data
######################################################################


NData = NROW(Total_Data)
Training_Index = sample(1:NData,size = 0.3*NData)
Testing_Index = (1:NData)[-Training_Index]

Training_Data = Total_Data[Training_Index,]
Training_Y = as.factor(Training_Data$Labels)
Training_X = Training_Data[,-1]


Testing_Data = Total_Data[Testing_Index,]
Testing_Y = as.factor(Testing_Data$Labels)
Testing_X = Testing_Data[,-1]


#####################################################################
## SVM
#####################################################################

library(e1071)
svmModel = svm(x = Training_X,y = Training_Y,cost = 10)
table(Testing_Y,predict(svmModel,Testing_X))
table(Training_Y,predict(svmModel,Training_X))

#####################################################################
## Adaboost
#####################################################################

library(ada)
model = ada(x = Training_X,y = Training_Y,test.x = Testing_X,test.y = Testing_Y)
table(Testing_Y,predict(model,Testing_X))

model$model$trees

plot(model$model$trees[[1]])
text(model$model$trees[[1]], cex = .8)


#####################################################################
## spls
#####################################################################

library(spls)
model = splsda(x = as.matrix(Training_X),y = as.matrix(Training_Y),K = 1,eta = 0.9,kappa = 0.5)
model
table(Testing_Y,predict(model,Testing_X))


