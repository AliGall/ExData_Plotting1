
## create a data directory for downloading the file
if(!file.exists("data")) {
  dir.create("data")

  ## move into the data directory and download and unzip the file
  setwd("./data")
  fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  download.file(fileURL, destfile="power.zip")
  unzip("power.zip")

  ## get the name of the unzipped file
  myfile <- unzip("power.zip", list=TRUE)$Name

  ## read the unzipped file into a data frame and reformat the relevant columns
  mydf <- read.table(myfile, sep=";", 
                   header=TRUE, 
                   colClasses = c("character", "character", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric" ), 
                   stringsAsFactors = FALSE, 
                   na.strings = "?")
  mydf <- rbind(subset(mydf, mydf$Date=="1/2/2007"), subset(mydf, mydf$Date=="2/2/2007"))
  mydf$DateTime <- as.POSIXct(paste(mydf$Date, mydf$Time), format="%d/%m/%Y %H:%M:%S")
  mydf$Day <- weekdays(as.Date(mydf$Date))

  setwd("..")
}

## Plot 1

png(filename = "plot1.png", width = 480, height = 480)
hist(mydf$Global_active_power, col="red", xlab="Global Active Power(kilowatts)", ylab="Frequency", main="Global Active Power")
dev.off()


## Plot 2

png(filename = "plot2.png")
plot(mydf$DateTime, mydf$Global_active_power, type="l", xlab="", ylab="Global Active Power (kilowatts)")
dev.off()

## Plot 3

png(filename = "plot3.png")
plot(mydf$DateTime, mydf$Sub_metering_1, type="l", xlab="", ylab="Energy sub metering")
points(mydf$DateTime, mydf$Sub_metering_2, type="l", col="red")
points(mydf$DateTime, mydf$Sub_metering_3, type="l", col="blue")
legend("topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col=c("black", "red", "blue"), lty=1, cex=0.8)
dev.off()


## Plot 4

png(filename = "plot4.png")
par(mfrow=c(2,2))
plot(mydf$DateTime, mydf$Global_active_power, type="l", xlab="", ylab="Global Active Power")
plot(mydf$DateTime, mydf$Voltage, type="l", xlab="datetime", ylab="Voltage")
plot(mydf$DateTime, mydf$Sub_metering_1, type="l", xlab="", ylab="Energy sub metering")
points(mydf$DateTime, mydf$Sub_metering_2, type="l", col="red")
points(mydf$DateTime, mydf$Sub_metering_3, type="l", col="blue")
legend("topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col=c("black", "red", "blue"), lty=1, cex=0.8, bty="n")
plot(mydf$DateTime, mydf$Global_reactive_power, type="l", xlab="datetime", ylab="Global_reactive_power")
dev.off()
