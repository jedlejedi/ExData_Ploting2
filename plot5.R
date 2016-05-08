# Load the data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Select vehicle combustion source only
isVehicle <- grepl(SCC$SCC.Level.Two, pattern = "vehicle", ignore.case = TRUE)
vehicleSource <- SCC[isVehicle,]$SCC
NEI <- subset(NEI, SCC %in% vehicleSource)

# Select Baltimore City emission only
NEI <- subset(NEI, fips == 24510)

# Calculate total pm 2.5 emission per year
pm25 <- tapply(NEI$Emissions, NEI$year, sum)

# Plot the chart
plot(names(pm25), pm25, xlab = "Year", ylab = "PM2.5 (tons)", main = "PM2.5 Emissions from Vehicle Sources in Baltimore City")
lines(names(pm25), pm25)

# Generate png file
dev.copy(device = png, filename = "plot5.png", width = 480, height = 480)
dev.off()
