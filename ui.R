# =========================================================== #
# Desc: User Interface File for Nearest Neighbour Display App #
# File: ui.R                                                  #
# =========================================================== #
ui <- fluidPage(
#  theme = shinytheme('paper'),
  shinyjs::useShinyjs(),
  withMathJax(),
  titlePanel('Nearest Neighbour'),
  sidebarLayout(
    sidebarPanel(
      tags$h3('Selected Organisation'),
      radioButtons(inputId = 'selLevel', label = 'Level', choices = c('Practice','PCN'), selected = 'Practice'),
      selectInput(
        inputId = 'selRegion', 
        label = 'Region', 
        choices = df_practice_data %>% 
                    distinct(NHSER_CODE, NHSER_NAME) %>% 
                    transmute(
                      name = paste0('[', NHSER_CODE, '] - ', NHSER_NAME),
                      code = NHSER_CODE
                    ) %>%
                    arrange(name) %>%
                    deframe()
      ),
      selectInput(inputId = 'selICB', label = 'ICB', choices = c(''), selected = NULL),
      selectInput(inputId = 'selOrg', label = 'Organisation', choices = c(''), selected = NULL),
      tags$hr(),
      selectInput(inputId = 'selVarGroup', label = 'Data Section', choices = vct_data_sections, selected = NULL),
      selectInput(inputId = 'selVar', label = 'Variable', choices = c(''), selected = NULL),
      width = 2),
    mainPanel(
      tabsetPanel(
        id = 'tabPanel',
        type = 'tabs',
        source('tabMapUI.R', local = TRUE)$value,
        source('tabComparisonUI.R', local = TRUE)$value,
        source('tabTableUI.R', local = TRUE)$value,
        tabPanel(title = 'Appx: Data Sources', value = 'tab04', htmlOutput('tab04_htmlDataSources'), tags$hr()),
        tabPanel(title = 'Appx: Variables', value = 'tab05', htmlOutput('tab05_htmlVariables'), tags$hr()),
        tabPanel(title = 'Appx: Methodology', value = 'tab06', htmlOutput('tab06_htmlMethodology'), tags$hr())
      ),
      width = 10
    )
  )
)

