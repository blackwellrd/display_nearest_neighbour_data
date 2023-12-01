# =============================================================================== #
# Desc: Initial Setup File and Global Variables for Nearest Neighbour Display App #
# File: global.R                                                                  #
# =============================================================================== #

# -------------- #
# Load libraries #
# -------------- #

# Classes and Methods for Spatial Data 
library(sp)

# Shiny package for app
library(shiny)

# shinyjs for the shinyjs tools
library(shinyjs)

# DT package for the data tables
library(DT)

# Tidyverse for data manipulation
library(tidyverse)

# Plotly for interactive charts
library(plotly)

# Leaflet for interactive maps
library(leaflet)

# rgdal for geospatial manipulation
library(rgdal)

# sf for shape file manipulation
library(sf)

# Ini for the ini file access
library(ini)

# Htmltools for the htmltools file access
library(htmltools)

# ------------- #
# Load ini file #
# ------------- #
ini_file_sections <- read.ini('display_nearest_neighbour_data_app.ini')

# ---------------------------- #
# Get the field names required #
# ---------------------------- #
organisation_variables <- names(ini_file_sections$organisation_data)
numeric_variables <- character(0)
for(section in names(ini_file_sections$comparison_data_sections)){
  numeric_variables <- c(numeric_variables, names(ini_file_sections[[section]]))
}

# --------------- #
# Load data files #
# --------------- #
df_practice_data <- read.csv(ini_file_sections$filenames$practice_data) %>% select(organisation_variables, numeric_variables)
df_pcn_data <- read.csv(ini_file_sections$filenames$pcn_data) %>% select(organisation_variables, numeric_variables)
df_practice_neighbours <- read.csv(ini_file_sections$filenames$practice_neighbours)
df_pcn_neighbours <- read.csv(ini_file_sections$filenames$pcn_neighbours)

# Ensure only valid practice and PCNs are present in the data frames (i.e. ones with a geographical point)
df_practice_data <- df_practice_data %>% filter(!is.na(LATITUDE))
df_pcn_data <- df_pcn_data %>% filter(!is.na(LATITUDE))

# --------------- #
# Load shapefiles #
# --------------- #
sf_icb <- st_read(
  dsn = ini_file_sections$filenames$icb_boundaries_dsn, 
  layer = ini_file_sections$filenames$icb_boundaries_layer) %>%
  st_transform(crs = 4326)

vct_data_sections <- names(unlist(ini_file_sections$comparison_data_sections))
names(vct_data_sections) <- unname(unlist(ini_file_sections$comparison_data_sections))

