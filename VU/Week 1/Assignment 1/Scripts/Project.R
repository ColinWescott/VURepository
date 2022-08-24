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
maxadductorstrength <- read_excel (here("data", "Dataset1_Assessment1.csv"))
physicaloutputGPS <- read_excel (here("data", "Dataset2_Assessment1.csv"))
