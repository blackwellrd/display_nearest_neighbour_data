# ========================== #
# Desc: TableTab Server File #
# File: serverTable.R        #
# ========================== #

output$tab03_table <- DT::renderDT({
  df_neighbours <- rv_data()
  all_variables <- names(df_neighbours)
  all_variables <- c('TYPE', all_variables)
  df_neighbours$TYPE <- NA
  df_neighbours <- df_neighbours %>% select(all_of(all_variables))

  if(input$selLevel=='Practice'){
    df_neighbours$TYPE[df_neighbours$ORG_CODE==input$selOrg] <- 'ORIGIN'
    df_neighbours$TYPE[df_neighbours$ORG_CODE %in% df_practice_neighbours$dest[df_practice_neighbours$orig==input$selOrg]] <- 'NEIGHBOUR'
    df_national_data <- df_neighbours %>% 
      summarise(across(.cols = numeric_variables, .fns = quantile, probs = c(0, 0.25, 0.5, 0.75, 1), na.rm = TRUE)) %>%
      ungroup() %>%
      mutate(
        TYPE = rep('NATIONAL', 5),
        ORG_CODE = c('NAT_MIN', 'NAT_Q1', 'NAT_MED', 'NAT_Q3', 'NAT_MAX'),
        ORG_NAME = c('National Minimum', 'National 1st Quartile', 'National Median', 'National 3rd Quartile', 'National Maximum')
      )
  } else if(input$selLevel=='PCN'){
    df_neighbours$TYPE[df_neighbours$ORG_CODE==input$selOrg] <- 'ORIGIN'
    df_neighbours$TYPE[df_neighbours$ORG_CODE %in% df_pcn_neighbours$dest[df_pcn_neighbours$orig==input$selOrg]] <- 'NEIGHBOUR'
    df_national_data <- df_neighbours %>% 
      summarise(across(.cols = numeric_variables, .fns = quantile, probs = c(0, 0.25, 0.5, 0.75, 1), na.rm = TRUE)) %>%
      ungroup() %>%
      mutate(
        TYPE = rep('NATIONAL', 5),
        ORG_CODE = c('NAT_MIN', 'NAT_Q1', 'NAT_MED', 'NAT_Q3', 'NAT_MAX'),
        ORG_NAME = c('National Minimum', 'National 1st Quartile', 'National Median', 'National 3rd Quartile', 'National Maximum')
      )
  }

  df_neighbours <- df_neighbours %>% 
    filter(!is.na(TYPE)) %>% 
    bind_rows(df_national_data)

  DT::datatable(
    data = df_neighbours,
    filter = list(position = 'top'), 
    extensions = 'Buttons',
    options = list(
      order = list(list(0, 'desc')),
      pageLength = NROW(df_neighbours),
      dom = 'Blftip',
      buttons = list(
        'copy',
        list(
          extend = 'collection',
          text = 'Download',
          buttons = list(
            list( extend = 'csv', filename = 'nearest_neighbour_metrics'),
            list( extend = 'excel', filename = 'nearest_neighbour_metrics'),
            list( extend = 'pdf', filename = 'nearest_neighbour_metrics')
          )
        ),
        'print'
      ),
      # Allows the use of regular expressions in filter boxes
      search = list(regex = TRUE, smart = TRUE, caseInsensitive = TRUE)
    ),
    rownames = FALSE
  )
})
