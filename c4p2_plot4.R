#Assignment

#The overall goal of this assignment is to explore the National Emissions Inventory database and see what it say about fine 
#particulate matter pollution in the United states over the 10-year period 1999-2008. You may use any R package you want to support your analysis.

#Questions
#You must address the following questions and tasks in your exploratory analysis. 
#For each question/task you will need to make a single plot. Unless specified, you can use any plotting system in R to make your plot.

#4.  Across the United States, how have emissions from coal combustion-related sources changed from 1999-2008?
#clear cache
rm(list=ls())
#read in data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
#add libraries
library(ggplot2)
library(plyr)
#define coal data set
both <- merge(NEI, SCC, by="SCC")
coalSource <- both[grepl("coal",both$Short.Name,ignore.case=T),]

#set descriptive names
#names(coalSource) <- c('year', 'Emissions')
#start plot
png(filename="plot4.png", width=480, height=480, units="px")

ggplot(data=coalSource, aes(x=year,y=Emissions))+
  geom_line(stat="summary", fun.y="sum")+
  #xlab('Year')+
  ylab(expression("Total PM2.5 Emissions in US (tons)"))+
  ggtitle('Total Emissions Trend from Coal Combustion-related sources in US')
#close plot
dev.off()
