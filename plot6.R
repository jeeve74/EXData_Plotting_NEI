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


## Subset data for Balitmore City and Los Angeles
Cities <- subset(NEI,fips == "24510" | fips == "06037")

## Get Motor Vehicle related SCC values
SCC.Vehicle <- SCC[grepl("Vehicles", SCC$SCC.Level.Two, ignore.case = TRUE),]

## Merge the dataset to get only emissions related to motor vehicles in Baltimore City. Then summarize by year
Cities.Vehicle <- merge(Cities, SCC.Vehicle, by = 'SCC')
Cities.Vehicle.Year <- Cities.Vehicle %>% group_by(year,fips) %>% summarize(TotalEmissions=sum(Emissions)) 

## Create City/fips data frame
City <- rbind.data.frame(c("Baltimore City","24510" ),c("Los Angeles County","06037"))
names(City) <- c("City","fips")

## Merge City with summarized data
City.Vehicle.Year <- merge(Cities.Vehicle.Year, City, by = 'fips')

# Create the png file
png(filename="./plot6.png",width=480,height=480,units="px")

#Plot the data
g <- ggplot(data=City.Vehicle.Year, aes(x=year,y=TotalEmissions))
g + geom_point() + facet_grid(. ~ City) + geom_smooth(method = "lm") +
        labs(x="Year") + labs(y="Total PM2.5 Emitted (tons)") + 
        labs(title="Total Emissions in Baltimore City \nby Year and City") + 
        scale_color_discrete(name="City")

## clean up the memory and close off the graphic device
bb <- rm(list=ls())
bb <- dev.off()
