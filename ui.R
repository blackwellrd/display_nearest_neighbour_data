# =========================================================== #
# Desc: User Interface File for Nearest Neighbour Display App #
# File: ui.R                                                  #
# =========================================================== #
ui <- fluidPage(
  shinyjs::useShinyjs(),
  titlePanel('Nearest Neighbour'),
  tabsetPanel(
    id = 'tabPanel',
    type = 'tabs',
    source('tabMapUI.R', local = TRUE)$value
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
