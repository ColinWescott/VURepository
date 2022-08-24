#load packages
library(viridis)
library(bookdown)
library(scales)
library(dplyr)
library(readxl)
library(tidyverse)
library(plotly)
library(kableExtra)
library(knitr)
#load dataset
SuperNetball <- read.csv("Data/Dataset3_Assessment3.csv")


#create subset for goals scored per team per game
  Goalspergame <- SuperNetball %>% 
  filter(Statistic == "goals" & Total>"0.0") %>%
   group_by(Team) %>%                         
  summarise_at(vars(Total),              
               list(totalgoals = sum)) %>% 
  mutate(goalspergame = round(totalgoals / 14, 2)) 
  
  
  
#graph most goals per team in a column plot
goalspergamegraph <- ggplot(Goalspergame, aes(x = reorder(Team, -goalspergame), y = goalspergame, fill = Team)) +
  geom_col() +
  scale_colour_viridis_d() +
  theme_light()+
  labs(x = "Team", y = "Total Goals per Game") +
  theme(axis.text.x=element_text(angle = -270, hjust = 0))
#make interactive plot
  ggplotly(goalspergamegraph) 
  

  
#create data set of most goals by player (1 and 2 point)
  GoalsperTeam <- SuperNetball %>% 
    filter(Statistic == "goals" & Total>"0.0")  %>%
    ggplot(aes(x = reorder(Athlete, -Total), y = Total, fill = Team)) +
    geom_col() +
    scale_colour_viridis_d() +
    theme_light() +
    labs(x = "Goal Scorers", y = "Goals Scored") +
    theme(axis.text.x=element_text(angle = -270, hjust = 0)) 

#calculate 1 point shooting %
  SuperNetballShooting1 <- SuperNetball %>% 
  filter(Statistic == "attempts1" | Statistic == "goal1") %>%
    filter(Total > "0") %>% 
  pivot_wider(names_from = Statistic, values_from = Total) %>% 
  mutate(percent = round(goal1 / attempts1 * 100, 0)) 
#plot % on graph
goalpercent <- ggplot(SuperNetballShooting1, mapping =  aes(x = attempts1, y = percent, colour = Athlete)) +
  geom_point() +
  scale_colour_viridis_d() +
  theme_light() +
  labs(x = "1 point atempts", y = "Shooting %")
#interactive plot
ggplotly(goalpercent)
  
  
#calculate 2point shooting %                                 
  SuperNetballShooting2 <- SuperNetball %>% 
  filter(Statistic == "attempts2" | Statistic == "goal2") %>% 
  filter(Total > "0") %>% 
    pivot_wider(names_from = Statistic, values_from = Total) %>% 
    mutate(percent = round(goal2 / attempts2 * 100, 0)) %>% 
  arrange(desc(percent))
  
#create Table showing 2 point %
SuperNetballShooting2 %>%
  kbl(caption = "Recreating booktabs style table", 
      col.names = c("Athlete", "Team", "Attempts", "Goals", "Shooting Percentage")) %>%
  kable_classic 


  

TurnoversandAssists <- SuperNetball %>% 
  filter(Statistic == "goalAssists" | Statistic == "generalPlayTurnovers") %>%
  pivot_wider(names_from = Statistic, values_from = Total) %>% 
  mutate(ratio = round(goalAssists / generalPlayTurnovers, 2)) %>% 
  filter(goalAssists > "0" & generalPlayTurnovers > "0")


  