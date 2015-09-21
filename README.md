# ExData_Plotting_NEI
The data for this assignment can be downloaded using the following code

fileURL <- 'https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip' 
download.file(fileURL, destfile = './NEI.zip') 
unzip('NEI.zip')

Using the data identified above, the following questions/tasks will be answered.

###plot1.R
Q: Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? 
A: Yes
Using the base plotting system, make a plot showing the total PM2.5 emission from all sources for each of the years 1999, 2002, 2005, and 2008.

##plot2.R
Q: Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (fips == "24510") from 1999 to 2008? 
A: Yes, but there was a spike in 2005
Use the base plotting system to make a plot answering this question.

##plot3.R
Q: Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable, 
which of these four sources have seen decreases in emissions from 1999–2008 for Baltimore City? 
A: 
Q: Which have seen increases in emissions from 1999–2008? 
A:
Use the ggplot2 plotting system to make a plot answer this question.

* Across the United States, how have emissions from coal combustion-related sources changed from 1999–2008?

* How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City?

* Compare emissions from motor vehicle sources in Baltimore City with emissions from motor vehicle sources in Los Angeles County, 
California (fips == "06037"). 
Which city has seen greater changes over time in motor vehicle emissions?