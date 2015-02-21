#need this in python 2
from __future__ import division

#navigate to Final_Project2 directory
#load data file into ipython
#my_file = open("RussellData.py")

#print file in ipython
#my_file.read()

# find how many species are positive for Wolbachia infection
#positive = my_file.read().count('+')
#print positive
# there are 155 + and 300 - from list

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
        #print the line
        print LineNumber, ":", ElementList
    LineNumber = LineNumber + 1
        
#close the file after the loop is completed
InFile.close()

#if I want to look at certain elements of each line
#print ElementList[4], ElementList[1],ElementList[3]
#print "Genus: %s\tSpecies: %s\tInfection: %s" % (ElementList[4], ElementList[5], ElementList[6])




#print genus name for infected ants
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
        	print Genus
    LineNumber = LineNumber + 1
        
#close the file after the loop is completed
InFile.close()

