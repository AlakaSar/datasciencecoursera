#5.How have emissions from motor vehicle sources changed from 1999-2008 in Baltimore City?

# ANSWER: From the plot, it is clear that emissions  from Motor vehicle  sources have decreased in 
# Baltimore from 1999 to 2008 , the decrease has been rapid from 1999 to 2002.


## This line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#find unique coal sources from unique(SCC$EI.Sector)

## Find all the motor vehicle sources from 'SCC'
motorVehicleSourceDesc <- unique(grep("Vehicles", SCC$EI.Sector, ignore.case = TRUE, value = TRUE))
motorVehicleSourceCodes <- SCC[SCC$EI.Sector %in% motorVehicleSourceDesc, ]["SCC"]


## Subset emissions due to motor vehicle sources in from 'NEI' for Baltimore
emissionMotorVehiclesFIPS <- NEI[NEI$SCC %in% motorVehicleSourceCodes$SCC & NEI$fips == "24510", ]

## Calculate the emissions due to coal each year across United States
totalVehicleEmissionsByYear <- tapply(emissionMotorVehiclesFIPS$Emissions, emissionMotorVehiclesFIPS$year,sum)

## Create the plot
plot(totalVehicleEmissionsByYear, x = names(totalVehicleEmissionsByYear), type = "l", 
     axes = FALSE, ylab = "Motor vehicle Related PM[2.5]  Emission (in tons)", 
     xlab = "Year", main = "Motor vehicle  PM[2.5] Emission in Baltimore United States (1999 - 2008)")
points(totalVehicleEmissionsByYear, x = names(totalVehicleEmissionsByYear), pch = 20)
lines(totalVehicleEmissionsByYear, x = names(totalVehicleEmissionsByYear), col = "green")
axis(2)

# x axis for each given year
axis(side = 1, at = seq(1999, 2008, by = 3))

# draw a box around the graph
box()
# save plot to plot5.png
dev.copy(png,'plot5.png')
dev.off()
