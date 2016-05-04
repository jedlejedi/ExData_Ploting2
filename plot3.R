# Load the data
NEI <- readRDS("summarySCC_PM25.rds")

NEI <- subset(NEI, fips == 24510)

# Calculate total pm 2.5 emission per year
pm25 <- aggregate(Emissions ~ year + type, data = NEI, sum)

# Plot the chart
qplot(year, Emissions, data = pm25, facets = . ~ type)

# Generate png file
dev.copy(device = png, filename = "plot3.png", width = 640, height = 480)
dev.off()
