# plot2.R
# Robert Stober
# Exploratory data Analysis Course Project 1

# Creates a line chart of global active power (in kilowatts) during the first 
# two days of February, 2007.

# create variables to hold the directory paths
topdir <- "C:/Users/Robert/Dropbox/Coursera/Exploratory Data Analysis/project1"
pubdir <- file.path(topdir, "ExData_Plotting1")

# create variables to hold the file paths to the input and PNG (output) files
inputfile <- file.path(topdir, "household_power_consumption.txt")
pngfile <- file.path(pubdir, "plot2.png")

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

# combine the Date and time columns, convert them to POSIXlt, 
# and store result in the Date column.
data$Date <- strptime(paste(data$Date, data$Time), format="%d/%m/%Y %H:%M:%S")

# open a special graphics device. The default is already 480px x 480px.
png(filename=pngfile)

# create the chart
plot(data$Date, 
     data$Global_active_power, 
     type="l", 
     ylab="Global Active Power (kilowatts)", 
     xlab="")

# close the graphics device
dev.off()