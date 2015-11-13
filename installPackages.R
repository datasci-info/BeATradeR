pkgs <- c("quantmod", "PerformanceAnalytics", "foreach",
          "quantstrat", "httr", "rvest", "stringr", 
          "RSQLite", "RMySQL", "dplyr", "e1071", "xgboost",
          "ada")
repos.list <- c("http://140.112.170.201/R", "http://45.33.57.118/R", "http://datasci-info.github.io/R")
install.packages(pkgs, repos = sample(repos.list, 1, prob = c(3, 5, 2)))
