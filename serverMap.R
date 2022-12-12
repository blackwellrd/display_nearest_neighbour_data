# ========================= #
# Desc: Map Tab Server File #
# File: serverMap.R         #
# ========================= #

rv_data <- reactive({
  if(input$tab01_selLevel=='Practice'){
    df_practice_data
  } else if(input$tab01_selLevel=='PCN'){
    df_pcn_data
  }
})

observeEvent(
  input$tab01_selLevel,
  {
    if(input$tab01_selLevel=='Practice'){
      df_tmp <- rv_data() %>% transmute(COMM_REGION_CODE, ICB_CODE, SUB_ICB_LOCATION_CODE, PRACTICE_CODE, PRACTICE_NAME, name = paste0('[', PRACTICE_CODE, '] - ', PRACTICE_NAME), code = PRACTICE_CODE)
    } else if(input$tab01_selLevel=='PCN'){
      df_tmp <- rv_data() %>% transmute(COMM_REGION_CODE, ICB_CODE, SUB_ICB_LOCATION_CODE, PCN_CODE, PCN_NAME, name = paste0('[', PCN_CODE, '] - ', PCN_NAME), code = PCN_CODE)
    }
    if(input$tab01_selSubICB!=''){
      df_tmp <- df_tmp %>% filter(SUB_ICB_LOCATION_CODE==input$tab01_selSubICB)
    } else if(input$tab01_selICB!=''){
      df_tmp <- df_tmp %>% filter(ICB_CODE==input$tab01_selICB)
    } else if(input$tab01_selRegion!=''){
      df_tmp <- df_tmp %>% filter(COMM_REGION_CODE==input$tab01_selRegion)
    }
    vct_sel <- df_tmp %>% arrange(name) %>% .$code
    names(vct_sel) <- df_tmp %>% arrange(name) %>% .$name
    updateSelectInput(inputId='tab01_selOrg', choices = vct_sel, selected = '')
  }
)

observeEvent(
  input$tab01_selRegion,
  {
    if(input$tab01_selRegion==''){
      updateSelectInput(inputId='tab01_selICB', choices = vct_icb, selected = '')
      updateSelectInput(inputId='tab01_selSubICB', choices = vct_subicb, selected = '')
    } else {
      # Filter on the region and update the ICB and sub-ICB select inputs
      vct_sel <- rv_data() %>% 
        filter(COMM_REGION_CODE==input$tab01_selRegion) %>%
        arrange(ICB_CODE, ICB_NAME) %>% 
        .$ICB_CODE
      names(vct_sel) <- rv_data() %>% 
        filter(COMM_REGION_CODE==input$tab01_selRegion) %>%
        arrange(ICB_CODE, ICB_NAME) %>% 
        transmute(label = paste0('[', ICB_CODE, '] - ', ICB_NAME)) %>%
        .$label
      updateSelectInput(inputId='tab01_selICB', choices = vct_sel, selected = '')

      vct_sel <- rv_data() %>% 
        filter(COMM_REGION_CODE==input$tab01_selRegion) %>%
        arrange(SUB_ICB_LOCATION_CODE, SUB_ICB_LOCATION_NAME) %>% 
        .$SUB_ICB_LOCATION_CODE
      names(vct_sel) <- rv_data() %>% 
        filter(COMM_REGION_CODE==input$tab01_selRegion) %>%
        arrange(SUB_ICB_LOCATION_CODE, SUB_ICB_LOCATION_NAME) %>% 
        transmute(label = paste0('[', SUB_ICB_LOCATION_CODE, '] - ', SUB_ICB_LOCATION_NAME)) %>%
        .$label
      updateSelectInput(inputId='tab01_selSubICB', choices = vct_sel, selected = '')
    }

    if(input$tab01_selLevel=='Practice'){
      df_tmp <- rv_data() %>% transmute(COMM_REGION_CODE, ICB_CODE, SUB_ICB_LOCATION_CODE, PRACTICE_CODE, PRACTICE_NAME, name = paste0('[', PRACTICE_CODE, '] - ', PRACTICE_NAME), code = PRACTICE_CODE)
    } else if(input$tab01_selLevel=='PCN'){
      df_tmp <- rv_data() %>% transmute(COMM_REGION_CODE, ICB_CODE, SUB_ICB_LOCATION_CODE, PCN_CODE, PCN_NAME, name = paste0('[', PCN_CODE, '] - ', PCN_NAME), code = PCN_CODE)
    }
    if(input$tab01_selSubICB!=''){
      df_tmp <- df_tmp %>% filter(SUB_ICB_LOCATION_CODE==input$tab01_selSubICB)
    } else if(input$tab01_selICB!=''){
      df_tmp <- df_tmp %>% filter(ICB_CODE==input$tab01_selICB)
    } else if(input$tab01_selRegion!=''){
      df_tmp <- df_tmp %>% filter(COMM_REGION_CODE==input$tab01_selRegion)
    }
    vct_sel <- df_tmp %>% arrange(name) %>% .$code
    names(vct_sel) <- df_tmp %>% arrange(name) %>% .$name
    updateSelectInput(inputId='tab01_selOrg', choices = vct_sel, selected = '')
  }
)

observeEvent(
  input$tab01_selICB,
  {
    if(input$tab01_selICB==''){
      # If the ICB has been reset (i.e. nothing selected) then 
      # reset the Sub-ICB to the full list for the region but leave 
      # the ICB list as is
      vct_sel <- rv_data() %>%
        filter(COMM_REGION_CODE==input$tab01_selRegion) %>%
        arrange(SUB_ICB_LOCATION_CODE, SUB_ICB_LOCATION_NAME) %>%
        .$SUB_ICB_LOCATION_CODE
      names(vct_sel) <- rv_data() %>%
        filter(COMM_REGION_CODE==input$tab01_selRegion) %>%
        arrange(SUB_ICB_LOCATION_CODE, SUB_ICB_LOCATION_NAME) %>%
        transmute(label = paste0('[', SUB_ICB_LOCATION_CODE, '] - ', SUB_ICB_LOCATION_NAME)) %>%
        .$label
      updateSelectInput(inputId='tab01_selSubICB', choices = vct_sel, selected = '')
    } else {
      # Otherwise set the sub-ICB to the list for the selected ICB 
      vct_sel <- rv_data() %>%
        filter(COMM_REGION_CODE==input$tab01_selRegion & ICB_CODE==input$tab01_selICB) %>%
        arrange(SUB_ICB_LOCATION_CODE, SUB_ICB_LOCATION_NAME) %>%
        .$SUB_ICB_LOCATION_CODE
      names(vct_sel) <- rv_data() %>%
        filter(COMM_REGION_CODE==input$tab01_selRegion & ICB_CODE==input$tab01_selICB) %>%
        arrange(SUB_ICB_LOCATION_CODE, SUB_ICB_LOCATION_NAME) %>%
        transmute(label = paste0('[', SUB_ICB_LOCATION_CODE, '] - ', SUB_ICB_LOCATION_NAME)) %>%
        .$label
      updateSelectInput(inputId='tab01_selSubICB', choices = vct_sel, selected = '')
    }
    
    if(input$tab01_selLevel=='Practice'){
      df_tmp <- rv_data() %>% transmute(COMM_REGION_CODE, ICB_CODE, SUB_ICB_LOCATION_CODE, PRACTICE_CODE, PRACTICE_NAME, name = paste0('[', PRACTICE_CODE, '] - ', PRACTICE_NAME), code = PRACTICE_CODE)
    } else if(input$tab01_selLevel=='PCN'){
      df_tmp <- rv_data() %>% transmute(COMM_REGION_CODE, ICB_CODE, SUB_ICB_LOCATION_CODE, PCN_CODE, PCN_NAME, name = paste0('[', PCN_CODE, '] - ', PCN_NAME), code = PCN_CODE)
    }
    if(input$tab01_selSubICB!=''){
      df_tmp <- df_tmp %>% filter(SUB_ICB_LOCATION_CODE==input$tab01_selSubICB)
    } else if(input$tab01_selICB!=''){
      df_tmp <- df_tmp %>% filter(ICB_CODE==input$tab01_selICB)
    } else if(input$tab01_selRegion!=''){
      df_tmp <- df_tmp %>% filter(COMM_REGION_CODE==input$tab01_selRegion)
    }
    vct_sel <- df_tmp %>% arrange(name) %>% .$code
    names(vct_sel) <- df_tmp %>% arrange(name) %>% .$name
    updateSelectInput(inputId='tab01_selOrg', choices = vct_sel, selected = '')
  }
)

observeEvent(
  input$tab01_selSubICB,
  {
    if(input$tab01_selLevel=='Practice'){
      df_tmp <- rv_data() %>% transmute(COMM_REGION_CODE, ICB_CODE, SUB_ICB_LOCATION_CODE, PRACTICE_CODE, PRACTICE_NAME, name = paste0('[', PRACTICE_CODE, '] - ', PRACTICE_NAME), code = PRACTICE_CODE)
    } else if(input$tab01_selLevel=='PCN'){
      df_tmp <- rv_data() %>% transmute(COMM_REGION_CODE, ICB_CODE, SUB_ICB_LOCATION_CODE, PCN_CODE, PCN_NAME, name = paste0('[', PCN_CODE, '] - ', PCN_NAME), code = PCN_CODE)
    }
    if(input$tab01_selSubICB!=''){
      df_tmp <- df_tmp %>% filter(SUB_ICB_LOCATION_CODE==input$tab01_selSubICB)
    } else if(input$tab01_selICB!=''){
      df_tmp <- df_tmp %>% filter(ICB_CODE==input$tab01_selICB)
    } else if(input$tab01_selRegion!=''){
      df_tmp <- df_tmp %>% filter(COMM_REGION_CODE==input$tab01_selRegion)
    }
    vct_sel <- df_tmp %>% arrange(name) %>% .$code
    names(vct_sel) <- df_tmp %>% arrange(name) %>% .$name
    updateSelectInput(inputId='tab01_selOrg', choices = vct_sel, selected = '')
  }
)

output$tab01_map <- renderLeaflet({
  if(input$tab01_selOrg==''){
    
  }
  df_map <- rv_data() %>% filter()
  
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