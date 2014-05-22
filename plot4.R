Init <- function(workDirStr="C:/Users/hsofoian/Desktop/DataScience/Course 4 - Exploratory Data Analysis/Explor-Data-Analysis_CourseProj2"){
        setwd(workDirStr)      
}
Init()

NEI <- readRDS("C:/Users/hsofoian/Desktop/DataScience/Course 4 - Exploratory Data Analysis/data/summarySCC_PM25.rds")
SCC <- readRDS("C:/Users/hsofoian/Desktop/DataScience/Course 4 - Exploratory Data Analysis/data/Source_Classification_Code.rds")

# Question #4
# Across the United States, how have emissions from coal combustion-related sources 
# changed from 1999-2008?

# Select all coal related resources from SCC and NEI
coal_sources <- SCC$SCC[(grep("[Cc]omb.*[Cc]oal",SCC$EI.Sector))]
coal_emissions <- subset(NEI, SCC %in% coal_sources)

total_coal_emissions <- tapply(coal_emissions$Emissions,coal_emissions$year,sum)
# 1999     2002     2005     2008 
# 572126.5 546789.2 552881.5 343432.2 
 
par(mar = rep(2, 4))

#plot
barplot(total_coal_emissions, ylab="Emissions (tons)",
        xlab = "year", main="PM25 Emissions from \nCoal Combustion, US",
        col="blue")

library(reshape2)

# Change!
geography <- melt(coal_emissions, id=c("fips","year"), measure.vars="Emissions")
geography <- dcast(geography, fips ~ year,sum)

regr <- integer(0)
for (i in 1:length(geography[,1])){
        a <- lm(as.numeric(geography[i,2:5]) ~ as.numeric(colnames(geography[2:5])))
        regr[i] <- a$coefficients[2]
}

geography$coefficients9908 <- regr
geography$change9908 <- ifelse(geography$coefficients9908 == 0, 'No Change',
                               ifelse(geography$coefficients9908 > 0, 'Increase', 'Decrease'))
barplot(table(geography$change9908), ylab="Number of counties",
        main="Change in coal cobustion-related emissions \n1999-2008, US counties", xlab="Change based on slope of lin.regr. over (1999,2002,2005,2008)", col="blue")

dev.copy(png,"plot4.png",width=800, height=600)
dev.off()