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
power <- mutate(power, dttm = as.POSIXct(paste(Date,Time), 
                                   format="%Y-%m-%d %H:%M:%S"))

plot(power$dttm, power$Global_active_power, 
     ylab="Global Active Power (kilowatts)",type="l", xlab="")

dev.copy(png, file="plot2.png", width=480, height=480)
dev.off()

