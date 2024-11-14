#tibble named surveys from portal_data_joined.csv file. 
surveys<-read_csv("data/portal_data_joined.csv")

#1 create surveys_wide  
surveys_wide <- surveys %>% filter(!is.na(hindfoot_length)) %>% # Remove Nas
  group_by(genus, plot_type) %>% #with column for genus and a column for plot type
  summarise(mean_hindfoot = mean(hindfoot_length)) %>% #mean hindfoot values for the group by statement
  pivot_wider(names_from = plot_type, values_from = mean_hindfoot) %>%#A column for genus and a column named after every plot type
  arrange(Control)#sorted by values in the Control plot type column

surveys_wide#view what transformation looks like
  
#2 Get quartile cutoffs 
summary(surveys$weight) 

#case_when to categorize weight_cat into "small" 1st: 20, "medium" is between 20 and 48, and "large" is greater than 48 
surveys %>% 
  mutate(weight_cat = case_when( 
    weight <= 20.00 ~ "small",
    weight > 20.00 & weight < 48.00 ~ "medium",
    weight >= 48.00 ~ "large"
  ))

#BONUS: 
df_quants <- 
  surveys %>% 
  drop_na(weight) %>% 
  
  summarize(quant25 = quantile(weight, probs = 0.25),#created quartiles 
            quant50 = quantile(weight, probs = 0.5), 
            quant75 = quantile(weight, probs = 0.75), 
            quant100 = quantile(weight, probs = 1))

  left_join(df_quants, by = 'method') %>% 
  mutate(tiles = 
           case_when(rank < quant25 ~ 'lowest 25%', #assigned value ranges to the quartiles
                     rank < quant50 ~ '25 to 50%', 
                     rank < quant75 ~ 'more than 50%', 
                     rank >= quant75 ~ 'highest 25%'))