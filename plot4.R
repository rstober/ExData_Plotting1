# plot4.R
# Robert Stober
# Exploratory data Analysis Course Project 1

#
# Creates four charts on the same graphics device. The four charts Global active power, 
# Sub metering, Voltage, and Global reactive power during the first two days of 
# February, 2007.
#

# create variables to hold the directory paths
topdir <- "C:/Users/Robert/Dropbox/Coursera/Exploratory Data Analysis/project1"
pubdir <- file.path(topdir, "ExData_Plotting1")

# create variables to hold the file paths to the input and PNG (output) files
inputfile <- file.path(topdir, "household_power_consumption.txt")
pngfile <- file.path(pubdir, "plot4.png")

#
# Read in only the data from 2/1/2007 - 2/2/2007
#

# read in the first line of the input file to get the column names
data <- read.csv2(inputfile, nrows=1)
cnames <- colnames(data)

# read in the interesting portion of the data set
data <- read.csv2(inputfile, 
                  header=F, 
                  col.names=cnames,
                  skip=66637, 
                  nrows=2880, 
                  colClasses=c("character"))

# convert the factor columns to numeric
data$Global_active_power <- as.numeric(data$Global_active_power)
data$Sub_metering_1<- as.numeric(data$Sub_metering_1)
data$Sub_metering_2<- as.numeric(data$Sub_metering_2)
data$Sub_metering_3<- as.numeric(data$Sub_metering_3)
data$Global_reactive_power <- as.numeric(data$Global_reactive_power)
data$Voltage <- as.numeric(data$Voltage)

# combine the Date and time columns, convert them to POSIXlt, 
# and store result in the Date column.
data$Date <- strptime(paste(data$Date, data$Time), format="%d/%m/%Y %H:%M:%S")

# open a special graphics device. The default is already 480px x 480px.
png(filename=pngfile)

# configure the graphical parameters to create the charts in a 2x2 matrix,
# and fill them column-wise.
par(mfcol=c(2,2))

# create the Global active power line chart.
plot(data$Date, 
     data$Global_active_power, 
     type="l", 
     ylab="Global Active Power", 
     xlab="")

# create a line chart plotting Sub_metering_1, Sub_metering_2, and Sub_metering_3
# on one graph. 
plot(data$Date, 
     data$Sub_metering_1, 
     type="l", 
     ylab="Energy sub metering", 
     xlab="")
lines(data$Date,data$Sub_metering_2,col="red")
lines(data$Date,data$Sub_metering_3,col="blue")

# add the legend
legend("topright", 
       c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), 
       lty=c(1,1,1), 
       bty="n",
       col=c("black","red","blue"))

# create the Voltage line chart
plot(data$Date, 
     data$Voltage, 
     type="l", 
     ylab="Voltage",
     xlab="datetime")

# create the Global reactive power line chart
plot(data$Date, 
     data$Global_reactive_power, 
     type="l", 
     ylab="Global_reactive_power",
     xlab="datetime")

# close the graphics device
dev.off()