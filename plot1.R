## Load the data
library(dplyr)

## Getting the data
data <- read.table("household_power_consumption.txt", sep = ';', header = TRUE, na.strings = '?')

## Extracting only rows corresponding to dates of interest transforming date and time into POSIXct.
power_consumption <- data %>%
        filter(Date == "1/2/2007" | Date == "2/2/2007") %>%
        mutate(DateTime = as.POSIXct(paste(Date, Time, sep=" "), format = "%d/%m/%Y %H:%M:%S", tz = "")) %>%
        select(-Date, -Time)

png("plot1.png", width = 480, height = 480)
hist(power_consumption$Global_active_power, col = "red", 
     main = "Global Active Power", xlab = "Global Active Power (kilowatts)")
dev.off()



