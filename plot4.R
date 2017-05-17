#Question 4: Across the United States, how have emissions from coal combustion-related sources 
#changed from 1999–2008?

##setwd
setwd("~/Desktop/Work/Coursera/ExploratoryData/exdata-data-NEI_data")
library(dplyr)
library(plyr)
library(ggplot2)

##Read file
summarycc <- readRDS("Source_Classification_Code.rds")
sccpm25 <- readRDS("summarySCC_PM25.rds")

##merge data by SCC to get all coal-related sources
merged <- merge(sccpm25, summarycc, by = "SCC")
mergedtable <- tbl_df(merged)

##find and subset coal-related sources from merged data
findcoal <- grepl("coal", mergedtable$Short.Name, ignore.case = T)
subsetmerged <- mergedtable[findcoal,]

##aggregate/sum emissions by year from subsetted data
aggregateyear <- aggregate(Emissions ~ year, subsetmerged, sum)

##plot
png("plot4.png", width = 700, height = 480)
plot4 <- ggplot(aggregateyear, aes(year, Emissions/1000)) + 
  geom_bar(aes(fill = year), stat = "identity") + xlab("Year") + ylab("Total PM2.5 Emissions (kilotons)") + 
  ggtitle("Total Coal-Combustion Related PM2.5 Emissions from 1999 to 2008")
print(plot4)
dev.off()
