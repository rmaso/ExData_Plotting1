# Set the file name to save the download file
filename <- "household_power_consumption.zip"

# Download and unzip the dataset if required
if (!file.exists("household_power_consumption.txt")) { 
  if (!file.exists(filename)){
    fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
    download.file(fileURL, filename, method="curl") #method curl for OSX, remove to Windows OS
  }  
  unzip(filename) 
}

# load required libraris
library(data.table)
library(lubridate)
library(dplyr)

# load the dataset
dt <- fread("household_power_consumption.txt")

# filter by dates and transform the fields to numerics
dt.work <- dt %>% 
            filter( dmy(Date) >= "2007-02-01" & dmy(Date) < "2007-02-03") %>%  
            mutate(DateTime = dmy_hms(paste(Date, Time, sep=" ")), 
                   Date = dmy(Date),
                   Global_active_power = as.numeric(Global_active_power),
                   Sub_metering_1 = as.numeric(Sub_metering_1),
                   Sub_metering_2 = as.numeric(Sub_metering_2),
                   Sub_metering_3 = as.numeric(Sub_metering_3),
                   Voltage = as.numeric(Voltage),
                   Global_reactive_power = as.numeric(Global_reactive_power))

#Set locale to print the week days in English
Sys.setlocale("LC_ALL","en_US.UTF-8")

#Plot graphic and save as PNG
png(filename = "plot2.png",width = 480, height = 480, units = "px")
  with(dt.work, plot(Global_active_power~DateTime, type='l', xlab="", ylab="Global Active Power (kilowatts)"))
dev.off()

