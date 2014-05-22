Init <- function(workDirStr="C:/Users/hsofoian/Desktop/DataScience/Course 4 - Exploratory Data Analysis/Explor-Data-Analysis_CourseProj2"){
        setwd(workDirStr)      
}
Init()

NEI <- readRDS("C:/Users/hsofoian/Desktop/DataScience/Course 4 - Exploratory Data Analysis/data/summarySCC_PM25.rds")
SCC <- readRDS("C:/Users/hsofoian/Desktop/DataScience/Course 4 - Exploratory Data Analysis/data/Source_Classification_Code.rds")

# Question #5
# How have emissions from motor vehicle sources changed from 1999-2008 in Baltimore City?

vehicle_sources <- SCC$SCC[(grep("^Mobile...[^Non-]",SCC$EI.Sector))]
baltimore_vehicle_emissions <- subset(NEI, SCC %in% vehicle_sources & fips == "24510")

total_baltimore_vehicle_emissions <- tapply(baltimore_vehicle_emissions$Emissions,baltimore_vehicle_emissions$year,sum)

barplot(total_baltimore_vehicle_emissions, ylab="Emissions (tons)",
        xlab = "year", main="PM25 Emissions from \nMotor Vehicles, Baltimore",
        col="red")

dev.copy(png,"plot5.png", width= 800, height=600)
dev.off()