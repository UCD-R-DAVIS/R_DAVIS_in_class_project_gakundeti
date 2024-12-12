library (tidyverse)
surveys <- read.csv("data/portal_data_joined.csv")

#Using a for loop, print to the console the longest species name of each taxon. 
#Hint: the function nchar() gets you the number of characters in a string.
for(i in unique(surveys$taxa)){ #creating a loop for unique taxa within the survey dataset 
  mytaxon <- surveys[surveys$taxa == i, ] #loop will run through the taxa variable in the surveys dataset
 longestnames <- mytaxon[nchar(mytaxon$species & mytaxon$taxa) == max(nchar(mytaxon$species & mytaxon$taxa)),] %>% select(species) #use the nchar to get number in a string but keep those that are max and use select to pull those that meet function criteria
 print(unique(longestnames$species, longestnames$taxa))#print in the console the longest names for each species type 

}
  
#Use the map function from purrr to print the max of each of the columns:
#"windDir", "windSpeed_m_s", "baro_hPa", "temp_C_2m", "temp_C_10m", "temp_C_towertop", "rel_humid", and "precip_intens_mm_hr"
mloa <- read_csv("https://raw.githubusercontent.com/ucd-cepb/R-DAVIS/master/data/mauna_loa_met_2001_minute.csv")

mycols <- mloa %>% select("windDir","windSpeed_m_s","baro_hPa","temp_C_2m","temp_C_10m","temp_C_towertop","rel_humid", "precip_intens_mm_hr")#create a list of variables to query max values from
mycols %>% map(max, na.rm = TRUE)#find the max value in each variable from the mcols list 


#Make a function called C_to_F that converts Celsius to Fahrenheit. 
#Hint: first you need to multiply the Celsius temperature by 1.8, then add 32. 
#Make three new columns called “temp_F_2m”, “temp_F_10m”, and “temp_F_towertop” 
#by applying this function to columns “temp_C_2m”, “temp_C_10m”, and “temp_C_towertop”. Name new columns for Farhenheit

#Applies the function across the specified variables in mloa 
mloa[c("temp_C_2m", "temp_C_10m","temp_C_towertop")] <- lapply(mloa[c("temp_C_2m","temp_C_10m", "temp_C_towertop")], function(x) x * 1.8 + 32)

#Renames the variables to to Fahrenheit
mloa <- mloa %>% 
  rename("temp_F_2m" = "temp_C_2m",
         "temp_F_10m" = "temp_C_10m",
         "temp_F_towertop" = "temp_C_towertop") 

#This repeats the above but within a line, selecting the variables, map_df applies the function created, rename changes the c to f, and cbind merges two data frames  
C_to_F <- function(x){
  x * 1.8 + 32
}
mloa %>% select(c("temp_C_2m", "temp_C_10m", "temp_C_towertop")) %>% map_df(C_to_F) %>% rename("temp_F_2m"="temp_C_2m", "temp_F_10m"="temp_C_10m", "temp_F_towertop"="temp_C_towertop") %>% cbind(mloa)

#Use lapply to create a new column of the surveys dataframe that includes the genus and species name together as one string.
#lapply applies a function across variables, length is a dynamic action that accomodates dynamic lengths of differing species names and paste0 concatenates genus to species seperated by a space
surveys$genusspecies <- lapply(1:length(surveys$species), function(i){
  paste0(surveys$genus[i], " ", surveys$species[i])
})   
  
