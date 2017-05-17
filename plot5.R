#Question 5: How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City?

###setwd
setwd("~/Desktop/Work/Coursera/ExploratoryData/exdata-data-NEI_data")
library(dplyr) #probably don't need this, but just in case
library(plyr)
library(ggplot2)

##Read file
summarycc <- readRDS("Source_Classification_Code.rds")
sccpm25 <- readRDS("summarySCC_PM25.rds")

#subset baltimore data with motor vehicles = "ON-ROAD"
baltimore <- subset(sccpm25, sccpm25$fips == 24510)
motor <- sccpm25[baltimore$type == "ON-ROAD", ]

#sum emissions of subsetted data by year
aggregatebaltyear <- aggregate(Emissions ~ year, motor, sum)

#plot
png("plot5.png", width = 480, height = 480)
plot5 <- ggplot(aggregatebaltyear, aes(factor(year), Emissions/1000)) + 
  geom_bar(aes(fill = year), stat = "identity") + xlab("Year") + 
  ylab("Total PM2.5 Emissions (kilotons)") + 
  ggtitle("Total PM2.5 Emissions by Motor Vehicles in Baltimore City from 1999 to 2008")
print(plot5)
dev.off()