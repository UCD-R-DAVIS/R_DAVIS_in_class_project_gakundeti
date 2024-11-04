#if then else logic to help set an action
library(tidyverse)
surveys <- read_csv("data/portal_data_joined.csv")
str(surveys)

#we can see there are a lot of NAs
summary(surveys$hindfoot_length)

#pseudocode writing out steps of what you want code to do before you actaully write out the code 
# if then else statement(test or condition, what to do if the test is yes/true, what to do if its false/no)

#boolean test is identifying values that are less than 29.29 as true and greater than 29.29 as false
surveys$hindfoot_length < 29.29

#ifelse is conditional logic categorzing those larger than 29.29 as big and everthing else small
surveys$hindfoot_cat <- ifelse(surveys$hindfoot_length < 29.29, yes = "small", no = "big")

#shows the transformation from the above logic 
head(surveys$hindfoot_cat)
#this shows what it had been before to ensure that your logic holds
head(surveys$hindfoot_length)

surveys$hindfoot_length <- ifelse(surveys$hindfoot_length <mean
                                  (surveys$hindfoot_length, na.rm = TRUE), yes = "small", no = "big")


head(surveys$hindfoot_cat)

#ifelse is helpful when you have two conditions anymore than that gets messy. There is also case_when that expands out arguments
surveys %>%
  mutate(hindfoot_cat = case_when(
    hindfoot_length > 29.29 ~ "big", 
    is.na(hindfoot_length) ~ NA_character_, #this is R's way of knowing that it is a character, also other types: NA_integer_
    TRUE ~ "small"#everything else gets captured with the samll that isn't captured with the first category
  )) %>%
  select(hindfoot_length, hindfoot_cat) %>%
  head()#with NA statement we see all the NA values remaining as NA

#Adding another line in conditional argument to capture medium category
surveys %>%
  mutate(hindfoot_cat = case_when(
    hindfoot_length > 31.5 ~ "big",
    hindfoot_length > 29 ~ "medium",
    is.na(hindfoot_length) ~ NA_character_, #this is R's way of knowing that it is a character, also other types: NA_integer_
    TRUE ~ "small"#everything else gets captured with the samll that isn't captured with the first category
  )) %>%
  select(hindfoot_length, hindfoot_cat) %>%
  head()

#This shows up the number of cases in each of our categories using the groups and tallys
surveys %>%
  mutate(hindfoot_cat = case_when(
    hindfoot_length > 31.5 ~ "big",
    hindfoot_length > 29 ~ "medium",
    is.na(hindfoot_length) ~ NA_character_, #this is R's way of knowing that it is a character, also other types: NA_integer_
    TRUE ~ "small"#everything else gets captured with the samll that isn't captured with the first category
  )) %>%
  select(hindfoot_length, hindfoot_cat) %>%
  group_by(hindfoot_cat) %>%
  tally()












surveys <- read_csv("data/portal_data_joined.csv")
#ifeslse 
surveys$hindfoot_cat <- ifelse(surveys$hindfoot_length < mean
(surveys$hindfoot_length, na.rm = TRUE), yes = "small", no = "big")
surveys

head(surveys$hindfoot_cat)
head(surveys$hindfoot_length)
summary(surveys$hindfoot_length)
unique(surveys$hindfoot_cat)
mean(surveys$hindfoot_length, na.rm = FALSE)

surveys %>%
  mutate(hindfoot_cat = case_when(hindfoot_length >  29.29 ~ "big", TRUE ~ "small")) %>% select(hindfoot_length, hindfoot_cat) %>% head()

table(surveys$hindfoot_cat)

surveys %>% mutate(hindfoot_cat = case_when(hindfoot_length >31.5 ~ "big", hindfoot_length > 29 ~ "medium", is.na(hindfoot_length) ~ NA_character_, TRUE ~ "small")) %>% select(hindfoot_length, hindfoot_cat) %>% head(100)

tail <-read_csv('data/tail_length.csv')
dim(tail)
dim(surveys)
head(tail)
surveys_inner<-inner_join(x=surveys, y=tail)
dim(surveys_inner)
head(surveys_inner)

surveys_left <- left_join(x=surveys, y= tail)
dim(surveys_left)
surveys_right <- right_join(x= surveys, y= tail)
dim(surveys_right)
full_join <- full_join(surveys,tail)

all(surveys$record_id %in% tail$record_id)
all(tail$record_id %in% surveys$record_id)

left_join(surveys,tail %>% select(-record_id))

left_join(surveys, tail %>% rename(record_id2 = record_id), by = c('record_id'='record_id2'))

surveys %>% surveys_mz %>% pivot_wider(id_cols = 'genus', names_from = 'plot_id', values_from = 'mean_weight')




length(month_day_year)
nrow(month_day_year)
year_1981 <- filter(surveys, year == 1981)

sum(year_1981$year !=1981, na.rm = T)

year_1981 <- filter(surveys, year ==1981)
year_1981_baser <- surveys[surveys$year == 1981,]
identical(year_1981, year_1981_baser)

surveys <- surveys[surveys$year %in% 1981:1983,]

#difference between the two is recycle is checking what each row is in and then recycles again and the lengths are not the same
the80stidy <- filter(surveys, year %in% 1981:1983)
the80srecycle <- filter(surveys, year == c(1981:1983))




small_animals_ids <- select(filter(surveys, weight <5), record_id, plot_id, species_id)

#piping %>% or |>
small_animal_ids <- surveys %>% filter(., weight < 5) %>% select(., record_id, plot_id, species_id)


surveys %>% filter(
  month == 1)

mini <- surveys[190:209,]
table(mini$species_id)
nrow(mini)

test <- mini %>% filter(species_id %in% c("DM", "NL"))


str(surveys)


               
               
               
               
               
               
               