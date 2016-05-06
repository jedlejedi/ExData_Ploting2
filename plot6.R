# Load the data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Select vehicle combustion source only
isVehicle <- grepl(SCC$SCC.Level.Two, pattern = "vehicle", ignore.case = TRUE)
vehicleSource <- SCC[isVehicle,]$SCC
NEI <- subset(NEI, SCC %in% vehicleSource)

# Select Baltimore City emission only
baltimore <- subset(NEI, fips == "24510")

# Select Los Angeles emission only
la <- subset(NEI, fips == "06037")

# Calculate total pm 2.5 emission per year
pm25Baltimore <- tapply(baltimore$Emissions, baltimore$year, sum)
pm25La <- tapply(la$Emissions, la$year, sum)

# Plot the chart
opt <- options(scipen = 10)

rng <- range(c(pm25La,pm25Baltimore))

plot(names(pm25La), pm25La, xlab = "Year", ylab = "PM2.5 (tons)", ylim = rng, main = "PM2.5 emission from vehicle sources\n in Baltimore City and Los Angeles", col = "red")
lines(names(pm25La), pm25La, col = "red")
points(names(pm25Baltimore), pm25Baltimore, col = "blue")
lines(names(pm25Baltimore), pm25Baltimore, col = "blue")
legend(legend = c("Baltimore", "Los Angeles"), col = c("blue", "red"), x = "right", lwd = 2)

# Generate png file
dev.copy(device = png, filename = "plot6.png", width = 480, height = 480)
dev.off()

