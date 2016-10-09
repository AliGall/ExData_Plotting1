## create a data directory for downloading the file
if(!file.exists("power_data")) {
  dir.create("power_data")

  ## move into the data directory and download and unzip the file
  setwd("./power_data")
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

