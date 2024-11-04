library("dplyr")
library("tidyverse")
#creating a tibble named surveys
surveys <- read_csv("data/portal_data_joined.csv")

#keep rows with weight between 30 and 60. TO do this we use the filter function and use inequality logic
surveys_sub<- filter(surveys, weight > 30 & weight <60)  

#prints the first 6 rows by using the head function
head(surveys_sub, 6)

#combine the to separate steps
surveys %>% filter(weight %in% 30:60) %>% head (n=5)

#summary to see if there are NAs 
sum(is.na(surveys_sub))


# using a tibble to create the maximum weight for each species + sex combination and name it biggest_critters. Using filter not na to remove from weight, then use group by speciesid and sex and then you can summarize to get the statistics  and then arrange to get the max weight
biggest_critters <-surveys %>%
  filter(!is.na(weight)) %>%
  group_by(species_id, sex) %>%
  summarize(max_weight = max(weight),
            min_weight = min(weight)) %>%
  arrange((max_weight))

# this arranges biggest animals in ascending order 
biggest_critters %>% arrange(desc(max_weight))

#where the NA weights are concentrated in the data - tally by taxa was the easiest to understand where the NAs were located. Arrange and grouping and tally are all helpful in pull NAs to the top   
surveys %>% arrange (is.na(weight), weight) %>% group_by(taxa) %>% tally()

surveys %>% 
  arrange(!is.na(weight), weight) %>% group_by(plot_id) %>% tally()

surveys %>% 
  arrange(!is.na(weight), weight) %>% group_by(species_id) %>% tally()

surveys %>% 
  arrange(!is.na(weight), weight) %>% group_by(year) %>% tally()

#remove the rows where weight is NA and add a column that contains the average weight of each species+sex combination to the full surveys dataframe. Then get rid of all the columns except for species, sex, weight, and your new average weight column. Save this tibble as surveys_avg_weight.
surveys_avg_weight <-surveys %>%  filter(!is.na(weight)) %>%
  group_by(species_id, sex) %>% mutate(avg_weight=mean(weight)) %>% select(species_id, sex, weight, avg_weight)

surveys_avg_weight

# Take surveys_avg_weight and add a new column called above_average that contains logical values stating whether or not a row’s weight is above average for its species+sex combination
surveys_avg_weight <-surveys_avg_weight %>%  mutate(above_average = weight >avg_weight)

surveys_avg_weight
