#tidyverse package call
library(tidyverse)

#Load survey data frame with the read.csv() function
surveys <- read.csv("data/portal_data_joined.csv")

#See structure of the portal_data_joined table
str(surveys)

#Create surveys_base by selecting only four variables
surveys_base <- select(surveys, species_id, weight, plot_type)

#Only print 5000 rows for surveys_base
surveys_base<- head(surveys_base, n=5000)

#Converts both specie_id and plot_type into factors
surveys_base$species_id<- factor(surveys_base$species_id)
surveys_base$plot_type <- factor(surveys_base$plot_type)

#Removes na's from the weight column
surveys_base_wna <-subset(surveys_base, complete.cases(weight))

#Returns the count of na's in a column - since value 0 this confirms na's have been removed
sum(is.na(surveys_base_wna$weight))

#Challenge selects the weight greater than 150 in column 2 which is the weight column
surveys_base_wna <- surveys_base_wna[surveys_base_wna[, 2]>150,]

#Without Tydiverse surveys_base <- surveys[,C("species_id", "weight", "plot_type)]
surveys_base<- surveys[1:5000, c("species_id", "weight", "plot_type")]



