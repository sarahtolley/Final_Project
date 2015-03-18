#load ggplot2 library
library(ggplot2)

#read in species list
Russell<- read.csv("~/Desktop/russellmeta.csv", header=T)

#plot all genera surveyed with the fill as Wolbachia infection 
ggplot(Russell, aes(x=Genus, fill=Wolbachia)) + geom_bar() + theme(axis.line=element_blank(),axis.text.x=element_blank(),      panel.background=element_blank(),panel.border=element_blank(),plot.background=element_blank())


#life history data
lifehis<- read.csv("~/Desktop/newdata.csv", header=T)
#plot colony propagation strategy for surved species 
ggplot(lifehis, aes(x=colony_propagation, fill=Infection_status)) + geom_bar(stat="bin", position=position_dodge()) + theme(panel.background=element_blank(),panel.border=element_blank(),plot.background=element_blank(), axis.line=element_blank(),axis.text.y=element_blank())








#sandbox (things I am working on)
mixed<- read.csv("~/Desktop/mixed_genera.csv")
ggplot(mixed, aes(x=Genus))+ geom_bar()

all_pos <- read.csv("~/Desktop/all_pos.csv", header=T)
ggplot(all_pos, aes(x=All_positive_genera))+ geom_bar(position=position_dodge())
ggplot(mixed, aes(x=All_positive_genera, fill=Mixed))+geom_bar()


neg<- read.csv("~/Desktop/neg_count3.csv", header=T)
ggplot(neg, aes(x=Genus, y=Sum))+ geom_bar(stat="identity") 
qplot(All_positive_genera, data= all_pos, geom = "histogram", binwidth = 0.01)



head(lifehis[,c("Genus", "Species", "Infection_status", "reproduction", "colony_propagation", "social_structure")], 3)


corr<- read.csv("~/Desktop/corr.csv", header=T)
data=data.frame(lifehis(c("Genus", "Species", "Infection_status", "reproduction", "colony_propagation", "social_structure"))
library(ellipse)
ctab <- cor(data, aes(x=Infection_status))






