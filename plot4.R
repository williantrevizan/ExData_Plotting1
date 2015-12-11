## This R file reads and substets data from given project file and makes plot4.png

## READING PART

## Reads file considering ';' as separators, '?' as NAs, names on header and
## dates and times colums as character classes

  hpc<-read.table('household_power_consumption.txt',sep=';',na.strings=c("NA","?"),as.is=TRUE,header=TRUE)

## Merges Date and Time in Time column so that Time variable will have complete
## time information (including week days) when converted using strptime()

  hpc$Time<-paste(hpc$Date,hpc$Time)

  hpc$Date<-as.Date(hpc$Date,"%d/%m/%Y") # converts first column to Date class 
  hpc$Time<-strptime(hpc$Time, "%d/%m/%Y %H:%M:%S") # converts Time to appropriate class

## subsets data corresponding to first two days of February of 2007

  hpc<-subset(hpc,(Date=="2007-02-01")|(Date=="2007-02-02")) 

## PLOTING PART (this is less commented because it is mainly a copy of the other plots)

  png('plot4.png',width=480,height=480) # opens png device
  par(mfcol=c(2,2)) #divides ploting window in a 2x2 grid (to fill column wise)
  
## copy of plot2
  
  GAP<-hpc$Global_active_power
  plot(hpc$Time,GAP,xlab="",ylab="Global Active Power",type='n')
  lines(hpc$Time,GAP)
  
## copy of plot3
  
  sub1<-hpc$Sub_metering_1
  sub2<-hpc$Sub_metering_2
  sub3<-hpc$Sub_metering_3
  plot(hpc$Time,sub1,type='n',xlab='',ylab='Energy sub metering')
  lines(hpc$Time,sub1)
  lines(hpc$Time,sub2,col='red')
  lines(hpc$Time,sub3,col='blue')
  legend('topright',lty='solid',col=c('black','red','blue'),legend=c('Sub_metering_1','Sub_metering_2','Sub_metering_3'))
  
  ## Voltage plot (similar idea of plot2)
  
  V<-hpc$Voltage
  plot(hpc$Time,V,xlab="datetime",ylab="Voltage",type='n')
  lines(hpc$Time,V)
  
## Global Reactive Power plot (similar idea of plot2)
  
  GRP<-hpc$Global_reactive_power
  plot(hpc$Time,GRP,xlab="datetime",ylab="Global_reactive_power",type='n')
  lines(hpc$Time,GRP)
  
  dev.off() # closes device
  