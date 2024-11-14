library(tidyverse)
#This data set is looking at statistics for a few different counties including population, GDP per capita, and life expectancy
gapminder <- read_csv("https://ucd-r-davis.github.io/R-DAVIS/data/gapminder.csv") 


#Question 1  
gapminder %>% 
  group_by(continent, year) %>% #group by continent and year to get a trend per each continent
  summarize(mean_lifeExp = mean(lifeExp)) %>% #calculates mean life expectancy for each group
  ggplot()+
  geom_point(aes(x = year, y = mean_lifeExp, color = continent))+ #creat point values for x year and y mean-life expectancy
  geom_line(aes(x = year, y = mean_lifeExp, color = continent))   #create a trend line for the x.y by continent



#Question 2
ggplot(gapminder, aes(x = gdpPercap, y = lifeExp)) + #gdppercap Vs life expectancy 
  geom_point(aes(color = continent, size = pop)) + #size the points in proportion to the population of the country
  scale_x_log10() + #transforms the x-axis into logged values
  geom_smooth(method = 'lm', color = 'yellow', linetype = 'solid') +# this layer controls what the line looks like lm draws a straight line, color makes line yellow, and linetype solid makes it an uninterupted line and and a gray line for confidence intervals
  labs(x = "gdpPercap",
       y = "lifeExp",
       color = "Legend") +#adds a legend for both the x and y ranges
  theme_bw()


#Question 3
countries <- c("Brazil", "China", "El Salvador", "Niger", "United States") #create a list of the countries we interested in 

gapminder %>% 
  filter(country %in% countries) %>% #need to filter the data to reflect the list above
  ggplot(aes(x = country, y = lifeExp))+ #plot is life expectancy by country
  geom_boxplot() + #create a boxplot
  geom_jitter(alpha = 0.5, color = "black")+#add data points using geom_jitter which allows for us to specify the amount of random variation between points
  theme_dark() + #Makes the background dark
  ggtitle("Life Expectancy of Five Countries") + #Adds a title to top of boxplot
  theme(plot.title = element_text(hjust = 0.5)) + #centered the plot title
  xlab("Country") + ylab("Life Expectancy") #Adds access names 

