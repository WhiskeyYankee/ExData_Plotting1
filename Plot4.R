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
data <- data %>%
  unite(col = "Date_Time",Date,Time,sep = " ")
data$Date_Time = strptime(data$Date_Time,format = "%d/%m/%Y %H:%M:%S")

data <- subset(data,Date_Time >= strptime("2007-02-01 00:00:00",format = "%Y-%m-%d %H:%M:%S")
         & Date_Time <= strptime("2007-02-02 23:59:59",format = "%Y-%m-%d %H:%M:%S"))

###############################################################################################################
# Step 3: Create Plot4
###############################################################################################################
png(filename = "C:/Users/peted/Desktop/Data_Science/ExploratoryDataAnalysis/Week 1/Repo/Plot4.png",width = 480, height = 480)
par(mfcol = c(2,2))
with(data,plot(Date_Time,Global_active_power,type = "l"
               ,ylab = "Global Active Power (kilowatts)"
               ,xlab = ""))

with(data,plot(Date_Time,Sub_metering_1,type = "l"
               ,ylab = "Global Active Power (kilowatts)"
               ,xlab = ""))
with(data,points(Date_Time,Sub_metering_2,type = "l",col = "red"))
with(data,points(Date_Time,Sub_metering_3,type = "l",col = "blue"))
legend(x = "topright",legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),col = c("black","red","blue"),lty = 1)

with(data,plot(Date_Time,Voltage,type = "l"
               ,ylab = "Voltage"
               ,xlab = "datetime"))

with(data,plot(Date_Time,Global_reactive_power,type = "l"
               ,ylab = "Global_reactive_power"
               ,xlab = "datetime"))
dev.off()

