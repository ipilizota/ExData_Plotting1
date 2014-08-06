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
data$Sub_metering_1<-as.numeric(data$Sub_metering_1)
data$Sub_metering_2<-as.numeric(data$Sub_metering_2)
data$Sub_metering_3<-as.numeric(data$Sub_metering_3)
max_y <- max(max(data$Sub_metering_1), max(data$Sub_metering_2), max(data$Sub_metering_3))
data$Voltage<-as.numeric(data$Voltage)
data$Global_reactive_power<-as.numeric(data$Global_reactive_power)

png(filename = "plot4.png", width = 480, height = 480, units = "px")
par(mfrow = c(2,2))
#1
plot(data$Global_active_power, type = "l", xaxt = "n", xlab = "", ylab = "Global Active Power")
labels <- weekdays(as.Date('2007-02-01','%Y-%m-%d'), abbr = TRUE)
labels[2] <- weekdays(as.Date('2007-02-02','%Y-%m-%d'), abbr = TRUE)
labels[3] <- weekdays(as.Date('2007-02-03','%Y-%m-%d'), abbr = TRUE)
axis(1, at=c(1, (length(data$Global_active_power)/2)+1, length(data$Global_active_power)), labels = labels)
#2
plot(data$Voltage, type = "l", xaxt = "n", xlab = "datetime", ylab = "Voltage")
axis(1, at=c(1, (length(data$Voltage)/2)+1, length(data$Voltage)), labels = labels)
#3
plot(data$Sub_metering_1, type = "l", xaxt = "n", ylim = c(0, max_y), xlab = "", ylab = "Energy sub metering")
lines(data$Sub_metering_2, type = "l", col = "red", xaxt = "n")
lines(data$Sub_metering_3, type = "l", col = "blue", xaxt = "n")
axis(1, at=c(1, (length(data$Sub_metering_1)/2)+1, length(data$Sub_metering_1)), labels = labels)
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty = 1, bty = "n", col = c("black", "red", "blue"), ncol = 1)
#4
plot(data$Global_reactive_power, type = "l", xaxt = "n", xlab = "datetime", ylab = "Global_reactive_power")
axis(1, at=c(1, (length(data$Voltage)/2)+1, length(data$Voltage)), labels = labels)
dev.off()