#4.Across the United States, how have emissions from coal combustion-related sources changed from 1999-2008?

# ANSWER: From the plot, it is clear that emissions  from coal combustion-related sources have decreased in 
# United States from 1999 to 2008 
# However, emission has slightly increased from 2002 to 2005 and then steeply decresed. 


## This line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#find unique coal sources from unique(SCC$EI.Sector)

## Find all the coal combustion related sources from 'SCC'
CoalCombustionSources <- SCC[SCC$EI.Sector == "Fuel Comb - Comm/Institutional - Coal", ]["SCC"]

## Subset emissions due to coal combustion sources from 'NEI'
emissionFromCoal <- NEI[NEI$SCC %in% CoalCombustionSources$SCC, ]

## Calculate the emissions due to coal each year across United States
totalCoalEmissionsByYear <- tapply(emissionFromCoal$Emissions, emissionFromCoal$year, 
                                   sum)

## Create the plot
plot(totalCoalEmissionsByYear, x = names(totalCoalEmissionsByYear), type = "l", 
     axes = FALSE, ylab = "Coal Related PM[2.5]  Emission (in tons)", 
     xlab = "Year", main = "Coal Related PM[2.5] Emission across United States (1999 - 2008)")
points(totalCoalEmissionsByYear, x = names(totalCoalEmissionsByYear), pch = 20)
lines(totalCoalEmissionsByYear, x = names(totalCoalEmissionsByYear), col = "green")
axis(2)

# x axis for each given year
axis(side = 1, at = seq(1999, 2008, by = 3))

# draw a box around the graph
box()
# save plot to plot4.png
dev.copy(png,'plot4.png')
dev.off()
