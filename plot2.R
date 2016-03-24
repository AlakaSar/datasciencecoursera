#2.Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (fips == "24510")
#from 1999 to 2008? 
#Use the base plotting system to make a plot answering this question.
# ANSWER: From the plot, overall emissions have decreased in Baltimore from 1999 to 2008 
# however they were on the rise from 2002 to 2005 and have steadily decreased from 2005 to 2008


## This line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

NEIFIP <- subset (NEI, NEI$fips == 24510)

## Calculate total PM2.5 emissions by year
totalPM25ByYear <- tapply(NEIFIP$Emissions, NEIFIP$year, sum)

## Create a plot
plot(totalPM25ByYear, x = names(totalPM25ByYear), type = "l", axes = FALSE, 
    ylab = "Total PM[2.5]  Emission (in tons)", xlab = "Year", 
    main = "Total PM[2.5] Emission (1999 - 2008) in Baltimore")
points(totalPM25ByYear, x = names(totalPM25ByYear), pch = 20)
#draw a line to show the trend clearly
lines(totalPM25ByYear, x = names(totalPM25ByYear), col = "green")
axis(2)
#add x axis for the given years
axis(side = 1, at = seq(1999, 2008, by = 3))
#Draw a box around the plot
box()
# save plot to plot2.png
dev.copy(png,'plot2.png')
dev.off()
