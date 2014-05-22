Init <- function(workDirStr="C:/Users/hsofoian/Desktop/DataScience/Course 4 - Exploratory Data Analysis/Explor-Data-Analysis_CourseProj2"){
        setwd(workDirStr)      
}
Init()

# NEI - National Emissions Inventory
NEI <- readRDS("C:/Users/hsofoian/Desktop/DataScience/Course 4 - Exploratory Data Analysis/data/summarySCC_PM25.rds")

# # SCC - Source Classification Code
SCC <- readRDS("C:/Users/hsofoian/Desktop/DataScience/Course 4 - Exploratory Data Analysis/data/Source_Classification_Code.rds")

names(NEI)
# [1] "fips"      "SCC"      
# [3] "Pollutant" "Emissions"
# [5] "type"      "year"


name(SCC)  
# [1] "SCC"                
# [2] "Data.Category"      
# [3] "Short.Name"         
# [4] "EI.Sector"          
# [5] "Option.Group"       
# [6] "Option.Set"         
# [7] "SCC.Level.One"      
# [8] "SCC.Level.Two"      
# [9] "SCC.Level.Three"    
# [10] "SCC.Level.Four"     
# [11] "Map.To"             
# [12] "Last.Inventory.Year"
# [13] "Created_Date"       
# [14] "Revised_Date"       
# [15] "Usage.Notes" 

# Question #1
# Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? Using the base plotting system, 
# make a plot showing the total PM2.5 emission from all sources for each of the years 1999, 2002, 2005, and 2008


emission_total <- tapply(NEI$Emissions,NEI$year,sum)
barplot(emission_total, ylab="Emissions (tons)",
        xlab = "year", main="PM25 Total Emissions in the US", col="red")

# Create .png
dev.copy(png,"plot1.png", width=800, height=600)
dev.off()

