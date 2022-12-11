# =============================================================================== #
# Desc: Initial Setup File and Global Variables for Nearest Neighbour Display App #
# File: global.R                                                                  #
# =============================================================================== #

# -------------- #
# Load libraries #
# -------------- #

# Default to the UK Bristol CRAN mirror
chooseCRANmirror(ind=94)

# Shiny package for app
if (!require(shiny)) {
    install.packages('shiny')
}
library(shiny)

# shinyjs for the shinyjs tools
if (!require(shinyjs)) {
    install.packages('shinyjs')
}
library(shinyjs)

# DT package for the data tables
if (!require(DT)) {
    install.packages('DT')
}
library(DT)

# Tidyverse for data manipulation
if (!require(tidyverse)) {
    install.packages('tidyverse')
}
library(tidyverse)

# Plotly for interactive charts
if (!require(plotly)) {
    install.packages('plotly')
}
library(plotly)

# Leaflet for interactive maps
if (!require(leaflet)) {
  install.packages('leaflet')
}
library(leaflet)

# rgdal for geospatial manipulation
if (!require(rgdal)) {
  install.packages('rgdal')
}
library(rgdal)

# sf for shape file manipulation
if (!require(sf)) {
  install.packages('sf')
}
library(sf)

# Ini for the ini file access
if (!require(ini)) {
    install.packages('ini')
}
library(ini)

# ------------- #
# Load ini file #
# ------------- #
ini_file_sections <- read.ini('display_nearest_neighbour_data_app.ini')

# --------------- #
# Load data files #
# --------------- #
df_practice_data <- read.csv(ini_file_sections$filenames$practice_data)
df_pcn_data <- read.csv(ini_file_sections$filenames$pcn_data)
df_practice_neighbours <- read.csv(ini_file_sections$filenames$practice_neighbours)
df_pcn_neighbours <- read.csv(ini_file_sections$filenames$pcn_neighbours)

# --------------- #
# Load shapefiles #
# --------------- #
sf_subicb <- st_read(
  dsn = ini_file_sections$filenames$subicb_boundaries_dsn, 
  layer = ini_file_sections$filenames$subicb_boundaries_layer) %>%
  st_transform(crs = 4326)
sf_icb <- st_read(
  dsn = ini_file_sections$filenames$icb_boundaries_dsn, 
  layer = ini_file_sections$filenames$icb_boundaries_layer) %>%
  st_transform(crs = 4326)
sf_region <- st_read(
  dsn = ini_file_sections$filenames$region_boundaries_dsn, 
  layer = ini_file_sections$filenames$region_boundaries_layer) %>%
  st_transform(crs = 4326)

# --------------------------------------- #
# Pre-populate the practice and PCN lists #
# --------------------------------------- #

vct_practice <- df_practice_data %>% 
  arrange(PRACTICE_CODE, PRACTICE_NAME) %>% 
  .$PRACTICE_CODE
names(vct_practice) <- df_practice_data %>% 
  arrange(PRACTICE_CODE, PRACTICE_NAME) %>% 
  transmute(label = paste0('[', PRACTICE_CODE, '] - ', PRACTICE_NAME)) %>%
  .$label

vct_pcn <- df_pcn_data %>% 
  arrange(PCN_CODE, PCN_NAME) %>% 
  .$PCN_CODE
names(vct_pcn) <- df_pcn_data %>% 
  arrange(PCN_CODE, PCN_NAME) %>% 
  transmute(label = paste0('[', PCN_CODE, '] - ', PCN_NAME)) %>%
  .$label

vct_region <- df_practice_data %>% 
  arrange(COMM_REGION_CODE, COMM_REGION_NAME) %>% 
  .$COMM_REGION_CODE
names(vct_region) <- df_practice_data %>% 
  arrange(COMM_REGION_CODE, COMM_REGION_NAME) %>% 
  transmute(label = paste0('[', COMM_REGION_CODE, '] - ', COMM_REGION_NAME)) %>%
  .$label

vct_icb <- df_practice_data %>% 
  arrange(ICB_CODE, ICB_NAME) %>% 
  .$ICB_CODE
names(vct_icb) <- df_practice_data %>% 
  arrange(ICB_CODE, ICB_NAME) %>% 
  transmute(label = paste0('[', ICB_CODE, '] - ', ICB_NAME)) %>%
  .$label

vct_subicb <- df_practice_data %>% 
  arrange(SUB_ICB_LOCATION_CODE, SUB_ICB_LOCATION_NAME) %>% 
  .$SUB_ICB_LOCATION_CODE
names(vct_subicb) <- df_practice_data %>% 
  arrange(SUB_ICB_LOCATION_CODE, SUB_ICB_LOCATION_NAME) %>% 
  transmute(label = paste0('[', SUB_ICB_LOCATION_CODE, '] - ', SUB_ICB_LOCATION_NAME)) %>%
  .$label


