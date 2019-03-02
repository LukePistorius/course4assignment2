library(ggplot2)

#SCC we need to find all the ones that are combustion and coal related and get the SCC code

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# we want to see how many SCC codes have motor vehicles, we took mobile on road
# we use the grep argument

mv <-SCC$SCC[grep("Mobile - On-Road",SCC$EI.Sector)]


# we need to subset the NCI list on the SCCs codes

Fi<-subset(NEI,NEI$fips=="24510" & NEI$SCC %in% mv & (NEI$year==1999 | NEI$year==2008))

Emissions<-with(data=Fi,tapply(Emissions,year,sum))
Year <- names(Emissions)

Final<-as.data.frame( cbind(Year,Emissions))
Final$Emissions <- as.numeric(as.character( Final$Emissions))

png(filename = "plot5.png",width=480,height = 480,units = "px")
ggplot(data = Final, aes(x=Year, y = Emissions))+geom_point()
dev.off()