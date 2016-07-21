## create a folder to work from
setwd("/ExploratoryDataAnalysis/week1")
if(!file.exists("./temp")){dir.create("./temp")}

## fetching the data and unzip data
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
temp <- tempfile()
download.file(fileUrl, destfile = ("./temp/ElectricConsumption.zip"))
unzip(zipfile = "./temp/ElectricConsumption.zip", exdir = "./temp")
unlink(temp)

## read all data
setwd("/ExploratoryDataAnalysis/week1/temp")
allData_df <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", na.strings = "?", stringsAsFactors = FALSE)

## convert the date and time variables to Date class
allData_df$DateTime <- paste(allData_df$Date, allData_df$Time)
allData_df$DateTime <- as.Date(allData_df$DateTime, format = "%d/%m/%Y %H:%M:%S")

## filter by dates "2007-02-01" and "2007-02-02"
library(dplyr)
dataFeb <- filter(allData_df, DateTime >= as.Date("2007-02-01 00:00:00"), DateTime < as.Date("2007-02-03 00:00:00"))

## plot 1
png("plot1.png")
hist(dataFeb$Global_active_power, main = "Global Active Power", xlab = "Global Active Power (kilowatts)", col = "red")
dev.off()