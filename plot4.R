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

## filter by dates 2007-02-01 and 2007-02-02
library(dplyr)
dataFeb <- filter(allData_df, DateTime >= as.Date("2007-02-01 00:00:00"), DateTime < as.Date("2007-02-03 00:00:00"))

## plot 4
png("plot4.png")
par(mfrow=c(2,2))
plot(dataFeb$Global_active_power, xaxt = "n", type = "l", xlab = "", ylab = "Global Active Power(kilowatts)")
at <- seq(from = 0, to = 2880, by = 1440)
axis(side = 1, at = at, labels = c("Thu", "Fri", "Sat"))

plot(dataFeb$Voltage, xaxt = "n", type = "l", col = "black", xlab = "datetime", ylab = "Voltage")
axis(side = 1, at = at, labels = c("Thu", "Fri", "Sat"))

plot(dataFeb$Sub_metering_1, type = "l", xaxt = "n", col = "black", xlab = "", ylab = "Energy sub metering")
lines(dataFeb$Sub_metering_2, col = "red")
lines(dataFeb$Sub_metering_3, col = "blue")
axis(side = 1, at = at, labels = c("Thu", "Fri", "Sat"))
legend("topright", c("Sub_metering_1","Sub_metering_2", "Sub_metering_3"),col=c("black","red", "blue"), horiz=FALSE, lty=c(1,1), cex=0.8, box.lty=0)

plot(dataFeb$Global_reactive_power, xaxt = "n", type = "l", xlab = "datetime", ylab = "Global_reactive_power")
axis(side = 1, at = at, labels = c("Thu", "Fri", "Sat"))
dev.off()