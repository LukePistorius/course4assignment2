NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#Have total emissions from PM2.5 decreased in the Baltimore City, 
#Maryland (\color{red}{\verb|fips == "24510"|}fips=="24510") from 1999 to 2008? 
#Use the base plotting system to make a plot answering this question.

mary <- subset(NEI,NEI$fips=="24510" & (NEI$year==1999 | NEI$year==2008))

TotalE<-with(data=mary,tapply(Emissions,year,sum))

png(filename = "plot2.png",width=480,height = 480,units = "px")

barplot(TotalE,col="red")

dev.off()