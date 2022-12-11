# ======================== #
# Desc: Map User Interface #
# File: tabMapUI.R         #
# ======================== #

tabPanel(
  title = 'Map',
  value = 'tab01',
  sidebarLayout(
    sidebarPanel(
      tags$h3('Selected Organisation'),
      tags$hr(),
      radioButtons(inputId = 'tab01_selLevel', label = 'Level', choices = c('Practice','PCN'), selected = 'Practice'),
      selectInput(inputId = 'tab01_selOrg', label = 'Organisation', choices = c('', vct_practice), selected = NULL),
      tags$hr(),
      tags$h3('Filters'),
      selectInput(inputId = 'tab01_selRegion', label = 'Region', choices = c('', vct_region), selected = NULL),
      selectInput(inputId = 'tab01_selICB', label = 'ICB', choices = c('', vct_icb), selected = NULL),
      selectInput(inputId = 'tab01_selSubICB', label = 'Sub-ICB Location', choices = c('', vct_subicb), selected = NULL),
      width = 2),
    mainPanel(
      tags$h3('Map'),
      tags$style(type = "text/css", "#tab01_map {height: calc(100vh - 80px) !important;}"),
      leafletOutput('tab01_map'),
      tags$hr(),
      width = 10)
  )
)