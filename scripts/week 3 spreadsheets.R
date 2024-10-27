?read.csv #is linked to read.table
surveys <- read.csv("data/portal_data_joined.csv")#reads in the surveys csv file 
str(surveys)#shows an overview of surveys object 
surveys #prints out the object truncated into the console
class(surveys) #tells you this is a data frame object
nrow(surveys)#how many rows
ncol(surveys)#how many columns
head(surveys) #shows the top 6 rows which is the default 
head(surveys, n = 11) #customized how many rows on the top it reads
tail(surveys) #shows the bottom bottom 7 rows
summary(surveys) #descriptive summary on every column it finds but limited 
surveys$sex
summary(object = surveys) #you can feed in an object
surveys[]#brackets means we are pulling things out of an object, for a vector we only put one dimension, but for a data frame there are rows and columns 
surveys[1,3] #means looking at a value in row 1 and column 3
head(surveys, 1) #shows the value is 16 in the third column
surveys[1,]#mulitple values can be pulled - means show all the values in the first row
surveys[,1] #shows all the values in the first column
surveys[1] #if you forget to specify x and y dimiension you end up with the first column 
head(surveys[1])
head(surveys[,1])#both of these show the same outcome
surveys[1:3,] #this gives the first three rows
surveys[,1:3] #gives the first three columns
surveys[1:3, 1:3] #gives the first three rows and first three columns
surveys[c(1,4,10), c(2,4,6)]#if mulitple rows not in a sequence you need to concatenate and get weird table 
surveys[-1,]#to remove the first row from the data frame
surveys[,-1]#removes the first column
surveys[-c(7:nrow(surveys)),] #this is the equivalent of removing all rows from 7 to above and head is returning only first last 6
head(surveys)
c(7:nrow(surveys))#covers 7 to the very last row of surveys
nrow(surveys)==34786
head(surveys["genus"])#returns the genus column
head(surveys[,"genus"])#NOT GENERATING A DIFFERENT LAYOUT
class(head(surveys["genus"])) #NOT WORKING dataframe subset just for this value
class(head(surveys[,"genus"]))#NOT WORKING character just returns values but not the dataframe
class(surveys[["genus"]])#character with all the values just like with the blank comma genus version
head(surveys[["genus"]])#a shorter list
surveys$record_id#selects particular column in a dataframe this is an object name of a column so returns the record_id values

install.packages('tidyverse')
library(tidyverse) #not ready to use

t_surveys <-read_csv("data/portal_data_joined.csv")
t_surveys
class(t_surveys)#tibble wrapper is a dataframe and gives some commentary 
surveys[,1]#NO DIFFERENCE
t_surveys[,1]#NO DIFFERENCE






