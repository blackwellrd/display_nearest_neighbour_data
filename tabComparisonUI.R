# ====================================== #
# Desc: Comparison Charts User Interface #
# File: tabComparisonUI.R                #
# ====================================== #

tabPanel(
  title = 'Comparison',
  value = 'tab02',
  htmlOutput('tab02_txtHeader'),
  plotlyOutput('tab02_pltNational', height = 800)
)