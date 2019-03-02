library(ggplot2)
# in SCC we need to find all the ones that are combustion and coal related and get the SCC code

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# we want to see how many SCC codes have combustion and coal in them
# we use the grep argument

comb <-SCC$SCC[grep("Comb",SCC$EI.Sector)]
coal <- SCC$SCC[grep("Coal",SCC$EI.Sector)]

# using comb %in% coal we see that all the Coal is also combustion, but in case this is not the case:

CinC<-comb %in% coal
CinC<-as.data.frame(CinC)
comb<-as.data.frame(comb)
SCCs<-cbind(CinC,comb)
SCCs<-SCCs[CinC==TRUE,]

# we need to subset the NCI list on the SCCs codes

Fi<-subset(NEI, NEI$SCC %in% SCCs$comb & (NEI$year==1999 | NEI$year==2008))

Emissions<-with(data=Fi,tapply(Emissions,year,sum))
Year <- names(Emissions)

Final<-as.data.frame( cbind(Year,Emissions))
Final$Emissions <- as.numeric(as.character( Final$Emissions))

png(filename = "plot4.png",width=480,height = 480,units = "px")
ggplot(data = Final, aes(x=Year, y = Emissions))+geom_point()
dev.off()