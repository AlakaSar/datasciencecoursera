#3.Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable, 
# which of these four sources have seen decreases in emissions from 1999-2008 for Baltimore City? 
# Which have seen increases in emissions from 1999-2008? 
# Use the ggplot2 plotting system to make a plot answer this question.

#Use the base plotting system to make a plot answering this question.
# ANSWER: From the plot, for all types except Point, has decreased overall emissions in Baltimore from 1999 to 2008 
# however for type = Point, emission has risen from 1999 to 2005 and decreased after 2005 
# but the final emission in 2008 is still more than that of 1999 for type = point


## This line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

NEIFIP <- subset (NEI, NEI$fips == 24510)

# Get emissions by year by type
emissionsByTypeAndYear <- aggregate(Emissions ~ type * year, data = NEIFIP, FUN = sum)

## Load libraries required for plot
suppressWarnings(library(ggplot2))
suppressWarnings(library(grid))

# plot 
q <- qplot(y = Emissions, x = year, data = emissionsByTypeAndYear, color = type, facets = . ~ type)

## Add layers
q + scale_x_continuous(breaks = seq(1999, 2008, 3)) + theme_bw() + geom_point(size = 3) + 
  geom_line() + labs(y = "Total PM[2.5]  Emissions (in tons)") + 
  labs(x = "Year") + labs(title = "PM[2.5] Emissions By Type in Baltimore (1999 - 2008)") + 
  theme(axis.text = element_text(size = 8), axis.title = element_text(size = 16), 
        panel.margin = unit(1, "lines"), plot.title = element_text(vjust = 4), 
        legend.title = element_text(size = 11)) + scale_colour_discrete(name = "Type")



# save plot to plot3.png
dev.copy(png,'plot3.png')
dev.off()
