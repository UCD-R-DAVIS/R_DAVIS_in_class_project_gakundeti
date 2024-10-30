#call tidyverse to use the below file import statement
library(tidyverse)
#Reach in File
lap <- read_csv("https://raw.githubusercontent.com/ucd-cepb/R-DAVIS/refs/heads/main/data/tyler_activity_laps_10-24.csv")
str(running)

#Filter out non-running activities 
running<-filter(lap, sport %in% "running")


#Remove minute-per-mile less than 5 and greater than 10
running<-filter(running, minutes_per_mile <10 & minutes_per_mile > 5 & total_elapsed_time_s > 60)

#Create new categorical variable that categorizes minutes_per_mile in fast, medium, and slow
running$pace <- ifelse(running$minutes_per_mile < 6, 'Fast', 
                       ifelse(running$minutes_per_mile>=6 & running$minutes_per_mile<=8, "Medium",
                       ifelse(running$minutes_per_mile>8, "Slow", "NA")))

#Create new categorical variable that categorizes year into new and old
running$form <- ifelse(running$year %in% 2024, "new", "old")

#Identify average steps per minute for laps by form and pace, and generate a table showing values with old and new as seperate rows and pace categories as columns Make sure that slow speed is the second column, medium speed is the third column, 
#and fast speed is the fourth column
running %>% 
  group_by(form, pace) %>%
  summarize(average_steps_per_minute = mean(steps_per_minute, na.rm = TRUE)) %>%
  pivot_wider(names_from = pace, values_from = average_steps_per_minute) %>%
  select(form,Slow, Medium, Fast)

# Summarize steps per minute for Jan - Jun 2024
summary_months_jan_jun<-running %>% filter(year %in% 2024 & month<7 & month>0)%>%
summarize(
  min_steps = min(steps_per_minute, na.rm = TRUE), 
  mean_steps = mean(steps_per_minute, na.rm = TRUE),
  median_steps = median(steps_per_minute, na.rm = TRUE),
  max_steps = max(steps_per_minute, na.rm = TRUE)
)

#Summarize steps per minute for July - Oct 2024
summary_months_Jul_Oct<-running %>% filter(year %in% 2024 & month<11 & month>6) %>%
  summarize(
  min_steps = min(steps_per_minute, na.rm = TRUE), 
  mean_steps = mean(steps_per_minute, na.rm = TRUE),
  median_steps = median(steps_per_minute, na.rm = TRUE),
  max_steps = max(steps_per_minute, na.rm = TRUE)
)

