library(dplyr)
library(lubridate)

#Read the data in, filter for the 2 days and amend date formats
data<-read.table("household_power_consumption.txt",header=TRUE,sep=";",na.strings="?")
data<-filter(data,Date=="1/2/2007"|Date=="2/2/2007")
data<-mutate(data,Date=as.Date(Date,format="%d/%m/%Y"),Time=strptime(Time,format="%H:%M:%S"),
    DateTime=update(Date,hours=hour(Time),minutes=minute(Time)))

#Open the png graphics device and Set up the global parameters
png("plot4.png")
par(mfcol=c(2,2))

#Draw the 4 line plots, annotating them where necessary
#Plot 1
with(data,plot(DateTime,Global_active_power,type="l",xlab="",
               ylab="Global Active Power (kilowatts)"))
#Plot 2
with(data,plot(DateTime,Sub_metering_1,type="n",ylab="Energy sub metering",xlab=""))
with(data,points(DateTime,Sub_metering_1,type="l"))
with(data,points(DateTime,Sub_metering_2,type="l",col="red"))
with(data,points(DateTime,Sub_metering_3,type="l",col="blue"))
legend("topright",legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
    col=c("black","red","blue"),lty=1,cex=0.7,bty="n")
#Plot 3
with(data,plot(DateTime,Voltage,type="l",xlab="datetime"))
#Plot 4
with(data,plot(DateTime,Global_reactive_power,type="l",xlab="datetime"))

#Close the graphics device and set global parameters back
dev.off()
par(mfcol=c(1,1))