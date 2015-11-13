# Be A TradeR

## 此頁網址：http://tinyurl.com/nsxja54

## 廣播：http://tinyurl.com/nedhxwm

##共筆：http://tinyurl.com/oftq98a

##Forum：http://tinyurl.com/oc42by3

# Slides:
- [上午場]
- [下午場] https://docs.google.com/presentation/d/1JsIPnoLSlp8YOWjDsV_7uTx271ePbifP40QoUqUdI5Y/embed?start=false&loop=false&delayms=60000

# 環境設定

## 安裝套件

1. 執行以下指令：

```
pkgs <- c("quantmod", "PerformanceAnalytics", "foreach",
          "quantstrat", "httr", "rvest", "stringr",
          "RSQLite", "RMySQL", "dplyr", "e1071", "xgboost",
          "ada")
repos.list <- c("http://140.112.170.201/R", "http://45.33.57.118/R", "http://datasci-info.github.io/R")
install.packages(pkgs, repos = sample(repos.list, 1, prob = c(3, 5, 2)))
```

2. 可能會出現以下選項，請選：`n`

![](http://i.imgur.com/VLTBK4S.png)

## 教學影片
https://www.youtube.com/playlist?list=PLLSknrdOLKyExmSXobXQebQUg2kESYGIe

## For Mac

##### Install gfortran
    curl -O http://r.research.att.com/libs/gfortran-4.8.2-darwin13.tar.bz2
    sudo tar fvxz gfortran-4.8.2-darwin13.tar.bz2 -C /

## For Windows

##### Maybe Need Rtools
https://cran.r-project.org/bin/windows/Rtools/
