install.packages("lattice")
library(ggplot2)
library(tidyverse)
library(kableExtra)
library(sp)
ScoutData <- AT3_Dataset3

maxvelocity <- AT3_Dataset3 %>% 
  group_by(Name) %>% 
 mutate(max = max(Velocity, na.rm=TRUE))

ggplot(AT3_Dataset3, aes(x = Time, y = Velocity, colour = StoppageType)) +
  geom_line() +
  labs(x = "time (s)", y = "velocity (km/hr)")+
  facet_wrap(~Name)

MeanVelocityperquarter <- AT3_Dataset3 %>% 
group_by(Quarter) %>% 
  summarise(Mean = mean(Velocity),
            SD = sd(Velocity))

Accelerationperplayer <- AT3_Dataset3 %>% 
  group_by(Name) %>% 
  summarise(Mean = mean(Acceleration),
            Max = max(Acceleration),
            SD = sd(Acceleration))

ggplot(Accelerationperplayer, aes(x=Name, y=Mean)) +
  geom_point() +
geom_errorbar(aes(ymin = Mean-SD, ymax = Mean+SD))+
  geom_point(aes(x=Name, y= Max, colour= Name))
scale_colour_viridis_d() +
  theme_light()
  labs(y = "Acceleration (ms−2)")
  
(ymin=Mean-sd, ymax=Mean+sd)
ggplot(MeanVelocityperquarter, aes(x = as.factor(Quarter), y = Mean)) +
  geom_col() +
  labs(x = "Quarter", y = "Mean Velocity")

MeanVelocityperquarter %>%
  kbl() %>%
  kable_classic

ggplot(AT3_Dataset3, aes(x = Longitude, y = Latitude, colour = Name)) +
 geom_point()


summarystats <- AT3_Dataset3 %>% 
  summarise(Man)

GPStibble <- as_tibble(AT3_Dataset3)
GPStibble
  
maxvelocity <- AT3_Dataset3 %>% 
  group_by(Name) %>% 
  summarise(max = max(Velocity, na.rm=TRUE)) 


GPSmap2 <- GPSmap
mapdata.SP <- SpatialPointsDataFrame(AT3_Dataset3[,c(2,3)],AT3_Dataset3[,-c(2,3)])

m <- leaflet() %>%
  addTiles() %>% 
  addCircleMarkers(data =AT3_Dataset3, lng = ~Longitude, lat = ~Latitude, radius = 2, colour = 
 # Print the map
m

Summarystats <- AT3_Dataset3 %>% 
  summarise(across(c(Velocity, Acceleration), list(mean=mean, sd=sd)))
  
