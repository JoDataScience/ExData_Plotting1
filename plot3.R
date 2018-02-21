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
png("plot3.png", width = 480, height = 480)
plot.new()

# Finding date range
daterange=c(as.POSIXlt(min(power_consumption$DateTime)),as.POSIXlt(max(power_consumption$DateTime)))

# Plotting
plot(power_consumption$DateTime, power_consumption$Sub_metering_1, 
     xaxt='n',type = "l", xlab = "", ylab="Energy sub metering")
lines(power_consumption$DateTime, power_consumption$Sub_metering_2, 
     xaxt='n', xlab = "", col="red")
lines(power_consumption$DateTime, power_consumption$Sub_metering_3, 
      xaxt='n', xlab = "",col="blue")

# Setting up xaxis for dates
axis.POSIXct(1, at=seq(daterange[1], daterange[2] + 60, by="day"), format="%a")

legend("topright", lty=1, col = c("black", "red", "blue"), legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))

dev.off()