#Section 3: Non-visual representations 

mybarplot <- ggplot(diamonds, aes(x= clarity)) + 
  geom_bar() + 
  theme(axis.text.x = element_text(angle=70, vjust = 0.5)) +
  theme_classic() + ggtitle("Number of Diamonds by Clarity")
mybarplot

#Braille package allows for the barplots to be described 
install.packages("BrailleR")
library(BrailleR)

#places in the log text that can be read alloud
VI(mybarplot)

#Plays a lower pitch for things at bottom of graph
install.packages("sonify")
library(sonify)
plot(iris$Petal.Width)
sonify(iris$Petal.Width)

detach("package:BrailleR", unload=TRUE)

#Section 4: Publishing Plots and Saving Figures & Plots 
install.packages("cowplot")
library(cowplot)
library(tidyverse)
#you can print multiple plots together, 
#which is helpful for publications
#make a few plots:
plot.diamonds<- ggplot(diamonds, aes(clarity, fill = cut)) + 
  geom_bar() + 
  theme(axis.text.x = element_text(angle=7, vjust=0.5))
#plot.diamonds

plot.cars <- ggplot(mpg, aes(x=cty, y=hwy, colour = factor(cyl))) +
  geom_point(size = 2.5)
#plot.cars

plot.iris <- ggplot(data=iris, aes(x=Sepal.Length, y=Petal.Length, fill=Species)) + 
  geom_point(size = 3, alpha=0.7, shape=21)
#plot.iris

#use plot_grid to link all plots and we tell the cols and rows
panel_plot <- plot_grid(plot.cars, plot.iris, plot.diamonds, 
                        labels=c("A", "B", "C"), ncol=2, nrow = 2)

panel_plot

#You can fix the sizes for more control over the result 
fixed_gridplot<- ggdraw() + draw_plot(plot.iris, x = 0, y= 0, width = 1, height = 0.5) + 
  draw_plot(plot.cars, x=0, y=0.5, width=0.5, height = 0.5) + 
  draw_plot(plot.diamonds, x=0.5, y=0.5, width=0.5, height = 0.5) + 
  draw_plot_label(label = c("A", "B", "C"),x = c(0,0.5, 0), y=c(1,1,0.5))

fixed_gridplot

#saving figures
ggsave("figures/gridplot.png", fixed_gridplot)
#you can save images as .png, .jpeg, .tiff, .pdf, .bmp, or .svg

#for publications, use dpi of at least 700
ggsave("figures/gridplot.png", fixed_gridplot, 
       width = 6, height = 4, units = "in", dpi = 700)

#interactive web applications
library(plotly)

plot.iris <- ggplot(data=iris, aes(x=Sepal.Length, y=Petal.Length, fill=Species )) +
  geom_point(size=3, alpha=0.7, shape=21)
plotly::ggplotly(plot.iris)

