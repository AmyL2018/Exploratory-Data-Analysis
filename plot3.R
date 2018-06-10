if (!dir.exists("data"))
{dir.create("data")}

#library("data.table")

#Reads in data 
proj1DS <- data.table::fread(input = "./data/household_power_consumption.txt", na.strings="?")

proj1DS[, Global_active_power := lapply(.SD, as.numeric), .SDcols = c("Global_active_power")]

# Change Date Type
proj1DS[, Date := lapply(.SD, as.Date, "%d/%m/%Y"), .SDcols = c("Date")]

# Dates for 2007-02-01 and 2007-02-02
proj1DS <- proj1DS[(Date >= "2007-02-01") & (Date <= "2007-02-02")]

datetime <- paste(as.Date(proj1DS$Date), proj1DS$Time)
proj1DS$Datetime <- as.POSIXct(datetime)

with(proj1DS, {
  plot(Sub_metering_1~Datetime, type="l",
       ylab="Global Active Power (kilowatts)", xlab="")
  lines(Sub_metering_2~Datetime,col='Red')
  lines(Sub_metering_3~Datetime,col='Blue')
})
legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, 
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

dev.copy(png, file="plot3.png", height=480, width=480)

dev.off()
