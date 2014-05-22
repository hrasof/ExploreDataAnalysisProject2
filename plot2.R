Init <- function(workDirStr="C:/Users/hsofoian/Desktop/DataScience/Course 4 - Exploratory Data Analysis/Explor-Data-Analysis_CourseProj2"){
        setwd(workDirStr)      
}
Init()

NEI <- readRDS("C:/Users/hsofoian/Desktop/DataScience/Course 4 - Exploratory Data Analysis/data/summarySCC_PM25.rds")
SCC <- readRDS("C:/Users/hsofoian/Desktop/DataScience/Course 4 - Exploratory Data Analysis/data/Source_Classification_Code.rds")

# Question #2
# Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (fips == "24510") from 1999 to 2008? 
# Use the base plotting system to make a plot answering this question.

NEI_baltimore <- subset(NEI, fips == "24510")
emission_baltimore <- tapply(NEI_baltimore$Emissions,NEI_baltimore$year,sum)

# Line
years <- names(emission_baltimore)
plot(years,emission_baltimore, type="l", lty=1, lwd=2, col="blue", ylim=c(0,max(emission_baltimore)), ylab="Emissions (tons)", xlab = "year", main=expression("PM25 Emissions, Baltimore"))
points(years,emission_baltimore, pch=19, col="blue")

# Linear Regression
years <- as.numeric(dimnames(emission_baltimore)[[1]])
model <- lm(emission_baltimore ~ years)
abline(model, lwd=2, col="red", lty=2)
legend("bottomleft", legend=c("PM25 Emissions (tons)","Linear regression"), lwd=c(2,2), lty=c(1,2), col=c("blue","red"))

# Create .png
dev.copy(png,"plot2.png", width=800, height=600)
dev.off()