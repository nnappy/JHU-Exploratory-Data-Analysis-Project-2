library(ggplot2)

# read in RDS data
NEI <- readRDS("summarySCC_PM25.rds")

# subset data for motor vehicle emissions in LA and Baltimore
NEI2 <- NEI[which(NEI$type == "ON-ROAD" & (NEI$fips == "24510" | NEI$fips == 
                      "06037")),]

# group emissions by year and city
NEI2 <- aggregate(Emissions ~ year + fips, NEI2, sum)
NEI2$fips <- factor(NEI2$fips, levels = c("06037", "24510"), labels = 
c("Los Angeles, CA", "Baltimore, MD"))
names(NEI2)[names(NEI2) == "fips"] <- "City"

# construct plot
png("plot6.png", width = 672, height = 412)
g <- ggplot(NEI2, aes(x = year, y = Emissions))
g + geom_line(aes(color = City)) + geom_point(shape = 7) + labs(x = "Year", y = "PM 2.5 (in tons)",
title = "Emissions from Motor Vehicle Sources") + scale_x_continuous(breaks =
c(1999, 2002, 2005, 2008))
dev.off()