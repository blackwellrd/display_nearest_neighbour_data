# =========================================================== #
# Desc: User Interface File for Nearest Neighbour Display App #
# File: ui.R                                                  #
# =========================================================== #
ui <- fluidPage(
  shinyjs::useShinyjs(),
  titlePanel('Nearest Neighbour'),
  sidebarLayout(
    sidebarPanel(
      tags$h3('Selected Organisation'),
      radioButtons(inputId = 'selLevel', label = 'Level', choices = c('Practice','PCN'), selected = 'Practice'),
      selectInput(
        inputId = 'selRegion', 
        label = 'Region', 
        choices = df_practice_data %>% 
                    distinct(COMM_REGION_CODE, COMM_REGION_NAME) %>% 
                    transmute(
                      name = paste0('[', COMM_REGION_CODE, '] - ', COMM_REGION_NAME),
                      code = COMM_REGION_CODE
                    ) %>%
                    arrange(name) %>%
                    deframe()
      ),
      selectInput(inputId = 'selICB', label = 'ICB', choices = c(''), selected = NULL),
      selectInput(inputId = 'selSubICB', label = 'Sub-ICB Location', choices = c(''), selected = NULL),
      selectInput(inputId = 'selOrg', label = 'Organisation', choices = c(''), selected = NULL),
      tags$hr(),
      width = 2),
    mainPanel(
      tabsetPanel(
        id = 'tabPanel',
        type = 'tabs',
        source('tabMapUI.R', local = TRUE)$value,
        tabPanel(
          title = 'Table',
          value = 'tab02',
          DT::dataTableOutput('tab02_table'),
          tags$hr()
        )
      ),
      width = 10
    )
  )
)

# ui <- fluidPage(
#   shinyjs::useShinyjs(),
#   titlePanel('Cluster Viewer'),
#   tabsetPanel(
#     id = 'tabPanel',
#     type = 'tabs',
#     source('tabImportDataUI.R', local = TRUE)$value,
#     source('tabDemographicPlotsUI.R', local = TRUE)$value,
#     source('tabQOFRegisterPlotsUI.R', local = TRUE)$value,
#     source('tabQOFRegisterTablesUI.R', local = TRUE)$value,
#     source('tabOtherRegisterTablesUI.R', local = TRUE)$value,
#     source('tabPatientAttributePlotsUI.R', local = TRUE)$value,
#     source('tabDemandActivityPlotsUI.R', local = TRUE)$value
#   )
# )
