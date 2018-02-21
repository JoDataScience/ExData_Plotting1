## Load the data
library(dplyr)

## Getting the data
data <- read.table("household_power_consumption.txt", sep = ';', header = TRUE, na.strings = '?')

## Extracting only rows corresponding to dates of interest transforming date and time into POSIXct.
power_consumption <- data %>%
  filter(Date == "1/2/2007" | Date == "2/2/2007") %>%
  mutate(DateTime = as.POSIXct(paste(Date, Time, sep=" "), format = "%d/%m/%Y %H:%M:%S", tz = "")) %>%
  select(-Date, -Time)

# Emptying memory
remove(data)

# Setting up the graphic device
png("plot4.png", width = 480, height = 480)

# Finding date range
daterange=c(as.POSIXlt(min(power_consumption$DateTime)),as.POSIXlt(max(power_consumption$DateTime)))

par(mfcol = c(2,2), mar=c(4,4,2,1), oma = c(0,0,2,0))
with(power_consumption, {
  
  # Plot 1 
  plot(DateTime, Global_active_power, 
       xaxt='n',type = "l", xlab = "", ylab="Global Active Power (kilowatts)")
  axis.POSIXct(1, at=seq(daterange[1], daterange[2] + 60, by="day"), format="%a")
  
  # Plot 2
  plot(DateTime, Sub_metering_1, 
       xaxt='n',type = "l", xlab = "", ylab="Energy sub metering")
  lines(DateTime, Sub_metering_2, xaxt='n', xlab = "", col="red")
  lines(DateTime, Sub_metering_3, xaxt='n', xlab = "",col="blue")
  axis.POSIXct(1, at=seq(daterange[1], daterange[2] + 60, by="day"), format="%a")
  
  # Plot 3
  plot(DateTime, Voltage, 
       xaxt='n',type = "l", xlab = "datetime", ylab="Voltage")
  axis.POSIXct(1, at=seq(daterange[1], daterange[2] + 60, by="day"), format="%a")
  
  # Plot 2 
  plot(DateTime, Global_reactive_power, 
       xaxt='n',type = "l", xlab = "datetime")
  axis.POSIXct(1, at=seq(daterange[1], daterange[2] + 60, by="day"), format="%a")
})

# Closing device
dev.off()