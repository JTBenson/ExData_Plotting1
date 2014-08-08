#Read in data - read in only number of rows required to pull in 1-Feb-2007 and 2-Feb-2007
x=read.table("./exdata_data_household_power_consumption/household_power_consumption.txt",
             header=TRUE,sep=";",nrows=69516,na.strings="?")

##Subset for 1-Feb-2007 and 2-Feb-2007 dates
xSub = subset(x,as.character(x$Date) %in% c("1/2/2007","2/2/2007"))
summary(xSub$Date)

##Create DateTime variable
xSub$DateTimeCat = paste(xSub$Date,xSub$Time,sep=",")
xSub$DateTime = strptime(xSub$DateTimeCat,format="%d/%m/%Y,%H:%M:%S")

#Create plots and output to PNG
par(mfrow=c(2,2))

#Plot 1
with(xSub,plot(DateTime,Global_active_power,type="n",xlab="",
               ylab="Global Active Power (kilowatts)"))
with(xSub,lines(DateTime,Global_active_power,type="l"))

#Plot 2
with(xSub,plot(DateTime,Voltage,type="n",xlab="datetime",
               ylab="Voltage"))
with(xSub,lines(DateTime,Voltage,type="l"))

#Plot 3
with(xSub,plot(DateTime,Sub_metering_1,type="n",xlab="",
               ylab="Energy sub metering"))
with(xSub,lines(DateTime,Sub_metering_1,type="l"))
with(xSub,lines(DateTime,Sub_metering_2,type="l",col="red"))
with(xSub,lines(DateTime,Sub_metering_3,type="l",col="blue"))
legend("topright",legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),lty=1,
       col=c("black","red","blue"), bty="n",x.intersp=0.5, cex=0.75)

#Plot 4
with(xSub,plot(DateTime,Global_reactive_power,type="n",xlab="datetime",
               ylab=""))
with(xSub,lines(DateTime,Global_reactive_power,type="l"))

#Output
dev.copy(png,file="plot4.png")
dev.off()

#reset back to 1,1
par(mfrow=c(1,1))



