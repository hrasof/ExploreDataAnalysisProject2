Init <- function(workDirStr="C:/Users/hsofoian/Desktop/DataScience/Course 4 - Exploratory Data Analysis/Explor-Data-Analysis_CourseProj2"){
        setwd(workDirStr)      
}
Init()

NEI <- readRDS("C:/Users/hsofoian/Desktop/DataScience/Course 4 - Exploratory Data Analysis/data/summarySCC_PM25.rds")
SCC <- readRDS("C:/Users/hsofoian/Desktop/DataScience/Course 4 - Exploratory Data Analysis/data/Source_Classification_Code.rds")

# Question #5
# Compare emissions from motor vehicle sources in Baltimore City with emissions from motor vehicle sources in Los Angeles County, 
# California (fips == "06037"). 
# Which city has seen greater changes over time in motor vehicle emissions?

vehicle_sources <- SCC$SCC[(grep("^Mobile...[^Non-]",SCC$EI.Sector))]
balt_LA_vehicle_emissions <- subset(NEI, SCC %in% vehicle_sources & (fips == "24510" | fips == "06037"))

structure <- melt(balt_LA_vehicle_emissions,id = c("year","fips"), measure.vars="Emissions")
aggregated <- dcast(structure,fips + year ~ variable, sum)
aggregated$fips <- as.factor(aggregated$fips)
levels(aggregated$fips) <- c("Los Angeles","Baltimore")

library(ggplot2)
qplot(year, Emissions, data=aggregated, facets=.~fips, main="PM25 Emissions from Motor Vehicles, Los Angeles vs. Baltimore") + geom_smooth(method="lm") + ylab("PM25 Emissions from Motor Vehicles (tons)")

dev.copy(png,"plot6.png", width=800, height=600)
dev.off()