library(tidyverse)
library(ggplot2)

# ensuring that my working directory was right
setwd("/Users/riccardopagan/Desktop/Sleep_deprivation/Data")
getwd()


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

MyData <- arrange(MyData, ID, Days) 

describe(MyData)
plot_intro(MyData)
plot_histogram(MyData$Reaction)

m1 <- lm (Reaction~Days, data=MyData)

check_model(m1)

summary(m1)


ggplot(MyData, aes(x=Days, y=Reaction)) + geom_point() + geom_smooth(method = "lm")
ggplot(MyData, aes(x=Days, y=Reaction, color=ID)) + geom_point() + geom_line()
