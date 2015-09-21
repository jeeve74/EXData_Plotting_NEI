library(dplyr)
# set directory to folder where files are locationed (summarySCC_PM25.rds and Source_Classification_Code.rds)
nei.directory <- "C:/github/ExData_Plotting_NEI"
setwd(nei.directory)

fileURL <- 'https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip' 
download.file(fileURL, destfile = './NEI.zip') 
unzip('NEI.zip')

## Read in the data. The first file will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")

## Summarize the Emissions data by year
BC <- subset(NEI,fips == "24510")
BC.Emissions.Year <- BC %>% group_by(year) %>% summarize(TotalEmissions=sum(Emissions)) 

# Create the png file
png(filename="./plot2.png",width=480,height=480,units="px")

#Plot the data
with(BC.Emissions.Year,plot(year,TotalEmissions,xlab='Year',ylab='Total Emissions'))
with(BC.Emissions.Year, points(year, TotalEmissions, pch = 19))
with(BC.Emissions.Year, lines(year, TotalEmissions, type='l'))
title(main='Total PM2.5 Emissions From All Sources \nin Baltimore City, Maryland by Year')

## clean up the memory and close off the graphic device
bb <- rm(list=ls())
bb <- dev.off()
