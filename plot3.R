## PLOT 3

# Load and unzip dataframe file
temp <- tempfile()
url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(url = url,method = "curl",destfile = temp)
unzip(zipfile = temp)
unlink(temp)

# Read dataframe, date formatting and date filtering
dataframe <- read.csv(file = "household_power_consumption.txt", sep = ";", dec = ".", header = TRUE, stringsAsFactors = FALSE, na.strings = "?")
dataframe$Date <- as.Date(dataframe$Date, format = "%d/%m/%Y")
dataframe <- dataframe[dataframe$Date >= as.Date("2007-02-01") & dataframe$Date <= as.Date("2007-02-02"),]

dateTime <- paste(dataframe$Date, " ", dataframe$Time)
dateTime <- as.POSIXct(dateTime)

dataframe <- dataframe[,-(1:2)]
dataframe <- cbind(dataframe, dateTime)

# Open PNG device
png("plot3.png", width = 480, height = 480)

# Plotting
with(dataframe, {
    plot(Sub_metering_1~dateTime, type = "l", ylab = "Energy sub metering", xlab = "")
    lines(Sub_metering_2~dateTime, col = "red")
    lines(Sub_metering_3~dateTime, col = "blue")
    legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col = c("black", "red", "blue"), lty = c(1,1,1))
    })

dev.off()
