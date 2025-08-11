install.packages("sqldf")  
library(sqldf)

# Load entire dataset
main_data <- read.table("household_power_consumption.txt",
                        header = TRUE,
                        sep = ";",
                        na.strings = "?",
                        stringsAsFactors = FALSE)

# Filter for Feb 1–2, 2007
filter_data <- subset(main_data, Date %in% c("1/2/2007", "2/2/2007"))

# Convert Date & Time
filter_data$Date <- as.Date(filter_data$Date, format = "%d/%m/%Y")
filter_data$datetime <- strptime(paste(filter_data$Date, filter_data$Time),
                                 format = "%Y-%m-%d %H:%M:%S")
# Plot to PNG
# plot1.R — Histogram of Global Active Power
png("plot1.png", width = 480, height = 480)
hist(filter_data$Global_active_power,
     col = "red",
     main = "Global Active Power",
     xlab = "Global Active Power (kilowatts)")
dev.off()

# plot2.R — Global Active Power Over Time
png("plot2.png", width = 480, height = 480)
plot(filter_data$datetime, filter_data$Global_active_power,
     type = "l",
     xlab = "",
     ylab = "Global Active Power (kilowatts)")
dev.off()

# plot3.R — Energy Sub-Metering Over Time
png("plot3.png", width = 480, height = 480)
plot(filter_data$datetime, filter_data$Sub_metering_1, type = "l",
     xlab = "", ylab = "Energy sub metering")
lines(filter_data$datetime, filter_data$Sub_metering_2, col = "red")
lines(filter_data$datetime, filter_data$Sub_metering_3, col = "blue")
legend("topright", 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       col = c("black", "red", "blue"),
       lty = 1)
dev.off()

# plot4.R — 4 Plots in One
png("plot4.png", width = 480, height = 480)
par(mfrow = c(2, 2))

# Top-left
plot(filter_data$datetime, filter_data$Global_active_power, type = "l",
     xlab = "", ylab = "Global Active Power")

# Top-right
plot(filter_data$datetime, filter_data$Voltage, type = "l",
     xlab = "datetime", ylab = "Voltage")

# Bottom-left
plot(filter_data$datetime, filter_data$Sub_metering_1, type = "l",
     xlab = "", ylab = "Energy sub metering")
lines(filter_data$datetime, filter_data$Sub_metering_2, col = "red")
lines(filter_data$datetime, filter_data$Sub_metering_3, col = "blue")
legend("topright", bty = "n",
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       col = c("black", "red", "blue"),
       lty = 1)

# Bottom-right
plot(filter_data$datetime, filter_data$Global_reactive_power, type = "l",
     xlab = "datetime", ylab = "Global Reactive Power")

dev.off()