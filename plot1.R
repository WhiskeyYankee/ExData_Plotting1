###############################################################################################################
# Step 0: load packages
###############################################################################################################
library(tidyverse)
library(lubridate)

###############################################################################################################
# Step 1: Import Data, filter to desired date range, and remove temp file
###############################################################################################################
Temp <- tempfile()
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",Temp)
data <- read_delim(unzip(Temp),";",col_types = list(
  Date = col_character(),
  Time = col_character(),
  Global_active_power = col_double(),
  Global_reactive_power = col_double(),
  Voltage = col_double(),
  Global_intensity = col_double(),
  Sub_metering_1 = col_double(),
  Sub_metering_2 = col_double(),
  Sub_metering_3 = col_double()
)) 
unlink(Temp)

###############################################################################################################
# Step 2: Change Date and time variables to Date and time and filter to desired range
###############################################################################################################
data$Date = dmy(data$Date)
data$Time = hms(data$Time)
data <- data %>%
  filter(Date >= ymd("2007-02-01") & Date <= ymd("2007-02-02"))

###############################################################################################################
# Step 3: Create Plot1
###############################################################################################################
png(filename = "C:/Users/peted/Desktop/Data_Science/ExploratoryDataAnalysis/Week 1/Repo/Plot1.png")


with(data,hist(Global_active_power,col = "red",main = "Global Active Power", xlab = "Global Active Power (kilowatts)"))


dev.off()

