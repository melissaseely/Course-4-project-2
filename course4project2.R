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



#5.  How have emissions from motor vehicle sources changed from 1999-2008 in Baltimore City?
#clear cache
rm(list=ls())
#read in data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
#add libraries
library(ggplot2)
library(plyr)
#set Baltimore Vehicle data set
both <- merge(NEI, SCC, by="SCC")
subs<-subset(both, fips=='24510')
BaltNEIVeh <- both[grepl("motor", subs$Short.Name, ignore.case=TRUE),]
#start plot
png(filename="plot5.png", width=480, height=480, units="px")
ggplot(BaltNEIVeh, aes(y = Emissions, x = year)) + 
  geom_line(stat="summary", fun.y="sum") + 
  ylab(expression("Amount of PM2.5 emitted (tons)")) + 
  ggtitle("Total PM2.5 emission from motor vehicle sources in Baltimore")
#close plot
dev.off()



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


# Making and Submitting Plots...For each plot you should
#1. Construct the plot and save it to a PNG file.
#2. Create a separate R code file (plot1.R, plot2.R, etc.) that constructs the corresponding plot, i.e. code in plot1.R constructs 
#   the plot1.png plot. Your code file should include code for reading the data so that the plot can be fully reproduced. You must also include the code that creates the PNG file. Only include the code for a single plot (i.e. plot1.R should only include code for producing plot1.png)
#3. Upload the PNG file on the Assignment submission page
#4. Copy and paste the R code from the corresponding R file into the text box at the appropriate point in the peer assessment.


