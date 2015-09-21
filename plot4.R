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

BC <- subset(NEI,fips == "24510")
BC.Emissions.Year <- BC %>% group_by(year,type) %>% summarize(TotalEmissions=sum(Emissions)) 

# Create the png file
png(filename="./plot4.png",width=480,height=480,units="px")

#Plot the data
p <- qplot(year,TotalEmissions,data=BC.Emissions.Year,color=BC.Emissions.Year$type)
p + geom_line() + xlab("Year") + ylab("Total Emissions") + 
        ggtitle("Total Emissions in Baltimore City by Year and Type") +
        scale_color_discrete(name="Type")

## clean up the memory and close off the graphic device
bb <- rm(list=ls())
bb <- dev.off()
