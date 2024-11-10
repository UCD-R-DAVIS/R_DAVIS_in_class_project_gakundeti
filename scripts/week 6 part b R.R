library(tidyverse)
surveys_complete <- read_csv('data/portal_data_joined.csv') %>%
  filter(complete.cases(.))

#count function is a quick way of counting how many you see of observations that have a particular combo of variables 
yearly_counts <-surveys_complete %>% count(year, species_id)
surveys_complete %>% group_by(year, species_id) %>% tally()

#you can see these two sets are identical 
head(surveys_complete %>% count(year, species_id))
head(surveys_complete %>% group_by(year, species_id) %>% tally())

yearly_counts <-surveys_complete %>% count(year, species_id)
head(yearly_counts)

#ggplot eats data in long format - ggplot doesn't like wide
#time keep on x axis and use + to sting objects we are not feeding things beyond
# plus is to add layers
ggplot(data=yearly_counts, mapping = aes(x= year, y=n))+
  geom_point()

#the line plot is working tracing through the first observation 
#then goes straight down through all values in that year and then hops 
#up to the next values its lumping all values together
ggplot(data = yearly_counts, mapping = aes(x = year, y = n))+
  geom_line()

#better to add a grouping variable, now we can draw a line for each species 
#when we add group by
ggplot(data = yearly_counts, mapping = aes(x = year, y = n, group = species_id))+
  geom_line()

#to tell which species is which lets add color and you don't need to 
#have group by because color acts as a group
ggplot(data = yearly_counts, mapping = aes(x = year, y = n, group = species_id, color = species_id))+
  geom_line()

#facetting we can give each species a seperate plot so that 
#we can see more easily the distinct groups, facet-wrap shows plot
#varying by species id similar to a regression analysis
ggplot(data = yearly_counts, mapping = aes(x = year, y = n)) +
  geom_line() + 
  facet_wrap(~ species_id)

#facet warp has some features such as adding rows
ggplot(data = yearly_counts, mapping = aes(x = year, y = n)) +
  geom_line() + 
  facet_wrap(~ species_id, nrow = 4)

#facet warp also can add column option  
ggplot(data = yearly_counts, mapping = aes(x = year, y = n)) +
  geom_line() + 
  facet_wrap(~ species_id, ncol = 4)

#can also adjust the scale to see changes within a particular species over 
#time versus the more frequent animals or temporal distribution
#scales equal free it lets scale vary so access are more different
#to show more of the fluctuations, the plot only plots the time window shown for 
#each species
ggplot(data = yearly_counts, mapping = aes(x = year, y = n)) +
  geom_line() + 
  facet_wrap(~ species_id, scales= 'free')
