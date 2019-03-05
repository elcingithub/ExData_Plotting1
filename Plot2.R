
energy <- data.table::fread(input = "household_power_consumption.txt"
                             , na.strings="?"
)

energy[, Global_active_power := lapply(.SD, as.numeric), .SDcols = c("Global_active_power")]

energy[, dateTime := as.POSIXct(paste(Date, Time), format = "%d/%m/%Y %H:%M:%S")]

energy <- energy[(dateTime >= "2007-02-01") & (dateTime < "2007-02-03")]

png("Plot2.png", width=480, height=480)

plot(x = energy[, dateTime]
     , y = energy[, Global_active_power]
     , type="l", xlab="", ylab="Global Active Power (kilowatts)")

dev.off()