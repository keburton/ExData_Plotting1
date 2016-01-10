
if (!file.exists("exdata-data-household_power_consumption.zip")){

    temp <- tempfile()
    download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",
                  temp)
    data <- read.table(unz(temp, "household_power_consumption.txt"), 
                       sep=";", header = TRUE, stringsAsFactors = FALSE)
    unlink(temp)
}

data$Date <- as.Date(data$Date,format="%d/%m/%Y")
power <- data[(data$Date=="2007-02-01"| data$Date=="2007-02-02"),]
power$Global_active_power <- as.numeric(power$Global_active_power)


hist(power$Global_active_power,
     main="Global Active Power", 
     xlab="Global Active Power(kilowatts)", col="red")

dev.copy(png, file="plot1.png", width=480, height=480)
dev.off()

