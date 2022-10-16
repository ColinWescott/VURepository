#load packagesfor analysis
library(tidyverse)

#Import raw netball data
RawTraceData <- read.csv("RawNetballTraceData.csv")

#inspect data closer
unique(RawTraceData$Athlete)
unique(RawTraceData$Position)

#inspect data structure
str(RawTraceData)

#calculate total distance
SummaryStatistics <- RawTraceData %>% 
  group_by(Athlete, Position, Team) %>% 
  na.omit() %>% 
  summarise(TotalDistance = round(sum(Distance), 1)) %>% 
  pivot_wider(names_from = Team, values_from = TotalDistance) %>% 
  arrange(Position)

#Import netball court
NetballCourt <- read.csv("NetballCourt.csv")

#Plot netball court
ggplot(NetballCourt, aes(X,Y),colour = "black") +
  geom_path() +
  coord_equal() +
  theme_minimal() +
  theme(axis.text = element_blank(),
        axis.title = element_blank(),
        panel.grid = element_blank())

#Import netball passing data
PassingData <- read_csv("NetballPassingData.csv")

#plot one athlete's data
RawTraceData %>% 
  filter(Athlete == "Breanna Reese") %>% 
  ggplot(aes(X , Y, colour = Velocity)) +
  geom_point() +
  geom_path(data = NetballCourt, aes(X , Y), colour = "black", size = 1)

#plot density plot
RawTraceData %>% 
  filter(Athlete == "Madelyn Schreibvogel") %>% 
  ggplot(aes(X, Y)) +
  geom_point() +
  geom_density_2d_filled() +
  geom_path(data = NetballCourt, aes(X , Y), colour = "black", size = 1)

#call out passing data
ReceiverDataGA <- PassingData %>% 
  filter(Athlete_Receiver == "Madelyn Schreibvogel")

#plot density plot - overlayed with skill data
RawTraceData %>% 
  filter(Athlete == "Madelyn Schreibvogel") %>% 
  ggplot(aes(X, Y)) +
  geom_point() +
  geom_density_2d_filled() +
  geom_path(data = NetballCourt, aes(X , Y), colour = "black", size = 1) +
  coord_equal() +
  geom_point(data = ReceiverDataGA, aes(PassTo_X, PassTo_Y), colour = "white", size = 6) +
  theme(legend.position = "none")

#plot density plot - overlayed with skill data (colour dependent on goal)
RawTraceData %>% 
  filter(Athlete == "Madelyn Schreibvogel") %>% 
  ggplot(aes(X, Y)) +
  geom_point() +
  geom_density_2d_filled() +
  geom_path(data = NetballCourt, aes(X , Y), colour = "black", size = 1) +
  coord_equal() +
  geom_point(data = ReceiverDataGA, aes(PassTo_X, PassTo_Y, colour = Score), size = 6) +
  guides(fill = "none") +
  theme(legend.position = "bottom")

#install and load ggraph package
install.packages("ggraph")
install.packages("tidygraph")
library(ggraph)
library(tidygraph)

#summary data of passing transactions
PasssingTransactions <- PassingData %>% 
  select(Athlete_Passer, Athlete_Receiver) %>% 
  group_by(Athlete_Passer, Athlete_Receiver) %>% 
  summarise(Count = n()) %>% 
  arrange(desc(Count))

#rename columns
colnames(PasssingTransactions) <- c("From", "To", "Total")

#make graph
graph <- as_tbl_graph(PasssingTransactions)

#create ggraph using tidygraph syntax
ggraph(graph, layout = 'linear', circular = TRUE) +
  geom_egde_arc(aes(alpha = Total),
                show.legend = F,
                arraow = arrow(length = unit(4, 'mm')),
                end_cap = circle(12, 'mm'))






