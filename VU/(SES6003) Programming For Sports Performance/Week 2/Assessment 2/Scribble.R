install.packages("kableExtra")
install.packages("viridis")
install.packages("readxl")
install.packages("tidyverse")
install.packages("lubridate")
library(tidyverse)
library(lubridate)


RawData <- read.csv("Data/Dataset1_Assessment1.csv")

ggplot(data = RawData, aes(x = Force)) +
  geom_density()

#create an overlaid box and whisker plot
ggplot(RawData, aes(x = Measure, y = Force)) +
  geom_jitter(aes(colour = Name)) +
  geom_boxplot(alpha = 0.3) +
  facet_wrap(~Limb)

RawData$Date_Formatted <- as.Date(RawData$Date, tryFormats = c("%d/%m/%y"))
str(RawData)

KaitlinVictoria <- RawData %>% 
  filter(Name == "Kaitlin" | Name == "Victoria")  
ggplot(data = KaitlinVictoria, aes(x = Date2, y = Force, colour = Name)) +
geom_point() +
geom_line() +
scale_colour_viridis_d() +
theme_classic() +
facet_wrap(~Limb)

RawData$Date2 <- as.Date(RawData$Date, tryFormats = c("%d/%m/%Y"))
str(RawData)

ggplot(RawData, aes(x = Date2, y = Force, colour = Name)) +
geom_point() +
scale_colour_viridis_d() +
theme_classic()

knitr::write_bib(c(.packages(), "bookdown"), "packages.bib")

install.packages("knitcitations")

                         
  