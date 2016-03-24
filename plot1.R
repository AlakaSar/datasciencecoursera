#1.Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? 

# ANSWER: From the plot, the emissions have decreased in US from 1999 to 2008

#Using the base plotting system, make a plot showing the total PM2.5 emission from all sources 
#for each of the years 1999, 2002, 2005, and 2008.

## This line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## Calculate total PM2.5 emissions by year
totalPM25ByYear <- tapply(NEI$Emissions, NEI$year, sum)

## Create a plot
plot(totalPM25ByYear, x = names(totalPM25ByYear), type = "l", axes = FALSE, 
    ylab = "Total PM[2.5]  Emission (in tons)", xlab = "Year", 
    main = "Total PM[2.5] Emission (1999 - 2008)")
points(totalPM25ByYear, x = names(totalPM25ByYear), pch = 20)
#draw a line to show the trend clearly
lines(totalPM25ByYear, x = names(totalPM25ByYear), col = "green")
axis(2)
#add x axis for the given years
axis(side = 1, at = seq(1999, 2008, by = 3))
#Draw a box around the plot
box()
# save plot to plot1.png
dev.copy(png,'plot1.png')
dev.off()
