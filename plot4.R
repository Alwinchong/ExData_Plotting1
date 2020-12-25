# Load Package
library(data.table)

# Load data from file
power <- data.table::fread(input = "household_power_consumption.txt", na.strings="?")

# Map to corresponding data type (POSIXct to combine date and time)
power[, Global_active_power := lapply(.SD, as.numeric), .SDcols = c("Global_active_power")]
power[, datetime := strptime(paste(Date, Time), format = "%d/%m/%Y %H:%M:%S")]

# Filter Dates between 2007-02-01 and 2007-02-02
power <- power[(datetime >= "2007-02-01") & (datetime < "2007-02-03")]

png("plot4.png", width=480, height=480)

# 2x2 subgraph
par(mfrow=c(2,2))

# Plot 1
plot(power[, datetime], power[, Global_active_power], type="l", xlab="", ylab="Global Active Power")

# Plot 2
plot(power[, datetime],power[, Voltage], type="l", xlab="datetime", ylab="Voltage")

# Plot 3
plot(power[, datetime], power[, Sub_metering_1], type="l", xlab="", ylab="Energy sub metering")
lines(power[, datetime], power[, Sub_metering_2], col="red")
lines(power[, datetime], power[, Sub_metering_3],col="blue")
legend("topright", col=c("black","red","blue"), c("Sub_metering_1","Sub_metering_2", "Sub_metering_3"), lty=1, lwd=1, bty="n", cex=0.95)

# Plot 4
plot(power[, datetime], power[, Global_reactive_power], type="l", xlab="datetime", ylab="Global_reactive_power")

# End plotting
dev.off()

