setwd('/Users/Acer/Documents/specdata')
getwd()
library(lubridate)

## calculating a rough estimate of how much memory in bytes(cal_bytes), megabytes(cal_mb) and gigabytes(cal_gb),  the dataset will require in memory 

cal_bytes <- 2075259*9*8
cal_bytes

cal_mb <- 2075259*9*8/2^{20}
cal_mb

cal_gb <- 2075259*9*8/2^{20}/1024
cal_gb

#Reading household_power_consumption file by first using file.choose function which allows selecting of file saved in the computer for use in R session.
file <- file.choose("household_power_consumption.txt")


##using read.table for storing text file "household_power_consumption" imported by file.choose() function an stored in "file" 
hpc <- read.table(file, header = T, sep = ';') 


#Convert "Date" Column Into Date Using as.Date() function, specifying date format to date/month/year using dmy().

hpc$Date = as.Date(dmy(hpc$Date)) 
hpc$Date

#only getting the data for the given dates, '2007-02-01', '2007-02-02' 
date_given = ymd(c("2007-02-01", "2007-02-02"))
date_selected= hpc[hpc$Date %in% date_given, ] ##filtering hpc$date by date_given and storing data filtered into "date_selected".


date_selected


#Creating date time field
date_selected$DateTime = with(date_selected, ymd_hms(paste(Date, Time)))
date_selected$DateTime


#FIRST PLOT
#creating histoplot for data under the column Global_active_power and saving it as a PNG file
##main = "Global Active Power" is the main title of the histogram, xlab = 'Global Active Power (kilowatts)' is the label for the x-axis, and col= "red" specifies the color of the  bars. 

plot1 <- hist(date_selected$Global_active_power, main = "Global Active Power" ,xlab = "Global Active Power (kilowatts)", col = "red")


##saving histogram as a png file to the folder set as the working directory
dev.copy(png,"plot1.png")
dev.off()

#Plot 2
##using the with() function, data for the dates selected ("2007-02-01", "2007-02-02") under DateTime and Global_active_power are plotted, with lines "DateTime" for x-axis and "Global_active_power" for the y-axis. pch = NA omits points. 
plot2 <- with(date_selected, plot(DateTime, Global_active_power,  ylab =  'Global Active Power (kilowatts)', pch = NA,lines(DateTime, Global_active_power)))
date_selected 

#saving plot as a png file to the folder set as the working directory

dev.copy(png,"plot2.png")
dev.off()


#plot 3 
##plotting Sub_metering_1, Sub_metering_2, and Sub_metering_3 all in one plot


 plot3 <- with(date_selected, {
  plot(DateTime, Sub_metering_1, ylab =  'Energy sub metering', xlab = '',pch = NA,
  
  lines(DateTime, Sub_metering_1)) 
  
  lines(DateTime, Sub_metering_2, ##lines for Sub_metering_2
        col = 'red')
  
  lines(DateTime, Sub_metering_3, ##lines for Sub_metering_3
        col = 'blue')
  
  ##adding legend at the top right corner of the plot indicating the data being plotted by line colors in which Sub_metering_1 is black, Sub_metering_2 is red, and Sub_metering_3 is blue 
  ##lty = 1 indicates that the lines to be used in the legend are solid lines, lwd = 3 indicates that all the lines' width in the legend would be thrice as wide as the default line width.
  legend('topright', lty = 1, lwd = 3, col = c('black', 'red', 'blue'),
  legend = c('Sub_metering_1', 'Sub_metering_2', 'Sub_metering_3')
  )
}) 

##saving plot as a png file to the folder set as the working directory  
dev.copy(png,"plot3.png")
dev.off()s


