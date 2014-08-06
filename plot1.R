data_all <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", as.is = T)
data_all$Date<-as.Date(data_all$Date,format="%d/%m/%Y")
i1<-data_all[,1]=="2007-02-01"
i2<-data_all[,1]=="2007-02-02"
rows1<-which(i1)
rows2<-which(i2)
rows<-c(rows1, rows2)
rows<-sort(rows)
data<-data_all[rows,]
data$Global_active_power<-as.numeric(data$Global_active_power)

png(filename = "plot1.png", width = 480, height = 480, units = "px")
hist(data$Global_active_power, col = 'red', main = "Global Active Power", xlab = "Global Active Power (kilowatts)")
dev.off()