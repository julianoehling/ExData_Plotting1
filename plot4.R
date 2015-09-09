## Creates the fourth plot for the Coursera Course Project 1 in Exploratory Data Analysis
## CAUTION dplyr package required!

## The URL as given in the task
url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

## Downloads the zip file from the given URL
download.file(url,destfile="power.zip",mode="wb")

## Unzips the data
unzip(zipfile = "power.zip")

## Reads in the unzipped text file containing the actual data
pc <- read.table("household_power_consumption.txt", sep=";")

## Changes the first column into Date format
pc$V1 <- as.Date(pc$V1, "%d/%m/%Y")

## Reduces the data to two days
feb_global <- subset(pc, V1 == "2007-02-01" | V1 == "2007-02-02", V1:V9)

## Loads dplyr package
library("dplyr")

## Combines date and time in new coloumn and formats it to POSIXct
feb_global <- mutate(feb_global, date = as.POSIXct(paste(V1, V2, sep=" "), format = "%Y-%m-%d %H:%M:%S"))

## Extracts numeric values
feb_global$V4 <- as.numeric(levels(feb_global$V4))[feb_global$V4]
feb_global$V5 <- as.numeric(levels(feb_global$V5))[feb_global$V5]
feb_global$V7 <- as.numeric(levels(feb_global$V7))[feb_global$V7]
feb_global$V8 <- as.numeric(levels(feb_global$V8))[feb_global$V8]
feb_global$V9 <- as.numeric(levels(feb_global$V9))[feb_global$V9]

## Creates a PNG graphic device with given size
png(filename = "plot4.PNG", width =480, height=480)

## Creates a four plot layout
par(mfcol=c(2,2))

## Plots upper left plot
plot(feb_global$date, feb_global$V3, type ="n", xlab="", ylab = "Global Active Power (kilowatts)")
lines(feb_global$date, feb_global$V3)

## Plots lower left plot
plot(feb_global$date, feb_global$V7, type ="n", xlab="", ylab = "Energy Sub Metering")
lines(feb_global$date, feb_global$V7, col = "BLACK")
lines(feb_global$date, feb_global$V8, col = "RED")
lines(feb_global$date, feb_global$V9, col = "BLUE")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=1, col=c("BLACK","RED","BLUE"),box.lty=0,bg="transparent")

## Plots upper right plot
plot(feb_global$date, feb_global$V5, type ="n", xlab="datetime", ylab = "Voltage")
lines(feb_global$date, feb_global$V5)

## Plots lower right plot
plot(feb_global$date, feb_global$V4, type ="n", xlab="datetime", ylab = "Global_reactive_power")
lines(feb_global$date, feb_global$V4)

## Ends the PNG graphic device
dev.off()
