# Load Package
library(data.table)

# Load data from file
power <- data.table::fread(input = "household_power_consumption.txt", na.strings="?")

# Map to corresponding data type (POSIXct to combine date and time)
power[, Global_active_power := lapply(.SD, as.numeric), .SDcols = c("Global_active_power")]
power[, datetime := strptime(paste(Date, Time), format = "%d/%m/%Y %H:%M:%S")]

# Filter Dates between 2007-02-01 and 2007-02-02
power <- power[(datetime >= "2007-02-01") & (datetime < "2007-02-03")]

png("plot2.png", width=480, height=480)

# Plot 2
plot(x = power[, datetime], y = power[, Global_active_power], type="l", xlab="", ylab="Global Active Power (kilowatts)")

# End plotting
dev.off()
