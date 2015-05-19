#Assignment

#The overall goal of this assignment is to explore the National Emissions Inventory database and see what it say about fine 
#particulate matter pollution in the United states over the 10-year period 1999-2008. You may use any R package you want to support your analysis.

#Questions
#You must address the following questions and tasks in your exploratory analysis. 
#For each question/task you will need to make a single plot. Unless specified, you can use any plotting system in R to make your plot.

#1.  Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? Using the base plotting system, make a plot showing 
#    the total PM2.5 emission from all sources for each of the years 1999, 2002, 2005, and 2008.

#clear cache
rm(list=ls())
#read in data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
#aggregate data by year
aggData<-with (NEI,aggregate(NEI[,'Emissions'],by=list(year), sum, na.rm=TRUE))
#set descriptive names
names(aggData) <- c('Year', 'TotEmission')
#start plot 
png(filename='plot1.png', width=480, height=480, units='px')
plot(aggData, type="l", xlab="Year", ylab="Total PM2.5 Emmision in the US (tons)",col="blue", xaxt="n", main="Total Emissions")
axis(side=1, col="black",at = seq(1999, 2008, by = 3), labels = TRUE, tcl = -0.2)
#close plot
dev.off()