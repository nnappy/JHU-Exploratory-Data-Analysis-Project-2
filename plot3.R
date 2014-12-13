library(ggplot2)

# read in RDS data
NEI <- readRDS("summarySCC_PM25.rds")

# subset Baltimore City, MD data and aggregate by year/type
baltimore <- NEI[which(NEI$fips == "24510"),]
baltimore_emissions <- aggregate(Emissions ~ year + type, baltimore, sum)

# construct plot
png("plot3.png", width = 650, height = 520)
g <- ggplot(baltimore_emissions, aes(x = year, y = Emissions))
g + geom_line(aes (color = type, group = type))  + labs(
title = "Emissions by source in Baltimore, MD", x = "Year", y = 
"PM 2.5 (in tons)") + scale_x_continuous(breaks = c(1999, 2002, 2005, 2008))
dev.off()


# an alternative plot using faceting
# g + geom_line(aes (color = type)) + facet_wrap(~type) + labs(
# title = "PM 2.5 Emissions by source in Baltimore, MD", x = "Year", y = 
# "Emissions (in tons)") + scale_x_continuous(breaks = c(1999, 2002, 2005, 2008))