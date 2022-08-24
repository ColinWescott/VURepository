# Create a list of the packages required
AssignmentPackages <- c(
  'readxl',
  'tidyverse', 
  'viridis',
  'here')
# Install listed packages
install.packages(AssignmentPackages)

# Load packages
library(readxl)
library(tidyverse)
library(viridis)
library(here)

#read in data
maxadductorstrength <- read_excel (here("data", "Dataset1_Assessment1.xlsx"))
physicaloutputGPS <- read_excel (here("data", "Dataset2_Assessment1.xlsx"))

# Assess the structure of imported data
str(maxadductorstrength)
str(physicaloutputGPS)

# Create a tibble 
maxadductorstrength <- as_tibble(maxadductorstrength)
physicaloutputGPS <- as_tibble(physicaloutputGPS)

#Inspect Tibble
maxadductorstrength
physicaloutputGPS


#Select Relevant Data, obtain summary stats for maxadductorstrength by athlete and limb  
maxadductorstrength %>%
  group_by(Name, Limb) %>% 
  summarise(Min = min(Force),
            Max = max(Force),
            Mean = round(mean(Force),0),
            SD = round(sd(Force),0),
            Median = round(median(Force),0))

#Select Relevant Data, obtain summary stats for maxadductorstrength by limb
maxadductorstrength %>%
  group_by(Limb) %>%
summarise(Min = min(Force),
          Max = max(Force),
          Mean = round(mean(Force),0),
          SD = round(sd(Force),0),
          Median = round(median(Force),0))

#Select Relevant Data, obtain summary stats for maxadductorstrength by athlete
maxadductorstrength %>%
  group_by(Name) %>%
  summarise(Min = min(Force),
            Max = max(Force),
            Mean = round(mean(Force),0),
            SD = round(sd(Force),0),
            Median = round(median(Force),0))

#Select Relevant Data, obtain summary stats for physicaloutputGPS 
#by athlete and sessiontype of MeteragePerMinute
physicaloutputGPS %>%
  group_by(Athlete, SessionType) %>%
  summarise(Min = min(MeteragePerMinute),
            Max = max(MeteragePerMinute),
            Mean = round(mean(MeteragePerMinute),0),
            SD = round(sd(MeteragePerMinute),0),
            Median = round(median(MeteragePerMinute),0))

#Select Relevant Data, obtain summary stats for physicaloutputGPS 
#by sessiontype for MeteragePerMinute
physicaloutputGPS %>%
  group_by(SessionType) %>%
  summarise(Min = min(MeteragePerMinute),
            Max = max(MeteragePerMinute),
            Mean = round(mean(MeteragePerMinute),0),
            SD = round(sd(MeteragePerMinute),0),
            Median = round(median(MeteragePerMinute),0))

#Select Relevant Data, obtain summary stats for physicaloutputGPS 
#by athlete and sessiontype for PlayerLoadPerMinute
physicaloutputGPS %>%
  group_by(Athlete, SessionType) %>%
  summarise(Min = min(PlayerLoadPerMinute),
            Max = max(PlayerLoadPerMinute),
            Mean = round(mean(PlayerLoadPerMinute),0),
            SD = round(sd(PlayerLoadPerMinute),0),
            Median = round(median(PlayerLoadPerMinute),0))

#Select Relevant Data, obtain summary stats for physicaloutputGPS 
#by sessiontype for PlayerLoadPerMinute
physicaloutputGPS %>%
  group_by(SessionType) %>%
  summarise(Min = min(PlayerLoadPerMinute),
            Max = max(PlayerLoadPerMinute),
            Mean = round(mean(PlayerLoadPerMinute),0),
            SD = round(sd(PlayerLoadPerMinute),0),
            Median = round(median(PlayerLoadPerMinute),0))

#Select Relevant Data, obtain summary stats for physicaloutputGPS 
#Calculate Percentage of Distance Spent Sprinting
physicaloutputGPS %>%
  group_by(Athlete) %>%
  mutate(SprintPercentage = TotalDistance / SprintDistance) %>%
  select(Athlete, SprintPercentage)
  
#Select Relevant Data, obtain summary stats for physicaloutputGPS 
#Calculate Percentage of Distance Spent Sprinting during Main Training
physicaloutputGPS %>%
  group_by(Athlete) %>%
  mutate(SprintPercentage = TotalDistance / SprintDistance) %>%
  filter(SessionType == "Main Training") %>%
  select(Athlete, SprintPercentage)

#Select Relevant Data, obtain summary stats for physicaloutputGPS 
#Calculate Percentage of Distance Spent Sprinting during Match
physicaloutputGPS %>%
  group_by(Athlete) %>%
  mutate(SprintPercentage = TotalDistance / SprintDistance) %>%
  filter(SessionType == "Match") %>%
  select(Athlete, SprintPercentage)