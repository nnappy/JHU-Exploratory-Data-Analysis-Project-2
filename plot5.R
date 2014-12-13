library(ggplot2)
library(ggthemes)

# read in RDS data
NEI <- readRDS("summarySCC_PM25.rds")

# subset data for motor vehicle emissions in Baltimore City
NEI2 <- NEI[which(NEI$type =="ON-ROAD" & NEI$fips == "24510"),]
NEI2 <- aggregate(Emissions ~ year, NEI2, sum)

# construct plot
png("plot5.png")
g <- ggplot(NEI2, aes(x = year, y = Emissions))
g + geom_line() + scale_x_continuous(breaks = c(1999, 2002, 2005, 2008)) +
labs(title = "Motor Vehicle Emissions in Baltimore City, MD", x = "Year", 
y = "PM 2.5 (in tons)") + theme_tufte()
dev.off()
