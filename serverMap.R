# ========================= #
# Desc: Map Tab Server File #
# File: serverMap.R         #
# ========================= #

rvData <- reactive({
  if(input$tab01_selLevel=='Practice'){
    df_data <- df_practice_data
  } else if(input$tab01_selLevel=='Practice'){
    df_data <- df_pcn_data
  }
})

output$tab01_map <- renderLeaflet({
  map <- leaflet() %>%
    addTiles()
  if(input$tab01_selSubICB!=''){
    map <- addPolygons(map, data = sf_subicb, fill = FALSE)
    bbox <- st_bbox(sf_subicb)
    map <- fitBounds(map, lng1 = unname(bbox$xmin), lat1 = unname(bbox$ymin), lng2 = unname(bbox$xmax), lat2 = unname(bbox$ymax))
  } else if(input$tab01_selICB!=''){
    map <- addPolygons(map, data = sf_icb, fill = FALSE)
    bbox <- st_bbox(sf_icb)
    map <- fitBounds(map, lng1 = unname(bbox$xmin), lat1 = unname(bbox$ymin), lng2 = unname(bbox$xmax), lat2 = unname(bbox$ymax))
  } else if(input$tab01_selRegion!=''){
    map <- addPolygons(map, data = sf_region, fill = FALSE)
    bbox <- st_bbox(sf_region)
    map <- fitBounds(map, lng1 = unname(bbox$xmin), lat1 = unname(bbox$ymin), lng2 = unname(bbox$xmax), lat2 = unname(bbox$ymax))
  }
  map
})

# leaflet() %>% 
#   addTiles() %>% 
#   addPolygons(
#     data = st_read(
#       dsn = 'D:/Data/OpenGeography/Shapefiles/REGION21', 
#       layer = 'NHS_England_(Regions)_(April_2021)_EN_BGC') %>% 
#       st_transform(crs = 4326) 
#   )