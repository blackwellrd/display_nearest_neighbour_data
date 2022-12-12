# =================================================== #
# Desc: Server File for Nearest Neighbour Display App #
# File: server.R                                      #
# =================================================== #

shinyServer(function(session, input, output) {
  source('serverMap.R', local = TRUE, encoding = "UTF-8")
  
  # Ensure the session stops
  session$onSessionEnded(stopApp)
  }
)

# shinyServer(function(session, input, output) {
#   source('serverImportData.R', local = TRUE, encoding = "UTF-8")
#   source('serverDemographicPlots.R', local = TRUE, encoding = "UTF-8")
#   source('serverQOFRegisterPlots.R', local = TRUE, encoding = "UTF-8")
#   source('serverQOFRegisterTables.R', local = TRUE, encoding = "UTF-8")
#   source('serverOtherRegisterTables.R', local = TRUE, encoding = "UTF-8")
#   source('serverPatientAttributePlots.R', local = TRUE, encoding = "UTF-8")
#   source('serverDemandActivityPlots.R', local = TRUE, encoding = "UTF-8")
#   hideTab(inputId = 'tabPanel', target = 'tab02')
#   hideTab(inputId = 'tabPanel', target = 'tab03')
#   hideTab(inputId = 'tabPanel', target = 'tab04')
#   hideTab(inputId = 'tabPanel', target = 'tab05')
#   hideTab(inputId = 'tabPanel', target = 'tab06')
#   hideTab(inputId = 'tabPanel', target = 'tab07')
#   shinyjs::hide(id = 'tab01_filData') 
# }
# )
