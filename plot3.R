library(ggplot2)

 NEI<- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#Have total emissions from PM2.5 decreased in the Baltimore City, 
#Maryland (\color{red}{\verb|fips == "24510"|}fips=="24510") from 1999 to 2008? 
#Use the base plotting system to make a plot answering this question.

# we first create a new data frame with the years and the location we want

mary <- subset(NEI,NEI$fips=="24510" & (NEI$year==1999 | NEI$year==2008))

# concatenating the different types, so it's easy to make the sum for each instance

mary$con <- paste(mary$year,"_",mary$type,sep = "")

# calculating the sum (tapply will return a list)

TotalE<-with(data=mary,tapply(Emissions,con,sum))

# we first need to split the names of the list again in years and type

Year_Type<-strsplit(names(TotalE),"_")

Y_T <- as.data.frame(Year_Type)
Y_T <- as.data.frame(t(Y_T))
TE <- as.data.frame(TotalE)

Final <- cbind(Y_T,TotalE)


names(Final)<-c("Year","Type","Emission")

png(filename = "plot3.png",width=480,height = 480,units = "px")

ggplot(data=Final,aes(x=Year,y=Emission,color=Type,group=Type))+geom_line()+geom_point()

dev.off()

