#Assignment

#The overall goal of this assignment is to explore the National Emissions Inventory database and see what it say about fine 
#particulate matter pollution in the United states over the 10-year period 1999-2008. You may use any R package you want to support your analysis.

#Questions
#You must address the following questions and tasks in your exploratory analysis. 
#For each question/task you will need to make a single plot. Unless specified, you can use any plotting system in R to make your plot.

#6.  Compare emissions from motor vehicle sources in Baltimore City with emissions from motor vehicle sources in Los Angeles County, 
#    California (fips == "06037"). Which city has seen greater changes over time in motor vehicle emissions?
#clear cache
rm(list=ls())
#read in data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
#add libraries
library(ggplot2)
library(plyr)
#set LA and Baltimore Vehicle data
both <- merge(NEI, SCC, by="SCC")
subs <-subset(both, fips=='24510' | fips=='06037')
bothNEI <- subs[grepl("motor", subs$Short.Name, ignore.case=TRUE),]

#start plot
png(filename="plot6.png", width=480, height=480, units="px")
ggplot(data=bothNEI, aes(x=year, y=Emissions, color=fips))+
  geom_line(stat="summary", fun.y="sum") + 
  ylab(expression("Amount of PM2.5 emitted (tons)")) + 
  ggtitle("Emissions of PM2.5 from Motor Sources in Baltimore and LA")+
  scale_colour_discrete(name="Group", label=c("LA", "Baltimore"))
#close plot
dev.off()