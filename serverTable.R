# ========================== #
# Desc: TableTab Server File #
# File: serverTable.R        #
# ========================== #

output$tab03_table <- DT::renderDataTable({
  sf_neighbours <- rv_data()
  sf_neighbours$type <- NA
  
  if(input$selLevel=='Practice'){
    sf_neighbours$type[sf_neighbours$PRACTICE_CODE==input$selOrg] <- 'ORIGIN'
    sf_neighbours$type[sf_neighbours$PRACTICE_CODE %in% df_practice_neighbours$dest[df_practice_neighbours$orig==input$selOrg]] <- 'NEIGHBOUR'
  } else if(input$selLevel=='PCN'){
    sf_neighbours$type[sf_neighbours$PCN_CODE==input$selOrg] <- 'ORIGIN'
    sf_neighbours$type[sf_neighbours$PCN_CODE %in% df_pcn_neighbours$dest[df_pcn_neighbours$orig==input$selOrg]] <- 'NEIGHBOUR'
  }

  # browser()
  # sf_neighbours %>% names()
})

