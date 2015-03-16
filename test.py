#need this in python 2
from __future__ import division

#create two empty variables to store data from loop 
genus_pos = []
genus_neg = []

#set the input file name
InFileName = "RussellData.py"

#open the input file for reading
InFile = open(InFileName, 'r')
#initialize the counter used to keep track of line numbers 
LineNumber = 0

#Loop through each line in the file
for Line in InFile:
	#skip the header line
    if LineNumber > 0:
    	#Remove the line ending characters 
        Line = Line.strip('\n')
        #subdivide by tabs
        ElementList = Line.split('\t')
        Genus = ElementList[3]
        Infection = ElementList[5]
        if Infection == '+':
        	genus_pos.append(Genus)
        else:
            genus_neg.append(Genus)
    LineNumber = LineNumber + 1
        
#close the file after the loop is completed
InFile.close()



#find genera that have both positive and negative infections 
mixed_genera = []
for element in genus_pos:
    if element in genus_neg:
        mixed_genera.append(element)

#write genera that have both infected and uninfected species to a file
f= open('mixed_genera.csv','w')
for element in mixed_genera:
    f.write(element+'\n')
f.close()



#only genera that are infected
only_pos_genera = []
for element in genus_pos:
    if element not in genus_neg:
        only_pos_genera.append(element)
#there are not any genera that are only positive for Wolbachia


#only genera that are NOT infected
only_neg_genera = []
for element in genus_neg:
    if element not in genus_pos:
        only_pos_genera.append(element)

#write only genera not infected to a file
f= open('negative_genera.csv','w')
for element in only_neg_genera:
    f.write(element+'\n')
f.close()


#write genus_pos to a file
f = open('all_pos.csv', 'w')
for element in genus_pos:
    f.write(element+'\n')
f.close()


#count the number of each genus that has a neg infection
f=open('neg_count3.csv','w')
for x in set(genus_neg):
        output="{0} {1}\n".format(x,genus_neg.count(x))
        f.write(output)



#use panda to count the number of times each value appears in a particular column
import csv
import pandas 
data = pandas.read_csv("Russell.csv", delimiter=r"\t")
datasub = data[data['Wolbachia'] == '+']
print datasub.groupby(['Genus'])['Wolbachia'].count() 

wol = data.groupby(['Genus'])['Genus'].count()
print wol.sort




#get names of species represented in Moreau tree
phylo = []
ants = []
newants = []
#extract species list from data
with open('RussellData.py') as infile:
    for line in infile:
        ants.append(line.split()[4])
#remove "sp." from list 
for element in ants:
    if 'sp.' not in element:
        newants.append(element)
#make list of species with known tree data 
for element in newants:
    if element in open('Moreau.newick.file.txt').read():
        phylo.append(element)
#count how many species returned, 90
print len(phylo)
#write to a new file
f = open('species2.txt', 'w')
for element in phylo:
    f.write(element+'\n')
f.close()






