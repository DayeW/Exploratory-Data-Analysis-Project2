#Question 3: Of the four types of sources indicated by the type 
#(point, nonpoint, onroad, nonroad) variable, which of these four sources 
#have seen decreases in emissions from 1999–2008 for Baltimore City? 
#Which have seen increases in emissions from 1999–2008? 
#Use the ggplot2 plotting system to make a plot answer this question.

##setwd
setwd("~/Desktop/Work/Coursera/ExploratoryData/exdata-data-NEI_data")
library(plyr)
library(ggplot2)

##Read file
summarycc <- readRDS("Source_Classification_Code.rds")
sccpm25 <- readRDS("summarySCC_PM25.rds")

#subset baltimore data
baltimore <- subset(sccpm25, sccpm25$fips == 24510)

#aggregate/sum emissions by year and type
aggbalt <- aggregate(Emissions ~ year+type, baltimore, sum)

#plot
png("plot3.png", width = 480, height = 480)
plot3 <- ggplot(aggbalt, aes(year, Emissions, color = type)) + geom_line() +
      ggtitle("Total PM2.5 Emissions in Baltimore City from 1999 to 2008")
print(plot3)
dev.off()