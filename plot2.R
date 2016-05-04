# Load the data
NEI <- readRDS("summarySCC_PM25.rds")

NEI <- subset(NEI, fips == 24510)

# Calculate total pm 2.5 emission per year
pm25 <- tapply(NEI$Emissions, NEI$year, sum)

# Plot the chart
opt <- options(scipen = 10)

plot(names(pm25), pm25, xlab = "Year", ylab = "PM2.5 (tons)", main = "PM2.5 emission in Baltimore City")
lines(names(pm25), pm25)

# Generate png file
dev.copy(device = png, filename = "plot2.png", width = 480, height = 480)
dev.off()
