#Assignment

#The overall goal of this assignment is to explore the National Emissions Inventory database and see what it say about fine 
#particulate matter pollution in the United states over the 10-year period 1999-2008. You may use any R package you want to support your analysis.

#Questions
#You must address the following questions and tasks in your exploratory analysis. 
#For each question/task you will need to make a single plot. Unless specified, you can use any plotting system in R to make your plot.

#3.  Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable, which of these four sources have 
#    seen decreases in emissions from 1999-2008 for Baltimore City? Which have seen increases in emissions from 1999-2008? Use the 
#    ggplot2 plotting system to make a plot answer this question.
#clear cache
rm(list=ls())
#read in data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
#add libraries
library(ggplot2)
library(plyr)
#define Baltimore data set
BaltNEI <- NEI[NEI$fips=="24510",]
BaltData <- ddply(BaltNEI, c("year", "type"), function(df)sum(df$Emissions, na.rm=TRUE))
#start plot
png(filename="plot3.png", width=480, height=480)
ggplot(data=BaltData, aes(x=year, y=V1, group=type, colour=type)) +
  geom_line() +
  xlab("Year") +
  ylab("PM2.5 Emmisions in Baltimore (tons)") +
  ggtitle("Total PM2.5 Emissions in Baltimore (tons) Per Year by Source Type")
#close plot 
dev.off()
