# plot1.R
# Robert Stober
# Exploratory data Analysis Course Project 1

# Creates a histogram of global active power (in kilowatts) during the first 
# two days of February, 2007.

# create variables to hold the directory paths
topdir <- "C:/Users/Robert/Dropbox/Coursera/Exploratory Data Analysis/project1"
pubdir <- file.path(topdir, "ExData_Plotting1")

# create variables to hold the file paths to the input and PNG (output) files
inputfile <- file.path(topdir, "household_power_consumption.txt")
pngfile <- file.path(pubdir, "plot1.png")

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

# convert the date and time columns
data$Date <- strptime(data$Date, format="%d/%m/%Y")

# open a special graphics device. The default is already 480px x 480px.
png(filename=pngfile)

# create the historgram, set the color and labels as specified.
hist(data$Global_active_power, 
     col="red", 
     main="Global Active Power", 
     xlab="Global Active Power (kilowatts)")

# close the graphics device
dev.off()