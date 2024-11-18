library(tidyverse)

#section 1: plot best practices and ggplot review
#ggplot has four parts:
#data/materials ggplot(data=yourdata)
#plot type/design geom_...
#aesthetics/decor aes()
#stats/wiring stat...

#Practie creating a scatter plot of price on carat
ggplot(diamonds, aes(x= carat, y= price)) + geom_point()

#Add transparentcy and color
ggplot(diamonds, aes(x= carat, y=price)) + 
  geom_point(color="blue")#since only using one color this can go into geo_point
#color by variable
ggplot(diamonds, aes(x=carat, y= price, color=clarity))+#if you use a variable to define color that has to go under asethetics 
   geom_point(alpha = 0.2)#and alpha increases transparency so we can see what's going on
#plot best practices:
#remove backgrounds (done through theme_classics), redundant labels, borders,
#reduce folors and special effects
#remove bolding, lighten labels, remove lines, direct label
#remove the background to clean up the plot 
ggplot(diamonds, aes(x= carat, y= price, color=clarity)) + 
  geom_point(alpha = 0.2) + theme_classic()

#keep your visualization simple with a clear message 
#label axes
#start axes at zero

#Now I've added a title and edited the y label to be more 
ggplot(diamonds, aes(x = carat, y= price, color=clarity)) +
  geom_point(alpha = 0.2) + theme_classic() + 
  ggtitle("Price by Diamond Quality") + ylab("price in $") #puts in a graph title and y overwrites the y axis label in aes with a title

#Add a linear regression trendlines for each color 
ggplot(diamonds, aes(x= carat, y= price, color=clarity)) + 
  geom_point(alpha = 0.2) + theme_classic() + 
  ggtitle("Price by Diamond Quality") + ylab("price in $") + 
  stat_smooth(method = "lm")#linear regression model will add lines based upon our points

#Add a LOESS trendcurves for each color
ggplot(diamonds, aes(x= carat, y= price, color=clarity)) + 
  geom_point(alpha = 0.2) + theme_classic() + 
  ggtitle("Price by Diamond Quality") + ylab("price in $") + 
  stat_smooth(method = "loess")#takes a bunch of points and takes an average of all points and shifts over a little to the right and then shifts to the right and takes the average of those points and continues the pattern

