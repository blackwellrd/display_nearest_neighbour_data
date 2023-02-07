# ====================================== #
# Desc: Comparison Charts User Interface #
# File: tabComparisonUI.R                #
# ====================================== #

tabPanel(
  title = 'Comparison',
  value = 'tab02',
  plotlyOutput('tab02_pltNational'),
  plotlyOutput('tab02_pltNeighbours')
)