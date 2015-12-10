## This R file reads and substets data from given project file and makes plot3.png

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

## PLOTING PART
  
## Opens device and store some of the data to avoid typing a lot
  png('plot3.png',width=480,height=480)
  sub1<-hpc$Sub_metering_1
  sub2<-hpc$Sub_metering_2
  sub3<-hpc$Sub_metering_3
  
## makes plot window with desired labels
  plot(hpc$Time,sub1,type='n',xlab='',ylab='Energy sub metering')
  
## inserts the data with lines() function, with desired color
  lines(hpc$Time,sub1)
  lines(hpc$Time,sub2,col='red')
  lines(hpc$Time,sub3,col='blue')
  
## makes legend
  legend('topright',lty='solid',col=c('black','red','blue'),legend=c('sub metering 1','sub metering 2','sub metering 3'))
  
  dev.off() # closes device
  
  