
#to hide files put into .DS_Store
library(tidyverse)#the install is a one and the library is each time
#dplyr is great for data table manipulation and tidyr helps you switch between data formats
#tidyr produces predictable results (base R functionality can vary by data type), good for new learners because syntax is consistent, avoids hidden arguments and dafault settings of base R functionality
library(tidyverse)
surveys <-read_csv("data/portal_data_joined.csv")#read in data file using the read_csv which is from the tydverse package
view(surveys)#this opens the file into a new window
str(surveys)#gives overview of structure the variables and format type 
month_day_year <- select(surveys, month, day, year)#selects specific variables from the surveys file
filter(surveys, year ==1981)#allows you to filter out certain rows that meet your criteria to be just year 1981
year_1981<-filter(surveys, year ==1981)#this creates a new variable and will show-up in output don't name a variable starting with a number
filter(surveys, year %in% c(1981:1983)) #filtering mulitple years - %in% does bucket matching
filter(surveys, year == c(1981, 1982, 1983)) #the warning of the multiple of shorter object length == is index level matching does the first row match 1981, does the second row match 1982, and does the third year match 1983 and then recycles back so fewer observaions are obtained. so row 2 is only getting checked for 1982 and not the other two years
bigfoot_with_weight<- filter(surveys, hindfoot_length > 40 & !is.na(weight))#filtering for a large foot and that there is something in the cell for weight
small_animals <- filter(surveys, weight <5)#only small animals we've created an intermediate data frame for our filtering so kind of dangerous
small_animals_ids <-select(small_animals, record_id, plot_id, species_id )#filters several varibales in small animals better to nest functions
small_animal_ids <- select(filter(surveys, weight <5), record_id, plot_id, species_id ) #combines the two steps but is still clunky 

#Piping only exists in %>% tydyvers but in base R there is |>
small_animal_ids <- filter(surveys, weight <5) %>% select(record_id, plot_id, species_id)#put filtering statement first and then selected statement, always read a pipe from left to right and that filtered statement becomes the file we are selecting from without directly saying it
small_animal_ids <- surveys %>% filter(weight <5) %>% select(record_id, plot_id, species_id)#this calls the surveys first and then filter and then select on the survey 
surveys %>% filter(month==1)#R understands this as code and does a tab

surveys %>%
  filter(month==1)#R understands this as code and does a tab

surveys
%>% filter(month==1)#R doesn't understand this as one code, don't create a break before the %>%
#line break rules: after open parenthesis, pipe, 
#commas,
#or anything that shows the line is not complete yet


library(tidyverse)
surveys<- read_csv("data/portal_data_joined.csv")

#Mutate cases where you want to create a new column of data in your dataframe 
surveys <- surveys%>%
   mutate(weight_kg = weight/1000)
 str(surveys)
 
#Mutate by creating multiple columns and you can call on a variable you created
 surveys <- surveys %>%
   mutate(weight_kg = weight/1000, 
          weight_kg2 = weight_kg*2)
   
str(surveys)

#Filter out na's
surveys <- surveys %>% 
  filter(!is.na(weight)) %>%
  mutate(weight_kg = weight/1000, 
         weight_kg2 = weight_kg*2)
str(surveys)
head(surveys)#only shows first 10 columns

#group by allows you to create groups for analysis 
surveys2<-surveys %>%
  group_by(sex) %>%
  mutate(mean_weight = mean(weight))
str(surveys2)

#Summarize collapses down our surveys into just the sex group giving us the mean weight
surveys3<-surveys %>%
  group_by(sex) %>%
  summarize(mean_weight = mean(weight))
str(surveys3)
#Group by and Summarize by multiple variables
surveys4<-surveys %>%
  group_by(sex, species_id) %>%
  summarize(mean_weight = mean(weight))
str(surveys4)

#This shows decending wait
surveys %>%
  group_by(sex, species_id) %>%
  summarize(mean_weight = mean(weight))%>%
  arrange(mean_weight)
#This shows accending weight
surveys %>%
  group_by(sex, species_id) %>%
  summarize(mean_weight = mean(weight))%>%
  arrange(-mean_weight)

#summarize multiple values 
surveys %>%
  group_by(sex, species_id) %>%
  summarize(mean_weight = mean(weight), min_weight = min(weight))%>%
  arrange(-mean_weight)

