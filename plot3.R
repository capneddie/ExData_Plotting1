# plot3.R

main_data <- read.table("household_power_consumption.txt",
                        header = TRUE,
                        sep = ";",
                        na.strings = "?",
                        stringsAsFactors = FALSE)
filter_data <- subset(main_data, Date %in% c("1/2/2007", "2/2/2007"))
filter_data$Date <- as.Date(filter_data$Date, format = "%d/%m/%Y")
filter_data$datetime <- strptime(paste(filter_data$Date, filter_data$Time),
                                 format = "%Y-%m-%d %H:%M:%S")

png("plot3.png", width = 480, height = 480)
plot(filter_data$datetime, filter_data$Sub_metering_1, type = "l",
     xlab = "", ylab = "Energy sub metering")
lines(filter_data$datetime, filter_data$Sub_metering_2, col = "red")
lines(filter_data$datetime, filter_data$Sub_metering_3, col = "blue")
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       col = c("black", "red", "blue"), lty = 1)
dev.off()