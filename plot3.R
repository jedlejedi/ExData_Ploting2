library(ggplot2)

# Load the data
NEI <- readRDS("summarySCC_PM25.rds")

NEI <- subset(NEI, fips == 24510)

# Calculate total pm 2.5 emission per year
pm25 <- aggregate(Emissions ~ year + type, data = NEI, sum)

# Plot the chart
ggplot(data = pm25, aes(x = factor(year), y = Emissions), xlab()) + 
  geom_bar(stat = "identity") + 
  facet_grid(. ~ type) +
  xlab("Year") +
  ylab("PM2.5 Emissions (tons)") +
  ggtitle("PM2.5 Emissions in Baltimore City by Source Type")

# Generate png file
dev.copy(device = png, filename = "plot3.png", width = 640, height = 480)
dev.off()
