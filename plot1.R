#Question 1: Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? 
#Using the base plotting system, make a plot showing the total PM2.5 emission from all sources 
#for each of the years 1999, 2002, 2005, and 2008.

##setwd
setwd("~/Desktop/Work/Coursera/ExploratoryData/exdata-data-NEI_data")
library(dplyr)

##Read file
summarycc <- readRDS("Source_Classification_Code.rds")
sccpm25 <- readRDS("summarySCC_PM25.rds")

##sum emissions by year
nei <- tapply(sccpm25$Emissions, sccpm25$year, sum)

##colors galore!
colors <- c("red", "purple", "blue", "green")

##plot
png("plot1.png", width = 500, height = 480)
plot1 <- barplot(height = nei/1000, main = "Total PM2.5 Emissions by Year", xlab = "Year", 
                 ylab = "Total PM2.5 Emissions (kilotons)", ylim = c(0, 9000), col = colors)
print(plot1)
text(x = plot1, y = round(nei/1000, 2), label = round(nei/1000, 2), pos = 3, cex = 0.5, col = "black")
dev.off()