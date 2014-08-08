#Read in data - read in only number of rows required to pull in 1-Feb-2007 and 2-Feb-2007
x=read.table("./exdata_data_household_power_consumption/household_power_consumption.txt",
             header=TRUE,sep=";",nrows=69516,na.strings="?")

##Subset for 1-Feb-2007 and 2-Feb-2007 dates
xSub = subset(x,as.character(x$Date) %in% c("1/2/2007","2/2/2007"))
#summary(xSub$Date)

##Create DateTime variable
xSub$DateTimeCat = paste(xSub$Date,xSub$Time,sep=",")
xSub$DateTime = strptime(xSub$DateTimeCat,format="%d/%m/%Y,%H:%M:%S")

#Create plot and output to PNG
with(xSub,plot(DateTime,Global_active_power,type="n",xlab="",
               ylab="Global Active Power (kilowatts)"))
with(xSub,lines(DateTime,Global_active_power,type="l"))
dev.copy(png,file="plot2.png")
dev.off()



