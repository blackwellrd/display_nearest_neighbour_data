# ========================= #
# Desc: Map Tab Server File #
# File: serverMap.R         #
# ========================= #

output$tab01_map <- renderLeaflet({
  map <- leaflet() %>%
    addTiles() %>%
    addPolygons(data = sf_subicb, fill = FALSE)
  map
})

