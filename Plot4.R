
energy <- data.table::fread(input = "household_power_consumption.txt"
                             , na.strings="?"
)

energy[, Global_active_power := lapply(.SD, as.numeric), .SDcols = c("Global_active_power")]

energy[, dateTime := as.POSIXct(paste(Date, Time), format = "%d/%m/%Y %H:%M:%S")]

energy <- energy[(dateTime >= "2007-02-01") & (dateTime < "2007-02-03")]

png("Plot4.png", width=480, height=480)

par(mfrow=c(2,2))

plot(energy[, dateTime], energy[, Global_active_power], type="l", xlab="", ylab="Global Active Power")

plot(energy[, dateTime],energy[, Voltage], type="l", xlab="datetime", ylab="Voltage")

plot(energy[, dateTime], energy[, Sub_metering_1], type="l", xlab="", ylab="Energy sub metering")
lines(energy[, dateTime], energy[, Sub_metering_2], col="red")
lines(energy[, dateTime], energy[, Sub_metering_3],col="blue")
legend("topright", col=c("black","red","blue")
       , c("Sub_metering_1  ","Sub_metering_2  ", "Sub_metering_3  ")
       , lty=c(1,1)
       , bty="n"
       , cex=.5) 

plot(energy[, dateTime], energy[,Global_reactive_power], type="l", xlab="datetime", ylab="Global_reactive_power")

dev.off()