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


## ## Plot with 3 variables on y axis / Device : file png, 480x480 pixels / pm : test in quartz()
png(file = "plot3.png",width = 480, height = 480, units = "px")
with(SubData, plot(Time, Sub_metering_1, type='l', 
                   ylab =  "Energy sub metering",xlab=""))
with(SubData, lines(Time, Sub_metering_2, col = "red"))
with(SubData, lines(Time, Sub_metering_3, col = "blue"))
legend("topright", lwd="3", col = c("black","blue", "red"),
       legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
dev.off()
