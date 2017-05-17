#Question 6: Compare emissions from motor vehicle sources in Baltimore City 
#with emissions from motor vehicle sources in Los Angeles County, California (fips == "06037"). 
#Which city has seen greater changes over time in motor vehicle emissions?

###setwd
setwd("~/Desktop/Work/Coursera/ExploratoryData/exdata-data-NEI_data")
library(dplyr) #probably don't need this, but just in case
library(plyr)
library(ggplot2)

##Read file
summarycc <- readRDS("Source_Classification_Code.rds")
sccpm25 <- readRDS("summarySCC_PM25.rds")

#subset data for Baltimore and LA by motor vehicles = "ON-ROAD
baltmot <- sccpm25[sccpm25$fips == "24510" & sccpm25$type == "ON-ROAD",]
lamot <- sccpm25[sccpm25$fips == "06037" & sccpm25$type == "ON-ROAD",]

#sum subsetted data for each city and name
aggregatebaltmot <- aggregate(Emissions ~ year + fips, baltmot, sum) 
aggregatebaltmot$fips[aggregatebaltmot$fips == 24510] <- "Baltimore City, MD"
aggregatelamot <- aggregate(Emissions ~ year + fips, lamot, sum)
aggregatelamot$fips[aggregatelamot$fips == "06037"] <- "Los Angeles, CA"

#merge the two datasets into one
compare <- rbind(aggregatebaltmot, aggregatelamot)

#plot
png("plot6.png", width = 1260, height = 480)
plot6 <- ggplot(compare, aes(x = factor(year), y = Emissions, fill = fips)) +
  geom_bar(aes(fill = year), stat="identity") +
  facet_grid(scales="free", space="free", .~fips) +
  guides(fill = FALSE) + theme_bw() +
  xlab("Year") + ylab("Total PM2. Emissions (tons)") + 
  ggtitle("Total Motor Vehicle Emissions in Baltimore vs. Los Angeles, 1999 to 2008")
print(plot6)
dev.off()
