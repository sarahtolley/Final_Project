#Moreau data

library(ape)
library(geiger)

#get tree
my.phylo <- read.tree("~/Desktop/Moreau.newick.file.txt")


#species that we want to keep. List generated and formatted in python
species<- c("smaragdina", "laticeps", "epedana", "pallipes", "simoni", "mayri", "nitidiceps", "gracillipes", "texana", "stygia", "mocquerysi", "hispanicus", "ocreatus", "emeryi", "feae", "unimaculatus", "augustae", "unicorna", "concenta", "navajoa", "gilva", "gigantea", "imitator", "mayri", "wilverthi", "elegans", "hamatum", "brunneum", "negrosensis", "provancheri", "latispina", "hispanicum", "microps", "panamensis", "inexorata", "spadius", "spininodis", "alienus", "keiteli", "luctuosum", "transfuga", "latreillei", "mayri", "julianus", "destructor", "lobosa", "castanea", "fulviculis", "mexicanus", "incompleta", "brunnea", "williamsi", "rogeri", "nigrescens", "esenbecki", "glaber", "picardi", "clarus", "transversa", "insularis", "stigma", "clavata", "rhea", "wheeleri", "cordatus", "punctata", "maricopa", "vindex", "imparis", "batesi", "typhlops", "apache", "pulchella", "metallica", "snellingi", "opacum", "albipes", "tricarinatus", "hispidum", "jamaicensis", "subterranea", "rogenhoferi", "invicta", "pallipes", "texana", "punctata", "myops", "emeryi", "castanea", "butteli")
species2<- data.frame(species)

#split on underscore 
library(reshape2)
df<-colsplit(my.phylo$tip.label, "_", names = c("Genus", "Species"))
treespecies<- df[2]

#get rid of phylogenetic data from species not present in Russell data
dropset <- which(!treespecies$Species %in% species2$species)
#get names of species to remove from tree
dropnames<-df[dropset,]
#add underscore back in to match tips in tree
dropnames2 <- paste(dropnames$Genus, dropnames$Species, sep="_")

#prune tree
pruned.tree1<- drop.tip(my.phylo, my.phylo$tip.label[match(dropnames2, my.phylo$tip.label)])
#also need to get rid of Proatta butteli and Formica Wheeleri (matched species name belonging to different genus)
pruned.tree3<-drop.tip(pruned.tree1,"Proatta_butteli")
pruned.tree<-drop.tip(pruned.tree3, "Formica_wheeleri")

#list the new tip labels
pruned.tree$tip.label
write.tree(pruned.tree)


#this section is under construction see next section for plot
#add trait data to tree 
library(phylobase)
# infection: 0=no wolbachia infection, 1=wolbachia present in species
obj.tree<- phylo4d(as(pruned.tree,"phylo4"), data.frame(infection=c(0, 1, 0, 1, 0, 0, 1, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 1, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 0, 1, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0)))
print(obj.tree)
#now plot tree with infection presence 
plot(obj.tree)
#I cannot figure out how to reduce the tip label size in this plot, cex does not work here 


#show infected species on prunned tree in blue
plot(pruned.tree, cex=0.5, main= "Pruned Tree", tip.color=c("black", "blue", "black", "blue", "black", "black", "blue", "black", "black", "blue", "blue", "black", "black", "black", "black", "black", "black", "blue", "black", "black", "blue", "black", "black", "black", "black", "black", "black", "black", "blue", "black", "black", "blue", "black", "black", "black", "black", "black", "black", "black", "blue", "black", "black", "blue", "black", "blue", "black", "black", "black", "blue", "black", "black", "black", "blue", "blue", "black", "black", "black", "blue", "black", "black", "black", "black", "black", "blue", "blue", "blue", "black", "black", "black", "black", "black", "blue", "black", "blue", "black", "black", "black", "black", "black", "black", "black", "black"))










#sandbox(stuff I am working on)
library(corHMM)
#wolbachia infection status 
woldata <- read.csv("~/Desktop/test1.csv", header=T)
corHMM(pruned.tree, woldata, rate.cat=2, node.states="marginal")
corDISC(pruned.tree, woldata, ntraits=2, model="ARD")



branching.times(pruned.tree)
testdata <- read.csv("~/Desktop/test1.csv", header=T)
wol<-testdata$Infection
data<-data.frame(pruned.tree$tip.label,wol)
library(diversitree)
colnames(musse.multitrait.translate(2, depth=0))
set.seed(1)
phy<- tree.musse.multitrait(c(0, 1, 0, 1, 0, 0, 1, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 1, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 0, 1, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0), n.trait=2, depth=0, x0=c(0,0))


colnames(testdata)
set.seed(1)
trait.plot(pruned.tree, testdata)


library(diversitree)
trait.plot()


#combine data into phylo4d format
woltree<- phylo4d(pruned.tree, tip.data=woldata)
#extracts a phylo4 tree object from a phylo4d tree+data object 
extractTree(woltree)
try(phylo4d(as(pruned.tree,"phylo4"), data.frame(infection=c(0, 1, 0, 1, 0, 0, 1, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 1, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 0, 1, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0)), silent=TRUE)





#basic tree commands
#print the original file to R console so you can see the original Newick format
write.tree(my.phylo)
#Alternatively, read a Nexus formatted phylogeny into R 
my.nexus.phylo <- ("read.nexus.file.txt")
#print the original Nexus format to R console 
write.nexus(my.phylo)
#explore contents and structure of tree
my.phylo
is.rooted(my.phylo)
is.ultrametric(my.phylo)
names(my.phylo)
my.phylo$edge
my.phylo$tip.label
#ordered from the species on the bottom of the phylogeny when plotted
#plot 
plot(my.phylo)
#plot using fan type
plot(my.phylo, type="fan")
my.phylo$node.label
my.phylo$edge.length
#A vector of branch (i.e., edge) lengths is returned. The length of this vector is equal to the number of branches in our phylogeny, and the order of the values corresponds to the order of the branches described under my.phylo$edge . Thus, if we wanted to make a matrix that had the information regarding the node numbers for the beginning and end points of each branch in the first two columns and the length of that branch in the third column we could do the following:
cbind(my.phylo$edge, my.phylo$edge.length)