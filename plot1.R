library(dplyr)

#Read the data in, filter for the 2 days and amend date formats
data<-read.table("household_power_consumption.txt",header=TRUE,sep=";",na.strings="?")
data<-filter(data,Date=="1/2/2007"|Date=="2/2/2007")
data<-mutate(data,Date=as.Date(Date,format="%d/%m/%Y"),Time=strptime(Time,format="%H:%M:%S"))

#Draw the histogram and copy it to plot1.png
hist(data$Global_active_power,col="red",xlab="Global Active Power (kilowatts)",
     ylab="Frequency",main="Global Active Power")
dev.copy(png,file="plot1.png")
dev.off()