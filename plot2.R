library(dplyr)
library(lubridate)

#Read the data in, filter for the 2 days and amend date formats
data<-read.table("household_power_consumption.txt",header=TRUE,sep=";",na.strings="?")
data<-filter(data,Date=="1/2/2007"|Date=="2/2/2007")
data<-mutate(data,Date=as.Date(Date,format="%d/%m/%Y"),Time=strptime(Time,format="%H:%M:%S"),
    DateTime=update(Date,hours=hour(Time),minutes=minute(Time)))

#Draw the line plot and copy it to plot2.png
with(data,plot(DateTime,Global_active_power,type="l",xlab="",
    ylab="Global Active Power (kilowatts)"))
dev.copy(png,file="plot2.png")
dev.off()