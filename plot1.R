#Data manipulation - loading, tranforming, subsetting
houseData <- read.table("household_power_consumption.txt", sep=";", header=TRUE, stringsAsFactors=FALSE)
houseData <- transform(houseData, 
                       Date=as.Date(Date, "%d/%m/%Y"), 
                       Global_active_power = as.numeric(Global_active_power) )
houseDataSubset <- subset(houseData, Date == as.Date("2007-02-01") | Date == as.Date("2007-02-02"))
houseDataSubset$DateTime <- strptime(paste(houseDataSubset$Date, houseDataSubset$Time), "%Y-%m-%d %H:%M:%S")
#Plot construction
png("plot1.png", width = 480, height = 480)
hist(houseDataSubset$Global_active_power, 
     col="red", 
     xlab="Global Active Power (kilowatts)", 
     ylab = "Frequency",
     main="Global Active Power")
dev.off()
