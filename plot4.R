## Dowload file of Household Power Consumption, unzip this file

File_url<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(File_url,"household_power_consumption.zip")
unzip("household_power_consumption.zip")


## Read file txt, with "?" as NA symbol ; convert date with Y for YYYY ; subset data with 2 dates

HPC<-read.table("household_power_consumption.txt", header=TRUE,sep=";",
                na.strings="?")
HPC$Time <- strptime(paste(HPC$Date, HPC$Time,sep = " "),"%d/%m/%Y %H:%M:%S")
HPC$Date <- as.Date(HPC$Date, "%d/%m/%Y")
selectionDate <- as.Date(c("2007-02-01","2007-02-02"))
SubData<-HPC[HPC$Date %in% selectionDate,]


## Multiple graphs on 1 page / Device : file png, 480x480 pixels / pm : test in quartz()
png(file = "plot4.png",width = 480, height = 480, units = "px")

par(mfrow = c(2, 2)) 

with(SubData, {
plot(Time, Global_active_power, type='l', 
                   ylab =  "Global Active Power (kilowatts)",xlab="")
plot(Time, Voltage, type='l',xlab="datetime")
plot(Time, Sub_metering_1, type='l', ylab =  "Energy sub metering",xlab="")
        lines(Time, Sub_metering_2, col = "red")
        lines(Time, Sub_metering_3, col = "blue")
        legend("topright", lwd="3", col = c("black","blue", "red"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
plot(Time, Global_reactive_power, type='l',xlab="datetime")
})

dev.off()