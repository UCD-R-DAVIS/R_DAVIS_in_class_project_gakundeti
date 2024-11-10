library(tidyverse)
install.packages("ggplot2") #visual packge install
library(ggplot2) #call visual package

surveys_complete <- read_csv("data/portal_data_joined.csv")
  filter(complete.cases(.))#removing all cases of NAs throughout dataset 

#Syntax for ggplot
##ggplot(data = <DATA>, mapping = aes(<MAPPING>)) + <GEOM_FUNCTION>()
#two main arguments one is what your data actually is 
#and mapping use aes which stands for asthetics 
#and your telling R where you'd want it to get the 
#data from for your dataframe. In ggplot instead of 
#pipe the plus sign is used and then some sort 
#of geometric function is used which will add 
#graphical representation of your plot 

#Run on own just an empty white space comes up because R knows there data but you haven't told it what or how  to plot so its blank
ggplot(data = surveys_complete)

#aes (asethetics) goes into the dataframe and 
#pulls out any matching column frames you specifiy 
#in here which is still blank 
ggplot(data = surveys_complete, mapping = aes(x= weight, y= hindfoot_length))

#We need to add a geom_function to tell it how to plot
ggplot(data = surveys_complete, mapping = aes(x= weight, y= hindfoot_length)) + 
  geom_point()

#Add more plot elements - add transparency and points are a little blurred 
ggplot(data = surveys_complete, mapping = aes(x= weight, y= hindfoot_length)) + 
  geom_point(alpha = 0.1)

#Add color to points
ggplot(data = surveys_complete, mapping = aes(x= weight, y= hindfoot_length)) + 
  geom_point(color = "blue")

#Add color by group in order to color by group you
#need to use the aes to reference data within your
#dataframe. Geom_smooth allows you to add a line to 
#the plot to see the trend. We can see there is a line added 
#to the plot in blue but there is only one not one per 
#genus and its because we set the color by
#genus just in geom point we didn't tell 
#R to do it for each genus, we need to write an aes in the 
#geom function for smooth to specify per genus
ggplot(data = surveys_complete, mapping = aes(x= weight, y= hindfoot_length)) + 
  geom_point(aes(color = genus)) + 
  geom_smooth(aes(color = genus))

#universal plot setting calling mulitple aesthetics 
#by specifiying at top rather than bottom   
ggplot(data = surveys_complete, mapping = aes(x= weight, y= hindfoot_length, color = genus)) + 
  geom_point() + 
  geom_smooth()

#boxplot and categorical and continuous data
ggplot(data = surveys_complete, mapping = aes(x = species_id, y = weight)) + 
  geom_boxplot(color = "orange")

#fill in orange instead and you can use jitter to plot points to show same 
#value ontop of others to give a sense of how many points have same value 
#it spreads out how points are put on the plot
ggplot(data = surveys_complete, mapping = aes(x = species_id, y = weight)) + 
  geom_boxplot(fill = "orange") + 
  geom_jitter(color = "black", alpha = 0.1)

#change order of how you construct your plot 
ggplot(data = surveys_complete, mapping = aes(x = species_id, y = weight)) + 
  geom_jitter(color = "black", alpha = 0.1)+ 
  geom_boxplot(fill = "orange", alpha = 0.5)


