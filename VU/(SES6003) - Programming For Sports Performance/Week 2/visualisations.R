#install packages for visualisations
install.packages("tidyverse")
install.packages("plotly")

#load packaes into Rstudio
library(tidyverse)
library(plotly)

#load example dataset
RawDataset1 <- read.csv("Data/ExampleData.csv")

#Plot densities
ggplot(data = RawDataset1, aes(x = SkilledInvolvements, color = Limb, fill = Limb)) +
  geom_density(alpha = 0.4)

#run summary stats for dataset
SummaryDataset1 <- RawDataset1 %>% 
  group_by(Limb) %>% 
  summarise(Mean = mean(SkilledInvolvements) ,
             SD = sd(SkilledInvolvements))

#Create Bar Plot
ggplot(SummaryDataset1, aes(x = Limb, y = Mean)) +
 geom_col() +
  theme_classic()
