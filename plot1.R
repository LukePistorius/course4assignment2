# Have total emissions from PM2.5 decreased in the United States from 
#1999 to 2008? Using the base plotting system, 
#make a plot showing the total PM2.5 emission from all sources (SCC)
#for each of the years 1999, 2002, 2005, and 2008.


## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# decided to take sum as this gives the total amount of emission

TotalE<-with(data=NEI,tapply(Emissions,year,sum))
year<-as.data.frame( names(TotalE))
TotalE <- as.data.frame(TotalE)

df<-cbind(year,TotalE)
names(df)<-c("Year","TotalE")
df$Year<- as.character(df$Year)



# creating the png file
png(filename = "plot1.png",width=480,height = 480,units = "px")

with(df,{
        plot(Year,TotalE,col="red")
        lines(Year,TotalE,col="red")
})


dev.off()