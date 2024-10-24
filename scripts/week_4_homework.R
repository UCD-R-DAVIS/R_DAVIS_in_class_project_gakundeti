library("dplyr")
library("tidyverse")
#creating a tibble named surveys
surveys <- read_csv("data/portal_data_joined.csv")

#keep rows with weight between 30 and 60
surveys_sub <- filter(surveys, weight > 30 & weight <60)

#prints the first 6 rows
head(surveys_sub, 6)

#summary to see if there are NAs 
summary(surveys_sub$weight)

#maximum weight for each species + sex combination and name it biggest_critters
biggest_critters <-surveys %>%
  filter(!is.na(weight)) %>%
  group_by(sex) %>%
  summarize(max_weight = max(weight),
            min_weight = min(weight))

#where the NA weights are concentrated in the data - tally by taxa was the easiest to understand where the NAs were located  
surveys %>% arrange(!is.na(weight), weight) %>% group_by(taxa) %>% tally()

surveys %>% 
  arrange(!is.na(weight), weight) %>% group_by(plot_id) %>% tally()

surveys %>% 
  arrange(!is.na(weight), weight) %>% group_by(species_id) %>% tally()

#remove the rows where weight is NA and add a column that contains the average weight of each species+sex combination to the full surveys dataframe. Then get rid of all the columns except for species, sex, weight, and your new average weight column. Save this tibble as surveys_avg_weight.
surveys_avg_weight <-surveys %>%  filter(!is.na(weight)) %>%
  group_by(species_id, sex) %>% mutate(avg_weight=mean(weight)) %>% select(species_id, sex, weight, avg_weight)

surveys_avg_weight

#surveys_avg_weight and add a new column called above_average that contains logical values stating whether or not a row’s weight is above average for its species+sex combination 
surveys_avg_weight %>% mutate(above_average = weight > avg_weight)



