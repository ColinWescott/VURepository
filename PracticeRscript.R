#load packages
library(tidyverse)

#create an object
Colin <- 9+8

#inspect mtcars dataset
mtcars

#plot data for mtcars
ggplot(mtcars, aes(x = disp, y = hp))+
geom_point()