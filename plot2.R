# read in RDS data
NEI <- readRDS("summarySCC_PM25.rds")

# subset Baltimore City, MD data and aggregate by year
baltimore <- NEI[which(NEI$fips == "24510"),]
baltimore_emissions <- aggregate(Emissions ~ year, baltimore, sum)

# construct plot
png("plot2.png")
with(baltimore_emissions, barplot(Emissions, names.arg = year, 
xlab = "Year Recorded", ylab = "PM 2.5 (in tons)", 
main = "Total PM 2.5 Emissions in Baltimore, MD", ylim = c(0, 4000), 
col = "chocolate1"))
dev.off()