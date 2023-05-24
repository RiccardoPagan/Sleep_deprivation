library(tidyverse)
library(psych)
library(DataExplorer)
library(performance)
library(ggplot2)

# ensuring that my working directory was right
setwd("/Users/riccardopagan/Desktop/MyProject/Data")
getwd()

# merging .csv files in a unique dataframe
MyData <- read.csv2("308.csv")
len <- nrow(MyData)
IDcol <- rep(308, len)
MyData$ID <- IDcol #adding ID columns 

subjects <- c("309", "310", "330", "331", "332", "333", "334", "335", "337", "349", "350", "351", "352", "369", "370", "371", "372")


for(i in subjects) {
  fname <- paste(i, sep = ".", "csv")
  nfile <- read.csv2(fname)
  len <- nrow(nfile)
  IDcol <- rep(i, len)
  nfile$ID <- IDcol
  MyData <- merge(MyData, nfile, by=c("Reaction", "Days", "ID"), all=TRUE)
}

# ordering my dataframe by ID and Days
MyData <- arrange(MyData, ID, Days) 

# first analyis to explore my dataset
describe(MyData)
plot_intro(MyData)
plot_histogram(MyData$Reaction)

# linear model (linear regression)
m1 <- lm (Reaction~Days, data=MyData)

# visual check of model various assumptions
check_model(m1)
plot(m1)

summary(m1)

#ouputs
ggplot(MyData, aes(x=Days, y=Reaction, group=ID, color=ID)) + geom_point() + geom_line() 
ggplot(MyData, aes(x=Days, y=Reaction)) + geom_point() + geom_smooth(method = "lm") # general linear regression
