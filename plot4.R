library(ggplot2)

# read in RDS data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# subset data pertaining to "coal combustion-related sources".  A great deal
# of time could be spent perusing the EPA documentation to determine which
# columns of the SCC data set constitute these sources precisely. To simplify
# my analysis and because I think the purpose of the exercise is to demonstrate
# knowlege of R's plotting system and the intuition behind an analysis I've
# chosen to simply search the SCC column "Short.Name" for the string "coal".
# One could easily add the term "combustion", "comb", or search other columns
# in the SCC data set for those terms with different results.
SCC <- SCC[grep("coal", SCC$Short.Name, ignore.case = T),]
NEI <- NEI[which(NEI$SCC %in% SCC$SCC),]

# sum coal emission data by year
NEI.coal <- aggregate(Emissions ~ year, NEI, sum)

# construct plot
png("plot4.png")
g <- ggplot(NEI.coal, aes(x = as.factor(year), y = Emissions/1000, fill = 
as.factor(year)))
g + geom_bar(stat = "identity") + labs(title = "Emissions from U.S. Coal 
Combustion-Related Sources", x = "Year", y = "PM 2.5 (in thousands of tons)"
) + scale_y_continuous(limits=c(0,625)) + guides(fill = FALSE)
dev.off()
