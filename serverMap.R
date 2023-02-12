# ========================= #
# Desc: Map Tab Server File #
# File: serverMap.R         #
# ========================= #

output$tab01_map <- renderLeaflet({
  sf_neighbours <- rv_data() %>% st_as_sf(coords = c('LONGITUDE','LATITUDE'), crs = 4326)
  sf_neighbours$type <- NA
  
  if(input$selLevel=='Practice'){
    sf_neighbours$type[sf_neighbours$PRACTICE_CODE==input$selOrg] <- 'ORIGIN'
    sf_neighbours$type[sf_neighbours$PRACTICE_CODE %in% df_practice_neighbours$dest[df_practice_neighbours$orig==input$selOrg]] <- 'NEIGHBOUR'
  } else if(input$selLevel=='PCN'){
    sf_neighbours$type[sf_neighbours$PCN_CODE==input$selOrg] <- 'ORIGIN'
    sf_neighbours$type[sf_neighbours$PCN_CODE %in% df_pcn_neighbours$dest[df_pcn_neighbours$orig==input$selOrg]] <- 'NEIGHBOUR'
  }
  
  pal <- colorFactor(palette = c('#d95f02', '#7570b3'), domain = factor(sf_neighbours$type, levels = c('ORIGIN','NEIGHBOUR')))
  map <- leaflet() %>%
    addTiles() %>%
    addPolygons(data = sf_subicb, weight = 2, fillOpacity = 0.1, popup = ~LOC22NM)
  if(input$selLevel=='Practice'){
    sf_neighbours$type[sf_neighbours$PRACTICE_CODE==input$selOrg] <- 'ORIGIN'
    sf_neighbours$type[sf_neighbours$PRACTICE_CODE %in% df_practice_neighbours$dest[df_practice_neighbours$orig==input$selOrg]] <- 'NEIGHBOUR'
    map <- addCircleMarkers(
      map = map, 
      data = sf_neighbours %>% filter(!is.na(type)), 
      group = ~type,
      radius = 10, 
      weight = 2, 
      fillOpacity = 1, 
      fillColor = ~pal(type), 
      popup = ~paste0(
        'Practice: ', PRACTICE_NAME, ' - [', PRACTICE_CODE, ']<br>',
        'System: ', SUPPLIER_NAME, '<br>',
        'Sub-ICB Location: ', SUB_ICB_LOCATION_NAME, ' - [', SUB_ICB_LOCATION_CODE, ']<br>',
        'ICB: ', ICB_NAME, ' - [', ICB_CODE, ']<br>',
        'Region: ', COMM_REGION_NAME, ' - [', COMM_REGION_CODE, ']<br>',
        'Popn: ', prettyNum(POPN_PERSON, big.mark = ',')
      )
    )
  } else if(input$selLevel=='PCN'){
    sf_neighbours$type[sf_neighbours$PCN_CODE==input$selOrg] <- 'ORIGIN'
    sf_neighbours$type[sf_neighbours$PCN_CODE %in% df_pcn_neighbours$dest[df_pcn_neighbours$orig==input$selOrg]] <- 'NEIGHBOUR'
    map <- addCircleMarkers(
      map = map, 
      data = sf_neighbours %>% filter(!is.na(type)), 
      group = ~type,
      radius = 10, 
      weight = 2, 
      fillOpacity = 1, 
      fillColor = ~pal(type), 
      popup = ~paste0(
        'PCN: ', PCN_NAME, '- [', PCN_CODE, ']<br>',
        'Sub-ICB Location: ', SUB_ICB_LOCATION_NAME, ' - [', SUB_ICB_LOCATION_CODE, ']<br>',
        'ICB: ', ICB_NAME, ' - [', ICB_CODE, ']<br>',
        'Region: ', COMM_REGION_NAME, ' - [', COMM_REGION_CODE, ']<br>',
        'Popn: ', prettyNum(POPN_PERSON, big.mark = ',')
      )
    )
  }
  map <- map %>% 
    addControl(
      html = 'Source: Office for National Statistics licensed under the Open Government Licence v.3.0<br>Contains OS data © Crown copyright and database right [2023]',
      position = "bottomleft", layerId = NULL, className = "info legend"
    ) %>% 
    addLayersControl(overlayGroups = c('ORIGIN','NEIGHBOUR'))
})

