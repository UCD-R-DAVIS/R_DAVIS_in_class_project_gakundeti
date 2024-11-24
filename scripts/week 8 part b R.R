#Creating Functions
#Defining a Function 
#creating a custom prewritten code to get around the copy and paste mode which can cause typos
#ggplot is a function 
#in function specify arguments as input and value as output 
#function adds two values 
my_sum <- function(a, b){
  the_sum<- a + b
  return(the_sum)
}
my_sum
#here we specify what these values are
my_sum(a=2, b=2)

#if we want to save we need to give an object name
sum<- my_sum(a=2, b=2) 

#provide default values
my_sum2 <- function(a =1, b = 2){
  the_sum<- a + b
  return(the_sum)
}
#automatically gives return value of three since specified in function
my_sum2()

#if you wanted to change a value you can 
my_sum2(b=3)

#Writing your own function from scratch
#temperature conversion example: farenheit to kelvin
((50-32)*(5/9)) + 273.15
((62-32)*(5/9)) + 273.15
((72-32)*(5/9)) + 273.15

#how to write function: 
#1. Identify what piece(s) will change within your commands -- this is your
#argument
#2. Remove it and replace with object(s) name(s)
#3. Place code and argument into the function() function
#first we need to save the function to call it
#inside of any custome function you are writing it knows to return a value
#best practices are specifying the function like done above
f_to_k <- function(tempF){
((tempF - 32)*(5/9))+273.15
}
#call the function by placing a value equal to the variable specified above
f_to_k(tempF = 72) 

#best practices are specifying the function like done above
f_to_k <- function(tempF){ k<-
  ((tempF - 32) * (5/9)) + 273.15}
#no value gets returned  
f_to_k(tempF = 72)

#best practices are specifying the function like done above
f_to_k <- function(tempF){ k<-
  ((tempF - 32) * (5/9)) + 273.15 
return(k)
}
#the return K above has the value print to the console  
f_to_k(tempF = 72)

#what happens in the function stays in the function it will not be saved in the output
#if you want to save the value you have to do the following
farenheit<- f_to_k(tempF = 72)

#calculate average GDP in a given country, in a given span of years, using gapminder data
library(tidyverse)
gapminder<- read_csv("https://ucd-r-davis.github.io/R-DAVIS/data/gapminder.csv")

#writing a specific line of code to calculate average 
gapminder %>%
  filter(country == "Canada", year %in% c(1950:1970)) %>%
  summarize(meanGDP = mean(gdpPercap, na.rm = TRUE))

#generalize the code 
#specific country and range of years
avgGDP <- function(cntry,yr.range){ 
#we save the value in a object and save value so it can be call
df<-gapminder %>%
  filter(country == cntry, year %in% c(yr.range)) %>%
  summarize(meanGDP = mean(gdpPercap, na.rm = TRUE))
return(df)
}
#call the value
avgGDP("United States", 1980:1985)
