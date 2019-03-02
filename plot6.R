library(ggplot2)

#SCC we need to find all the ones that are combustion and coal related and get the SCC code

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# we want to see how many SCC codes have motor vehicles, we took mobile on road
# we use the grep argument

mv <-SCC$SCC[grep("Mobile - On-Road",SCC$EI.Sector)]


# we need to subset the NCI list on the SCCs codes

Fi<-subset(NEI,(NEI$fips=="24510" | NEI$fips=="06037")& NEI$SCC %in% mv & (NEI$year==1999 | NEI$year==2008))

Fi$con <- paste(Fi$year,"_",Fi$fips,sep = "")

Emissions<-with(data=Fi,tapply(Emissions,con,sum))

Year_fips<-strsplit(names(Emissions),"_")

Y_F <- as.data.frame(Year_fips)
Y_T <- as.data.frame(t(Y_F))
TE <- as.data.frame(Emissions)

Final <- cbind(Y_T,TE)


names(Final)<-c("Year","fips","Emission")

png(filename = "plot6.png",width=480,height = 480,units = "px")
ggplot(data=Final,aes(x=Year,y=Emission,color=fips,group=fips))+geom_line()+geom_point()
dev.off()
