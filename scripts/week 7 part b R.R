#There are four types of palettes:
#1. Continuous
#2. Ordinal (plotting categories representing least to most of something)
#3. qualitative (for showing different categories that are non-ordered)
#4. diverging (for plotting a range from negative calues to positive values)

install.packages("RColorBrewer")
#RColorBrewer Shows some good examples of colors to use that are color-blind friendly
library(RColorBrewer)
#This is a list of all of RColorBrewer's colorblind-frienly discrete
display.brewer.all(colorblindFriendly = TRUE)

#Continuous Data
#use scale_fill_viridis_c or scale_color_viridis_c for continuous (color found in ggplot package)
#direction = -1 to reverse the direction of the colorscale
ggplot(diamonds, aes(x= clarity, y=carat, color=price)) + #example of continuous data because the price could have decimals in it
         geom_point(alpha = 0.2) + theme_classic() + 
         scale_color_viridis_c(option = "C", direction = -1)#there are five options C, B, D, E, A and they have different colors and moods to them and direct can be 1 or -1 which changes how dark the color of dots are
         
#pick another viridis color scheme by using a different letter 
ggplot(diamonds, aes(x= clarity, y=carat, color=price)) + 
  geom_point(alpha = 0.2) + theme_classic() + 
  scale_color_viridis_c(option = "E", direction = -1)

#to bin continuous data, use the suffiz "_b" instead
ggplot(diamonds, aes(x= clarity, y=carat, color=price)) + 
  geom_point(alpha = 0.2) + theme_classic() + 
  scale_color_viridis_b(option = "E", direction = -1)#the _b makes the colors discrete per category 

#Ordinal (discrete sequential) just a few possibilities 
#from the viridis palette
#use scale_fill_viridis_d or scale_color_viridis_d for discrete
ggplot(diamonds, aes(x= clarity, y=carat, fill=color)) + #matched the fill with the viridis fill to color the boxes
  geom_boxplot() + theme_classic() + 
  ggtitle("Diamond Quality by Cut") + 
  scale_fill_viridis_d("color")#discrete color in boxplot

#scale_color is for color and scale_fill is for the fill
#aes parameter needs to change from "fill = " to "color =", to match
ggplot(diamonds, aes(x= cut, y= carat, color = color)) + 
  geom_boxplot(alpha = 0.2) + theme_classic() + 
  ggtitle("Diamond Quality by Cut") +
  scale_color_viridis_d("color")#and match color to the color arugment in aes for outline

#here's how it looks on a barplot
ggplot(diamonds, aes(x = clarity, fill = cut)) + 
  geom_bar() + 
  theme(azis.text.x = element_text(angle=70, vjust=0.5)) + 
  scale_fill_viridis_d("cut", option = "B") +
  theme_classic()

#from RColorBrewer:
ggplot(diamonds, aes(x= cut, y= carat, fill = color)) +
  geom_boxplot() + theme_classic() + 
  ggtitle("Diamond Quality by Cut") + 
  scale_fill_brewer(palette = "PuRd")

#how did we know the name of the palette 
display.brewer.all(colorblindFriendly = TRUE)

#From RColorBrewer:
ggplot(iris, aes(x= Sepal.Length, y= Petal.Length, fill = Species)) +
  geom_point(shape=24, color="black", size = 4) + theme_classic() + #shape changes from circle to triangle and changed the border color black also made the size big
  ggtitle("Sepal and Petal Length of Three Iris Species") + 
  scale_fill_brewer(palette = "Set2")

#From the ggthemes package:
#let's also clarify the units
install.packages("ggthemes")
library(ggthemes) 
ggplot(iris, aes(x=Sepal.Length, y=Petal.Length, color = Species)) + 
  geom_point() + theme_classic() + 
  ggtitle("Sepal and Petal Length of Three Iris Species") + 
  scale_color_colorblind("Species") + #qualitatively categorical option
  xlab("Sepal Length in cm") + 
  ylab("Petal Length in cm")

#Manual Palette Design
#this is another version of the same 
#colorblind palette from the ggthemes package but with gray 
#this is an example of how to create a named vector
#of colors and use it as a manual fill
cbPalette <- c("#999999", "#E69F00", "#56B4E9", "#009E73", "#F0E442", "#0072B2", "#D55E00", "#CC79A7")
names(cbPalette) <-levels(iris$Species)#create a named vector to minimize the chances of something strange happening when you are trying to map number of colors to different variables
#we don't need all the colors in the palette because there are only 3 categories'
#we cute the vector length to 3 here
cbPalette <- cbPalette[1:length(levels(iris$Species))]#only three levels are named because we only have three species so not all colors are used this command also cuts the vector length down to three

ggplot(iris, aes(x= Sepal.Length, y= Petal.Length, color = Species)) + 
  geom_point() + theme_classic() +
  ggtitle("Sepal and Petal Length of Three Iris Species") + 
  scale_color_manual(values = cbPalette) + 
  xlab("Sepal Length in cm")#relabeled the x and y axis with the measurements
  ylab("Petal Length in cm")#shows three different species and three different colors we had created 
  
  #Diverging Discrete 
  #from RColorBrewer
  myiris <- iris %>% group_by(Species) %>% mutate(size = case_when(
    Sepal.Length > 1.1* mean(Sepal.Length) ~ "very large", 
    Sepal.Length < 0.9 * mean(Sepal.Length) ~ "very small",
    Sepal.Length < 0.94 * mean(Sepal.Length) ~ "small",
    Sepal.Length > 1.06 * mean(Sepal.Length) ~ "large", 
    T ~ "average"))# create a variable that captures which size diveraging from average
  
  #set the levels not in alphabetical order but in order of size
  myiris$size <- factor(myiris$size, levels = c("very small", "small", "average", "large", "very large"))
  
  ggplot(myiris, aes(x= Petal.Width, y= Petal.Length, color = size)) + 
    geom_point(size = 2) + theme_gray() + ggtitle("Diamond Quality by Cut") + 
    scale_color_brewer(palette = "RdYlBu")