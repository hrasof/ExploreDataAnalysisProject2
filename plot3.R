Init <- function(workDirStr="C:/Users/hsofoian/Desktop/DataScience/Course 4 - Exploratory Data Analysis/Explor-Data-Analysis_CourseProj2"){
        setwd(workDirStr)      
}
Init()

NEI <- readRDS("C:/Users/hsofoian/Desktop/DataScience/Course 4 - Exploratory Data Analysis/data/summarySCC_PM25.rds")
SCC <- readRDS("C:/Users/hsofoian/Desktop/DataScience/Course 4 - Exploratory Data Analysis/data/Source_Classification_Code.rds")

# Question #3
# Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable, which of 
# these four sources have seen decreases in emissions from 1999-2008 for Baltimore City? Which have seen 
# increases in emissions from 1999-2008? Use the ggplot2 plotting system to make a plot answer this question.
library(reshape2)

NEI_baltimore <- subset(NEI, fips == "24510")

structured <- melt(NEI_baltimore,id = c("year","type"), measure.vars="Emissions")
castcaded <- dcast(structured,year + type ~ variable, sum)

#plot 
library(ggplot2)
qplot(year, Emissions, data=castcaded, facets=.~type, ylab="PM25 Emissions (tons)", main="PM25 Emissions by type of source, Baltimore") + geom_smooth(method="lm")

#save plot to png
dev.copy(png,"plot3.png", width=800, height=600)
dev.off()
