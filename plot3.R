require(data.table)

# Read the data from the working directory. 
epc <- fread(".\\household_power_consumption.txt",sep=";",header=T,na.strings="?")

# Set the Date as a Date data type
epc$Date <- as.Date(epc$Date, format="%d/%m/%Y")

# Set the active power as a numeric
epc$Global_active_power <- as.numeric(epc$Global_active_power)

# Only include data from 2/1/2007 & 2/2/2007
epc <- subset(epc, subset=(Date >= "2007-02-01" & Date <= "2007-02-02"))

# Combine the date and time columns into a single column and convert it to calendar dates and time 
datetime <- paste(epc$Date,epc$Time)

epc$Datetime <- as.POSIXct(datetime)

#Set up the screen to show 1 columns and 1 row
par(mfrow=c(1,1),mar=c(4,4,2,1))

## Plot
with(epc, {
    plot(Sub_metering_1~Datetime, type="l", ylab="Energy sub metering", xlab="")
    lines(Sub_metering_2~Datetime,col='Red')
    lines(Sub_metering_3~Datetime,col='Blue')
    legend("topright", col=c("black", "red", "blue"), legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=1, lwd=1,)
})

dev.copy(png, file="plot3.png", height=480, width=480)
dev.off()
