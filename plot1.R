library(dplyr)
# set directory to folder where files are locationed (summarySCC_PM25.rds and Source_Classification_Code.rds)
nei.directory <- "C:/github/ExData_Plotting_NEI"
setwd(nei.directory)

fileURL <- 'https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip' 
download.file(fileURL, destfile = './NEI.zip') 
unzip('NEI.zip')

## Read in the data. This will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")

## Summarize the Emissions data by year
NEI.Emissions.Year <- NEI %>% group_by(year) %>% summarize(TotalEmissions=sum(Emissions)) 

# Create the png file
png(filename="./plot1.png",width=480,height=480,units="px")

#Plot the data
with(NEI.Emissions.Year,plot(year,TotalEmissions,xlab='Year',ylab='Total PM2.5 Emitted (tons)'))
with(NEI.Emissions.Year, points(year, TotalEmissions, pch = 19))
with(NEI.Emissions.Year, lines(year, TotalEmissions, type='l'))
title(main='Total PM2.5 Emissions From All Sources by Year')

## clean up the memory and close off the graphic device
bb <- rm(list=ls())
bb <- dev.off()
