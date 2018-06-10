install.packages("data.table", dependencies=TRUE)

if (!dir.exists("data"))
{dir.create("data")}

library("data.table")

#Reads in data 
proj1DS <- data.table::fread(input = "./data/household_power_consumption.txt", na.strings="?")

proj1DS[, Global_active_power := lapply(.SD, as.numeric), .SDcols = c("Global_active_power")]

# Change Date Type
proj1DS[, Date := lapply(.SD, as.Date, "%d/%m/%Y"), .SDcols = c("Date")]

# Dates for 2007-02-01 and 2007-02-02
proj1DS <- proj1DS[(Date >= "2007-02-01") & (Date <= "2007-02-02")]

png("plot1.png", width=480, height=480)

## Plot 1
hist(proj1DS[, Global_active_power], main="Global Active Power", 
     xlab="Global Active Power (kilowatts)", ylab="Frequency", col="Red")


dev.off()
