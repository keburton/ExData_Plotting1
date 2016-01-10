library(dplyr)

if (!file.exists("exdata-data-household_power_consumption.zip")){
    
    temp <- tempfile()
    download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",
                  temp)
    data <- read.table(unz(temp, "household_power_consumption.txt"), 
                       sep=";", header = TRUE, stringsAsFactors = FALSE)
    unlink(temp)
}

dt <- tbl_df(data) 
dt$Date <- as.Date(dt$Date,format="%d/%m/%Y")
power <- filter(dt, Date =="2007-02-01" | Date == "2007-02-02")
power$Global_active_power <- as.numeric(power$Global_active_power)
power$Global_reactive_power <- as.numeric(power$Global_reactive_power)
power$Voltage <- as.numeric(power$Voltage)
power$Sub_metering_1 <- as.numeric(power$Sub_metering_1)
power$Sub_metering_2 <- as.numeric(power$Sub_metering_2)
power$Sub_metering_3 <- as.numeric(power$Sub_metering_3)
power <- mutate(power, datetime = as.POSIXct(paste(Date,Time), 
                                         format="%Y-%m-%d %H:%M:%S"))

par(mfrow=c(2,2))

plot(power$datetime, power$Global_active_power, 
     ylab="Global Active Power",type="l", xlab="")

plot(power$datetime,power$Voltage, type='l',xlab="datetime",ylab="Voltage")

plot(power$datetime,power$Sub_metering_1, type='l', xlab="",
     ylab="Energy sub metering")
lines(power$datetime,power$Sub_metering_2,col="red")
lines(power$datetime,power$Sub_metering_3,col="blue")
legend("topright",c("Sub Metering 1","Sub Metering 2","Sub Metering 3"), 
       lty="solid",col=c("black","red","blue"))

plot(power$datetime,power$Global_reactive_power,xlab="datetime",
     ylab="Global_reactive_power", type='l')


dev.copy(png, file="plot4.png", width=480, height=480)
dev.off()


