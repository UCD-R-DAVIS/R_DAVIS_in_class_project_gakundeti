#three time classes
#Dates
#posixct (calendar time)
#posixct (local time) 

sample_dates_1 <- c("2018-02-01", "2018-03-21", "2018-10-05", "2019-01-01", "2019-02-18")
#As far as R knows it sees this as character strings 
class(sample_dates_1)

#We need to convert into a time object 
#The string must be of the form 
#YYYY-MM-DD
#To convert it into a Date object 
sample_dates_1 <- as.Date(sample_dates_1)
#R now sees this as a date
class(sample_dates_1)

#in previous example we had a proper format for date 
#what happens when we don't have a proper sample date setup
sample_dates_2 <- c("02-01-2018", "03-21-2018", "10-05-2018", "01-01-2019", "02-18-2019")

sample_dates_3 <-as.Date(sample_dates_2)

sample_dates_3 # this doesn't work and R thinks the year for the first date is 0002

#to fix this error, you need to specify the format
#specifying the format with % means that this is a symbol you want parsed and to look for the date in this format
sample_dates_3<- as.Date(sample_dates_2, format = "%m-%d-%Y")
sample_dates_3

#here is a complete list of times
?strptime

#challenge: Jul is abreviation for the month name and assoicate with %b and comma to tell it to look for acomma before the year 
tm1<- as.Date("Jul 04, 2019", format= "%b%d,%Y")
tm1

#when working with times, POSIXct is the best class to work with
#It defaults to specific date time because its the summer and it knows my timezone
tm1 <- as.POSIXct("2016-07-24 23:55:26")
tm1

#poor string then use a format its quished together because there are no commas but there is a colon
tm2<- as.POSIXct("25072016 08:32:07", format = "%d%m%Y %H:%M:%S")
tm2

#posixct assumes you collected your data in the 
#timezone your computer is set to
#To change this, set the timezone parameter
#here's an example that sets the timezone to "GMT"
tm3 <- as.POSIXct("2010-12-01 11:42:03", tz = "GMT")
tm3

#the tidyverse way:
library(lubridate)

sample_dates_1 <- c("2018-02-01", "2019-03-21", "2018-10-05", "2019-01-01", "2019-02-18")

#we use ymd since our data is y-m-d - ymd function telling it to look for that order
sample_dates_lub <-ymd(sample_dates_1)

sample_dates_lub

#notice that not all of the expected number of 
#digist are always used. Lubridate don't care
sample_dates_1 <-c("2-01-2018", "3-21-2018", "10-05-18", "01-01-2019", "02-18-2019")
sample_dates_lub <- ymd(sample_dates_1)

sample_dates_lub

#more examples using lubridate
#notice we do not need to specify symbols like commas
lubridate::ymd("2016/01/01")# --> 2016-01-01
lubridate::ymd("2011-03-19")# --> 2011-03-19
lubridate::mdy("feb 19, 2011")# -->  2011-02-19
lubridate::dmy("22051997")# --> 1997-05-22

#Timezones:
#hms means hours, minutes seconds
#add "_hms" or "_hm"
#it's a good idea to combine your date and 
#time into a single columne, since 
#it represents different sized increments
#of a single time variable

#defaults to  12 pm since you haven't specified
lubridate::ymd_hm("2016-01-01 12:00", tz="America/Los_Angeles")#-->2016-01-01 12:00
#24 hour time:

lubridate::ymd_hm("2016/04/05 14:47", tz="America/Los_Angeles")#-->2016-04-05 14:47:00

#converts 12 hour time into 24 hour time:
latime<- lubridate::ymd_hms("2016/04/05 4:47:21 PM", tz="America/Los_Angeles")
latime

#how to change time zones
with_tz(latime, tzone = "GMT")
with_tz(latime, tzone = "Pacific/Honolulu")

#make sure your data starts as 
#character strings, not as dates and times, 
#before converting to lubridate because that minimizes number of errors
#read_csv will see dates and 
#times and guess that you want them as 
#Date and time objects, so you have to 
#explicitly tell it not to do this 

library(dplyr)
library(readr)

#read in some data and skip header lines 
mloa1 <-mloa <- read_csv("https://raw.githubusercontent.com/gge-ucd/R-DAVIS/master/data/mauna_loa_met_2001_minute.csv")

head(mloa1) #R tried to guess for you that the year, month, day, and hour columns were numbers

#import row dataset & specify column types where c=character and d=double
mloa2 <-mloa <- read_csv("https://raw.githubusercontent.com/gge-ucd/R-DAVIS/master/data/mauna_loa_met_2001_minute.csv", col_types = "cccccccddddddddd")

#notice the difference in the data types of these two objects:
#the difference is it automatically chose a double and in the second example it chose a character

glimpse(mloa1)
glimpse(mloa2)

#now we are ready to make a datetime col 
#so that we can use lubridate on it: 
mloa2$datetime<- paste(mloa2$year, "-", mloa2$month, "-", mloa2$day, ", ", mloa2$hour24, ":", mloa2$min, sep = "")
head(mloa2$datetime)

#since we used "paste," our new column is a character string type
#created the new datetime column and since we used paste it is a character string
glimpse(mloa2)

#3 options for how to progress from here: 
#convert Date Time to POSIXct in local timezone using lubridate

#Warning!!
#this method as_datetime does not work 
#in this dataset unless you specify
#format, because otherwise it tries to look for 
#seconds but we don't have data for seconds, 
#and there are an inconsistent number of 
#digits for each portion of the datetime
#(eg month could be "2" or "12")
#running like this and over 85,000 records failed
mloa2$datetime_test<- as_datetime(mloa2$datetime)

#Only 60 failed 
#note: American/Los_Angeles is not actually
#the time zone that this data is from,
#which is evident because when telling
#lubridate to assume the data is from 
#America/Los_Angeles, the 60 datapoints
#during the switch to dalylight savings
#are pased as "NA" because that hour didn't actually exist
mloa2$datetime_test<- as_datetime(mloa2$datetime, tz= "America/Los_Angeles", format = "%Y-%m-%d, %H:%M")


#no warning 
mloa2$datetime_test<- as_datetime(mloa2$datetime, tz= "Pacific/Honolulu", format = "%Y-%m-%d, %H:%M")

#this reads mloa time for year 2020 understand date and it made up seconds it assumed an incorrect format
head(mloa2$datetime_test)

#with formatting it understands the year is 2001
head(mloa2$datetime)

#instead, convrt using the ymd_functions
#this method works!
mloa1$datetime<- ymd_hm(as.character(mloa2$datetime), tz = "Pacific/Honolulu")

#This tells what timezone you are in
tz(mloa$datetime)

#how do we extract different components from a lubridate object?
#Functions called day(), month(), year(), 
#extract those elements of a datetime column
months<- month(mloa2$datetime)

#use the table function to get a quick
#summary of categorial variables
table(months)

#Add label and abbr arguments to convert
#numeric representations to have names
months <- month(mloa2$datetime, label = TRUE, abbr=TRUE)
table(months)

#how to check for daylight savings time 
dst(mloa2$datetime_test[1])

#bullon vector with entire dataset
dst(mloa2$datetime)

latime<- libridate::ymd_hms("2016/04/05 4:47:21 PM", tz = "America/Los_Angeles")

latime
#tells us that this was on daylight savings time
dst(latime)
#converts timezone
gm<- with_tz(latime, tzone = "GMT")
#not on grenich meantime
dst(gm)
hi<- with_tz(latime, tzone = "Pacific/Honolulu")
#not on daylight savings time
dst(hi)#--> 2016-04-05:16:47:21


