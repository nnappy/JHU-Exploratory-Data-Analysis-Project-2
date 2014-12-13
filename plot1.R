# read in RDS data
NEI <- readRDS("summarySCC_PM25.rds")

# aggregate emissions data by year
emissions_year <- aggregate(Emissions ~ year, NEI, sum)

# construct plot
png("plot1.png")
with(emissions_year, barplot(Emissions/1000000, names.arg = year, 
xlab = "Year Recorded", ylab = "PM 2.5 (in millions of tons)", 
main = "Total PM 2.5 Emissions in the US", ylim = c(0, 8), 
col = "cornflowerblue"))
dev.off()
