data_all <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", as.is = T)
data_all$Date<-as.Date(data_all$Date,format="%d/%m/%Y")
i1<-data_all[,1]=="2007-02-01"
i2<-data_all[,1]=="2007-02-02"
rows1<-which(i1)
rows2<-which(i2)
rows<-c(rows1, rows2)
rows<-sort(rows)
data<-data_all[rows,]
data$Sub_metering_1<-as.numeric(data$Sub_metering_1)
data$Sub_metering_2<-as.numeric(data$Sub_metering_2)
data$Sub_metering_3<-as.numeric(data$Sub_metering_3)

max_y <- max(max(data$Sub_metering_1), max(data$Sub_metering_2), max(data$Sub_metering_3))

png(filename = "plot3.png", width = 480, height = 480, units = "px")
plot(data$Sub_metering_1, type = "l", xaxt = "n", ylim = c(0, max_y), xlab = "", ylab = "Energy sub metering")
lines(data$Sub_metering_2, type = "l", col = "red", xaxt = "n")
lines(data$Sub_metering_3, type = "l", col = "blue", xaxt = "n")
labels <- weekdays(as.Date('2007-02-01','%Y-%m-%d'), abbr = TRUE)
labels[2] <- weekdays(as.Date('2007-02-02','%Y-%m-%d'), abbr = TRUE)
labels[3] <- weekdays(as.Date('2007-02-03','%Y-%m-%d'), abbr = TRUE)
axis(1, at=c(1, (length(data$Sub_metering_1)/2)+1, length(data$Sub_metering_1)), labels = labels)
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty = 1, col = c("black", "red", "blue"), ncol = 1)
dev.off()