#Assignment

#The overall goal of this assignment is to explore the National Emissions Inventory database and see what it say about fine 
#particulate matter pollution in the United states over the 10-year period 1999-2008. You may use any R package you want to support your analysis.

#Questions
#You must address the following questions and tasks in your exploratory analysis. 
#For each question/task you will need to make a single plot. Unless specified, you can use any plotting system in R to make your plot.



#2.  Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (fips == "24510") from 1999 to 2008? Use the base plotting 
#    system to make a plot answering this question.
#clear cache
rm(list=ls())
#read in data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
#pull only Baltimore data
BaltNEI <- NEI[NEI$fips=="24510",]
#aggregate data by year
aggDataBalt <- with (BaltNEI,aggregate(BaltNEI[,'Emissions'],by=list(year), sum, na.rm=TRUE))
#set descriptive names
names(aggDataBalt) <- c('Year', 'TotEmission')
#start plot
png(filename='plot2.png', width=480, height=480, units='px')
plot(aggDataBalt, type="l", xlab="Year", ylab="Total PM2.5 Emmision in Baltimore (tons)",col="red", xaxt="n", main="Total Emissions in Baltimore")
axis(side=1, col="black",at = seq(1999, 2008, by = 3), labels = TRUE, tcl = -0.2)
#close plot
dev.off()