#install.packages("dplyr")
library(dplyr)
library(ggplot2)
# set directory to folder where files are locationed (summarySCC_PM25.rds and Source_Classification_Code.rds)
nei.directory <- "C:/github/ExData_Plotting_NEI"
setwd(nei.directory)

fileURL <- 'https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip' 
download.file(fileURL, destfile = './NEI.zip') 
unzip('NEI.zip')

## Read in the data. The first file will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS(("Source_Classification_Code.rds"))

## Get Coal Combustion related SCC values
SCC.Coal <- SCC[grepl("Coal", SCC$EI.Sector, ignore.case = TRUE),]

## Merge the dataset to get only emissions related to coal combustion. Then summarize by year
NEI.Coal <- merge(NEI, SCC.Coal, by = 'SCC')
NEI.Coal.Year <- NEI.Coal %>% group_by(year) %>% summarize(TotalEmissions=sum(Emissions)) 

# Create the png file
png(filename="./plot4.png",width=480,height=480,units="px")

#Plot the data
p <- qplot(year,TotalEmissions,data=NEI.Coal.Year)
p + geom_line() + xlab("Year") + ylab("Total PM2.5 Emitted (tons)") + 
        ggtitle("Total Emissions Related to Coal Combustion By Year") 

## clean up the memory and close off the graphic device
bb <- rm(list=ls())
bb <- dev.off()
