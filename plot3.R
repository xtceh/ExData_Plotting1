library(dplyr)
library(lubridate)

#Read the data in, filter for the 2 days and amend date formats
data<-read.table("household_power_consumption.txt",header=TRUE,sep=";",na.strings="?")
data<-filter(data,Date=="1/2/2007"|Date=="2/2/2007")
data<-mutate(data,Date=as.Date(Date,format="%d/%m/%Y"),Time=strptime(Time,format="%H:%M:%S"),
    DateTime=update(Date,hours=hour(Time),minutes=minute(Time)))

#Draw the line plot, annotate it and copy it to plot3.png
with(data,plot(DateTime,Sub_metering_1,type="n",ylab="Energy sub metering",xlab=""))
with(data,points(DateTime,Sub_metering_1,type="l"))
with(data,points(DateTime,Sub_metering_2,type="l",col="red"))
with(data,points(DateTime,Sub_metering_3,type="l",col="blue"))
legend("topright",legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
    col=c("black","red","blue"),lty=1)
dev.copy(png,file="plot3.png")
dev.off()