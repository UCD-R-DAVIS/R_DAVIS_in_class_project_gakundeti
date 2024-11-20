library(tidyverse)
library(ggplot2)
install.packages("forcats")
library(forcats)
gapminder <- read_csv("https://ucd-r-davis.github.io/R-DAVIS/data/gapminder.csv") 

#viewing all years present in dataset
table(gapminder$year)

#Q1 To get populations per country between 2002 and 2007 and calculate the difference
country_0207 <- gapminder %>% 
  select(country, year, pop, continent) %>% #selecting the variables needed to reporduce the graph
  filter(year>=2002) %>% #restrict the years to 2002 for between 2002 and 2007
  pivot_wider(names_from = year, values_from = pop) %>% #moves the years as values in the year variable to each being a seperate column
  mutate(pop_diff_0207 = `2007` - `2002`)#creates a new column that represents the difference between population years 
  
#Q2 - Q7 creates four bar plots by continent 
country_0207 %>%
  filter(continent != "Oceania")%>% #Remove Oceania to match picture
  ggplot(aes(x = reorder(country, pop_diff_0207), y = pop_diff_0207, fill = continent)) + #reorder allows population difference to increase across the graph and applies different color to each continent
  geom_bar(stat="identity") + #creates a bar plot with blue lines and white filled bars
  facet_wrap(~continent, scales="free") + #Allows multiple graphs to be created by continent and for the axis to be flexible
  theme_bw() + theme( axis.text.x = element_text(angle = 45, hjust = 1), #angles the x axis country names
                      strip.background  = element_blank(),
                      panel.grid.major = element_line(colour = "grey80"), 
                      panel.border = element_blank(),
                      axis.ticks = element_line(size = 0),
                      panel.grid.minor.y = element_blank(),
                      panel.grid.major.y = element_blank() ) + #removes the major axis lines and adds vertical gray lines

  theme(legend.position="none") + #removes the legend
  scale_fill_brewer(palette="Set2") +  #adds the color theme which is different colors per continent
  xlab("Country") + #label for the x axis
  ylab("Change in Population Between 2002 and 2007") #lable for the y axis


