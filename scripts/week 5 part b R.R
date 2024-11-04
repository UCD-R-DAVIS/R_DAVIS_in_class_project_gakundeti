library(tidyverse)
tail<- read_csv('data/tail_length.csv')
head(tail)
dim(tail)

#join_function(data frame a, data fame b, how to join)
#inner_join(data frame a, data frame b, common id)
#inner_join only keeps records that are in both data frames
surveys<-read_csv("data/portal_data_joined.csv")
dim(inner_join(x=surveys, y=tail, by= "record_id"))
dim(surveys)
dim(tail)

#left_join
#left_join takes dataframe x and dataframe y and it looks for any id in y that exists in x and appends it to x - keeps everything that is in the lefthand side and matches in the righthand side
#leftjoin(x,y) == right_join(Y,x)
surveys_left_joined <- left_join(x=surveys, y=tail, by = 'record_id')
dim(surveys_left_joined)

#right_join takes dataframe x and and it keeps everything in y and only matches in x keeps everything in the righthand side and matches on the lefthand side
#right_join(x,y) == left_join(y,x)
surveys_right_joined <- right_join(y=surveys, x=tail, by = 'record_id')
dim(surveys_right_joined)

#full_join(x,y)
#full_join keeps everything 
#weird things can happen here, like if there are record_ids in surveys but not in tail when merged with tail for that nonexistent record_id it will create a bunch of NA's or expands out
surveys_full_joined <-full_join(x = surveys, y= tail)
dim(surveys_full_joined)

#Pivot_wider makes data with more columns 
#names_from we are taking names of columns and values_from we are indicating where to pull values from 
#NAs come back in because when we don't have values for mean_weight but we have a plot_id then the empty fields get NAs
surveys_mz<-surveys_mz <- surveys %>%
  filter(!is.na(weight)) %>%
  group_by(genus, plot_id)%>%
  summarize(mean_weight = mean(weight))

surveys_mz
unique(surveys_mz$genus)

wide_survey<- surveys_mz %>%
  pivot_wider(names_from = 'plot_id', values_from = 'mean_weight')

head(wide_survey)

#Pivot_longer makes data with more rows
#we have 25 columns one of those is genus, minus genus, every column you see we want to make it one column called plot_iD and the values we want those stored in a column next to it as mean weight
surveys_long<-wide_survey %>% pivot_longer(-genus, names_to='plot_id', values_to = 'mean_weight')
head(surveys_long)

surveys_long<-wide_survey %>% pivot_longer(-genus, names_to='plot_id', values_to = 'mean_weight')
#took out genus R says you need to give one column not modifying so that we have a basis
#not specifying the values_to, R assumes that all other values in the mean_weight value are what you want the third column and just gives arbitrary name




  




