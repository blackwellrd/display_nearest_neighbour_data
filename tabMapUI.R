# ======================== #
# Desc: Map User Interface #
# File: tabMapUI.R         #
# ======================== #

tabPanel(
  title = 'Map',
  value = 'tab01',
  tags$style(type = "text/css", "#tab01_map {height: calc(100vh - 80px) !important;}"),
  leafletOutput('tab01_map'),
)
