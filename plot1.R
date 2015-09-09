## Creates the first plot for the Coursera Course Project 1 in Exploratory Data Analysis

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

## Reduces the data to the Global Active Power coloumn from two days
feb_global <- subset(pc, V1 == "2007-02-01" | V1 == "2007-02-02", V3)

## Extracts numeric values
feb_global <- as.numeric(levels(feb_global$V3))[feb_global$V3]

## Creates a PNG graphic device with given size
png(filename = "plot1.PNG", width =480, height=480)

## Plots the Histogramm
hist(feb_global, col="RED", main="Global Active Power", xlab ="Global Active Power (kilowatts)")

## Ends the PNG graphic device
dev.off()
