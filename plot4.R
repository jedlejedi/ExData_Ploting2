# Load the data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Select coal combustion source only
isCombustion <- grepl(SCC$Short.Name, pattern = "comb", ignore.case = TRUE)
isCoal <- grepl(SCC$Short.Name, pattern = "coal", ignore.case = TRUE)

isCoalCombustion <- (isCombustion & isCoal)

coalCombustionSource <- SCC[isCoalCombustion,]$SCC

NEI <- subset(NEI, SCC %in% coalCombustionSource)

# Calculate total pm 2.5 emission per year
pm25 <- tapply(NEI$Emissions, NEI$year, sum)

# Plot the chart
plot(names(pm25), pm25, xlab = "Year", ylab = "PM2.5 (tons)", main = "PM2.5 Emissions from Coal Combustion Sources in the US")
lines(names(pm25), pm25)

# Generate png file
dev.copy(device = png, filename = "plot4.png", width = 480, height = 480)
dev.off()
