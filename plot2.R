## Creates the second plot for the Coursera Course Project 1 in Exploratory Data Analysis
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

## Reduces the data to three coloumns from two days
feb_global <- subset(pc, V1 == "2007-02-01" | V1 == "2007-02-02", V1:V3)

## Loads dplyr package
library("dplyr")

## Combines date and time in new coloumn and formats it to POSIXct
feb_global <- mutate(feb_global, date = as.POSIXct(paste(V1, V2, sep=" "), format = "%Y-%m-%d %H:%M:%S"))

## Extracts numeric values
feb_global$V3 <- as.numeric(levels(feb_global$V3))[feb_global$V3]

## Creates a PNG graphic device with given size
png(filename = "plot2.PNG", width =480, height=480)

## Plots the basic graph
plot(feb_global$date, feb_global$V3, type ="n", xlab="", ylab = "Global Active Power (kilowatts)")

## Plots the line
lines(feb_global$date, feb_global$V3)

## Ends the PNG graphic device
dev.off()
