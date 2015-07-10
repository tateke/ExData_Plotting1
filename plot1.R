require(data.table)

# Read the data from the working directory. 
epc <- fread(".\\household_power_consumption.txt",sep=";",header=T,na.strings="?")

# Set the Date as a Date data type
epc$Date <- as.Date(epc$Date, format="%d/%m/%Y")

# Set the active power as a numeric
epc$Global_active_power <- as.numeric(epc$Global_active_power)

# Only include data from 2/1/2007 & 2/2/2007
epc <- subset(epc, subset=(Date >= "2007-02-01" & Date <= "2007-02-02"))

#Set up the screen to show 1 columns and 1 row
par(mfrow=c(1,1),mar=c(4,4,2,1))

# Create the historgram
hist(epc$Global_active_power, main="Global Active Power", xlab="Global Active Power (kilowatts)", ylab="Frequency", col="Red")

# Save the png file
dev.copy(png,file="plot1.png",height=480,width=480)
dev.off()
