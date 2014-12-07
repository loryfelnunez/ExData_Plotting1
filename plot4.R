#Data manipulation - loading, tranforming, subsetting
houseData <- read.table("household_power_consumption.txt", sep=";", header=TRUE, stringsAsFactors=FALSE)
houseData <- transform(houseData, Date=as.Date(Date, "%d/%m/%Y"), 
                       Global_active_power = as.numeric(Global_active_power),  
                       Global_reactive_power = as.numeric(Global_reactive_power),  
                       Voltage = as.numeric(Voltage),
                       Sub_metering_1 = as.numeric(Sub_metering_1), 
                       Sub_metering_2 = as.numeric(Sub_metering_2), 
                       Sub_metering_3 = as.numeric(Sub_metering_3)) 
houseDataSubset <- subset(houseData, Date == as.Date("2007-02-01") | Date == as.Date("2007-02-02"))
houseDataSubset$DateTime <- strptime(paste(houseDataSubset$Date, houseDataSubset$Time), "%Y-%m-%d %H:%M:%S")

#Plot construction
png("plot4.png", width = 480, height = 480)
par(mfrow=c(2,2))
#First Plot  time vs. Global Active Power
plot(houseDataSubset$DateTime, 
     houseDataSubset$Global_active_power, 
     type="l",
     xlab = "",
     ylab="Global Active Power")
#Second Plot  time vs. Voltage
plot(houseDataSubset$DateTime, 
     houseDataSubset$Voltage, 
     type="l",
     xlab = "datetime",
     ylab="Voltage")
#Third Plot - sub metering
plot(houseDataSubset$DateTime, houseDataSubset$Sub_metering_1, type="l",
     xlab = "",
     ylab="Energy sub metering")
lines(houseDataSubset$DateTime, houseDataSubset$Sub_metering_2, col="red")
lines(houseDataSubset$DateTime, houseDataSubset$Sub_metering_3, col="blue")
legend("topright",c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),col=c("black", "red", "blue"), lty=1, bty="n")
#Fourth Plot - time vs. Global Reactive power
plot(houseDataSubset$DateTime, 
     houseDataSubset$Global_reactive_power, 
     type="l",
     xlab = "datetime",
     ylab="Global_Reactive_Power")
dev.off()
