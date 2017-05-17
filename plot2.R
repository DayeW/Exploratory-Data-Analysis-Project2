#Question 2: Have total emissions from PM2.5 decreased in the Baltimore City, Maryland 
#(𝚏𝚒𝚙𝚜 == "𝟸𝟺𝟻𝟷𝟶") from 1999 to 2008? Use the base plotting system to make a plot answering this question.

##setwd
setwd("~/Desktop/Work/Coursera/ExploratoryData/exdata-data-NEI_data")

##Read file
summarycc <- readRDS("Source_Classification_Code.rds")
sccpm25 <- readRDS("summarySCC_PM25.rds")

#subset baltimore data
baltimore <- subset(sccpm25, sccpm25$fips == 24510)

#sum emissions by year 
balt <- tapply(baltimore$Emissions, baltimore$year, sum)

#colors galore!
colors <- c("red", "purple", "blue", "green")

#plot
png("plot2.png", width = 500, height = 480)
plot2 <- barplot(height = balt, main = "Total PM2.5 Emissions by Year in Baltimore City from 1999 to 2008", 
                 xlab = "Year", ylab = "Total PM2.5 Emissions (tons)", ylim = c(0, 4000), col = colors)
print(plot2)
text(x = plot2, y = round(balt, 2), label = round(balt, 2), pos = 3, cex = 0.5, col = "black")
dev.off()