# plot1.R
main_data <- read.table("household_power_consumption.txt",
                        header = TRUE,
                        sep = ";",
                        na.strings = "?",
                        stringsAsFactors = FALSE)
filter_data <- subset(main_data, Date %in% c("1/2/2007", "2/2/2007"))
filter_data$Date <- as.Date(filter_data$Date, format = "%d/%m/%Y")
filter_data$datetime <- strptime(paste(filter_data$Date, filter_data$Time),
                                 format = "%Y-%m-%d %H:%M:%S")

# Create PNG
png("plot1.png", width = 480, height = 480)
hist(filter_data$Global_active_power,
     col = "red",
     main = "Global Active Power",
     xlab = "Global Active Power (kilowatts)")
dev.off()