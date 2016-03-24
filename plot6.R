#6.Compare emissions from motor vehicle sources in Baltimore City with emissions 
#from motor vehicle sources in Los Angeles County, California (fips == "06037"). 
#Which city has seen greater changes over time in motor vehicle emissions?
# ANSWER: From the plot, it appears that Baltimore had more decrease over time.  
# LA's emission has actually gone a bit higher than in 1999 but the trend good since 2005.

## This line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#find unique coal sources from unique(SCC$EI.Sector)

## Find all the motor vehicle sources from 'SCC'
motorVehicleSourceDesc <- unique(grep("Vehicles", SCC$EI.Sector, ignore.case = TRUE, value = TRUE))
motorVehicleSourceCodes <- SCC[SCC$EI.Sector %in% motorVehicleSourceDesc, ]["SCC"]


## Subset emissions due to motor vehicle sources from 'NEI' for Los Angeles
## and combine it with the data from Baltimore
emissionFromMotorVehiclesInBaltimore <- NEI[NEI$SCC %in% motorVehicleSourceCodes$SCC & NEI$fips == "24510", ]
emissionFromMotorVehiclesInLosAngeles <- NEI[NEI$SCC %in% motorVehicleSourceCodes$SCC & NEI$fips == "06037", ]
emissionFromMotorVehicles <- rbind(emissionFromMotorVehiclesInBaltimore, emissionFromMotorVehiclesInLosAngeles)

## Calculate the emissions due to motor vehicles in Baltimore and Los Angeles
## for every year
totalMotorEmissionsByYearCounty <- aggregate(Emissions ~ fips * year, data = emissionFromMotorVehicles, FUN = sum)
totalMotorEmissionsByYearCounty$county <- ifelse(totalMotorEmissionsByYearCounty$fips == "06037", "Los Angeles", "Baltimore")

## Load libraries required for plot
suppressWarnings(library(ggplot2))
suppressWarnings(library(grid))

## Setup ggplot with data frame
q <- qplot(y = Emissions, x = year, data = totalMotorEmissionsByYearCounty, color = county)

## Add layers
q + scale_x_continuous(breaks = seq(1999, 2008, 3)) + theme_bw() + geom_point(size = 3) + 
  geom_line() + labs(y = "Motor Vehicle Related PM[2.5]  Emissions (in tons)") + 
  labs(x = "Year") + labs(title = "Motor Vehicle Related PM[2.5] Emissions in Baltimore & LA (1999 - 2008)") + 
  theme(axis.text = element_text(size = 8), axis.title = element_text(size = 16), 
        panel.margin = unit(1, "lines"), plot.title = element_text(vjust = 4, hjust=.17, size=12), 
        legend.title = element_text(size = 11)) + scale_colour_discrete(name = "County")


# save plot to plot6.png
dev.copy(png,'plot6.png')
dev.off()
