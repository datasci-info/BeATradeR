install.packages("devtools")
library(devtools)
install_github("joshuaulrich/quantmod")
install.packages("PerformanceAnalytics")
install.packages("foreach")

# install.packages("quantstrat", repos="http://R-Forge.R-project.org", type="source")
# fix R-forge error
install.packages("quantmod")
dir_name = "package"
dir.create(dir_name)
urls = c("http://download.r-forge.r-project.org/src/contrib/FinancialInstrument_1.2.0.tar.gz",
         "http://download.r-forge.r-project.org/src/contrib/blotter_0.9.1695.tar.gz",
         "http://download.r-forge.r-project.org/src/contrib/quantstrat_0.9.1709.tar.gz")
package_paths = paste(dir_name, basename(urls), sep = "/")
for (i in 1:length(urls)) {
    download.file(urls[i], package_paths[i])
    install.packages(package_paths[i], repos = NULL, type="source")
}


# install.packages("httr")
# install.packages("rvest")
# install.packages("stringr")
