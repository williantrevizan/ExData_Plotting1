## This R file reads and substets data from given project file and makes plot2.png

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
  
  png('plot2.png',width=480,height=480) #opens device
  GAP<-hpc$Global_active_power # stores desired variable (avoid typing a lot!)
  
## first makes the plot window with desired labels without plotting the data and
## then plots data with function lines()
  
  plot(hpc$Time,GAP,xlab="",ylab="Global Active Power",type='n')
  lines(hpc$Time,GAP)
  dev.off() #closes device
  
  
  
  
  
  
  