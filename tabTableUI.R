# ========================== #
# Desc: Table User Interface #
# File: tabTableUI.R         #
# =================--======= #

tabPanel(
  title = 'Table',
  value = 'tab03',
  DT::DTOutput('tab03_table')
)
