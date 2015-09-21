# set directory to folder where files are locationed (summarySCC_PM25.rds and Source_Classification_Code.rds)
nei.directory <- "C:/github/ExData_Plotting_NEI"
setwd(nei.directory)

fileURL <- 'https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip' 
download.file(fileURL, destfile = './NEI.zip') 
unzip('NEI.zip')

## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")


head(NEI,10)
head(SCC,1)
names(SCC)

SCC[1,1]


# read from source file 
power.class <- c(rep("character",2),rep("numeric",7))
power.data <- read.table("household_power_consumption.txt",header=TRUE,
                         sep=";",na.strings="?",colClasses=power.class)

# limit the data to 2 days 
power.data <- power.data[power.data$Date=="1/2/2007" | power.data$Date=="2/2/2007",]

# setup a Datetime column
Datetime <- as.POSIXct(strptime(paste(power.data$Date,power.data$Time),"%d/%m/%Y %H:%M:%S"))
power.data <- transform(power.data, Date = as.Date(Date,format="%d/%m/%Y") )
power.data <- cbind(power.data,Datetime)

# tidy up the data
power.columns <- c("Date","Time","GlobalActivePower","GlobalReactivePower","Voltage","GlobalIntensity",
                   "SubMetering1","SubMetering2","SubMetering3","Datetime")
colnames(power.data) <- power.columns

# setup the png file and create graphic
png(filename="./plot1.png",width=480,height=480,units="px")