#Read in the file tyler_activity_laps_12-6.csv from the class github page. 
#This file is at url https://raw.githubusercontent.com/UCD-R-DAVIS/R-DAVIS/refs/heads/main/data/tyler_activity_laps_12-6.csv, 
#so you can code that url value as a string object in R and call read_csv() on that object. 
#The file is a .csv file where each row is a “lap” from an activity Tyler tracked with his watch.
library(tidyverse)
library(dplyr) 
library(ggplot2)
library (readr)
library(lubridate)

Tyler_Laps <- "https://raw.githubusercontent.com/UCD-R-DAVIS/R-DAVIS/refs/heads/main/data/tyler_activity_laps_12-6.csv"
Tyler_Laps_CSV <- read_csv(Tyler_Laps)

#Filter out any non-running activities.
running_sport<-filter(Tyler_Laps_CSV, sport == "running")

#We are interested in normal running. You can assume that any lap with a pace 
# 10 minutes_per_mile pace is walking, so remove those laps. 
#You should also remove any abnormally fast laps (< 5 minute_per_mile pace) 
#and abnormally short records where the total elapsed time is one minute or less.
running_sport<- filter(Tyler_Laps_CSV, minutes_per_mile > 5 & minutes_per_mile < 10 & total_elapsed_time_s<60)                      


#Group observations into three time periods corresponding to pre-2024 running, 
#Tyler’s initial rehab efforts from January to June of this year, 
#and activities from July to the present.
running_sport <- running_sport  %>%
  mutate(running_date = as.Date(timestamp), #use avaliable time variable to create categories off of called period
         period = case_when(running_date < as.Date("2024-01-01") ~ "pre_2024_effort",
                            running_date >= as.Date("2024-01-01") & running_date < as.Date("2024-06-01") ~ "Jan_Jun_2024_effort",
                            running_date >= as.Date("2024-06-01") ~ "post_Jun_effort"))#create categories in the period variable

#Make a scatter plot that graphs Steps per minute by minutes per mile 
ggplot(running_sport, aes(x=minutes_per_mile , y=steps_per_minute )) + geom_point() + 
 theme_minimal()

#Make 5 aesthetic changes to the plot to improve the visual.
#Add linear (i.e., straight) trendlines to the plot to show the relationship 
#between speed and SPM for each of the three time periods (hint: you might 
#want to check out the options for geom_smooth())

ggplot(running_sport, aes(x=minutes_per_mile , y=steps_per_minute, color = period)) +#introduce color by period categories
  geom_point(alpha = 0.7, size = 2, shape = 16) + #change the size of dots
  geom_smooth(method=lm, color = 'black', linetype = 'dashed') + #add a trend line
  scale_color_brewer(palette = "Dark2") + #color based upon period
  labs(title = "Speed by Steps per Period",
       x = "Minutes Per Mile",
       y = "Steps per Minute",
       color = "Effort Time Period") + #add titles
  theme_minimal(base_size = 14) +
  theme(legend.position = "bottom", plot.title = element_text(hjust = 0.5)) #center the titles and add a legend at bottom


#Use the timestamp indicator to assign lap numbers, assuming that all laps on a 
#given day correspond to the same run (hint: check out the rank() function). 
running_sport <- running_sport %>%
  group_by(running_date) %>%#group running dates prior to rank
  mutate(lap_number = rank(running_date, ties.method = "first")) %>%#create new variable to hold lap numbers using rank to generate the count
  ungroup() 

#Select only laps 1-3 (Tyler never runs more than three miles these days).
#Focus just on post-intervention runs (after June 1, 2024).
running_sport_first_fewlaps <- running_sport %>% filter(lap_number <= 3) %>% filter(period == "post_Jun_effort")

#Does this relationship maintain or break down as Tyler gets tired? 
##According to the plot steps per minute gradually increase and as time moves on the steps decrease for lap one - isn't enough data for lap 2 or 3 and distance traveled should also be incorporated when we are considering effort

#Make a plot that shows SPM, speed, and lap number (pick a visualization 
#that you think best shows these three variables).
ggplot(running_sport_first_fewlaps, aes(x=minutes_per_mile , y=steps_per_minute, color = factor(lap_number), group = running_date)) + #use color to distinguish between lap numbers and group by date
  geom_point(size = 3) +
  geom_line(alpha = 0.5) + #trend line for pattern
  labs(title = "Speed by Steps for Post-Intervention Runs Laps 1-3",
       x = "Minutes per Mile",
       y = "Steps per Minute",
       color = "Lap Number") + #labels 
  theme_minimal(base_size = 14) + #keep theme standard simple
theme(legend.position = "bottom", plot.title = element_text(hjust = 0.5)) #put legend at bottom to explain lap numbers







