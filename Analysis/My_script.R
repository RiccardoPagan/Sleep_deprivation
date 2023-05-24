# ensuring that my working directory was right
setwd("/Users/riccardopagan/Desktop/MyProject/Data")
getwd()

library(tidyverse)

MyData <- read.csv2("308.csv")
len <- nrow(MyData)
IDcol <- rep(308, len)
MyData$ID <- IDcol

subjects <- c("309", "310", "330", "331", "332", "333", "334", "335", "337", "349", "350", "351", "352", "369", "370", "371", "372")


for(i in subjects) {
  fname <- paste(i, sep = ".", "csv")
  nfile <- read.csv2(fname)
  len <- nrow(nfile)
  IDcol <- rep(i, len)
  nfile$ID <- IDcol
  MyData <- merge(MyData, nfile, by=c("Reaction", "Days", "ID"), all=TRUE)
}

