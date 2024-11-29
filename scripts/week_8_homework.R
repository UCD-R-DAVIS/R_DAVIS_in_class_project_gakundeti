install.packages("khroma")
library(khroma)
library(tidyverse)
library(lubridate)

#Use the README file associated with the Mauna Loa dataset 
mloa <- read_csv("https://raw.githubusercontent.com/gge-ucd/R-DAVIS/master/data/mauna_loa_met_2001_minute.csv")

#to determine in what time zone the data are reported
tz(mloa)#UTC

#how missing values are reported in each column. With the mloa dataframe
missing_function <- rlang::as_function(~ any(is.na(.))) #create a function that ids missing
mloa_missing <- mloa %>% 
  arrange_if(missing_function, funs(desc(is.na(.))))#using missing function arrange missing values at top of dataset
summary(mloa)#large negative values seen
which(is.na(mloa))#no missing values

 
mloa_pt2 = mloa %>% #so as not to overwrite file pulled in
  filter(windSpeed_m_s > 0 & temp_C_2m > 0 & rel_humid > 0) %>%#remove observations with missing values in rel_humid, temp_C_2m, and windSpeed_m_s.
  mutate(datetime = ymd_hm(paste0(year,"-", 
                                month, "-", 
                                day," ", 
                                hour24, ":", 
                                min), 
                         tz = "UTC")) %>% #generate datetime column using year, month, day, hour24, and min columns. 
  mutate(datetimeLocal = with_tz(datetime, tz = "Pacific/Honolulu"))#Creates column called “datetimeLocal” that converts the datetime column to Pacific/Honolulu time


mloa_pt2 %>% mutate(datetime_localMON = month(datetimeLocal, label = TRUE), #extract month and hour from datetimelocal as step one in getting the average
                    datetime_locHR = hour(datetimeLocal)) %>%
  group_by(datetime_localMON,datetime_locHR) %>% #group mean by month and hour as step 2
  summarize(mean_mon_hr_temp = mean(temp_C_2m)) %>% #create the mean from temp_C_2m
  ggplot(aes(x=datetime_localMON, y=mean_mon_hr_temp)) + geom_point(aes(col = datetime_locHR)) + #datetime x value is for month and y was the mean average temp per hour with dot color based upon datetime hour
  xlab("Month") + #x axis lable
  ylab("Mean temperature in Celcius") + scale_color_roma()#y axis label
 



