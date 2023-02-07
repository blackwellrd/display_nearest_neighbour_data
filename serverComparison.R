# ================================ #
# Desc: Comparison Tab Server File #
# File: serverComparison.R         #
# ================================ #

observeEvent(
  input$selVarGroup,
  {
    vct_var <- names(unlist(ini_file_sections[[input$selVarGroup]]))
    names(vct_var) <- unname(unlist(ini_file_sections[[input$selVarGroup]]))
    updateSelectInput(
      inputId = 'selVar',
      choices = vct_var)
  }
)

output$tab02_pltNational <- renderPlotly({
  sel_var_desc <- unname(unlist(ini_file_sections[[input$selVarGroup]][input$selVar]))
  df_plot_data <- rv_data() %>% transmute(PRACTICE_CODE, PRACTICE_NAME, METRIC = !!rlang::sym(input$selVar))
  df_plot_data$TYPE <- 'OTHER'
  
  if(input$selLevel=='Practice'){
    df_plot_data$TYPE[df_plot_data$PRACTICE_CODE==input$selOrg] <- 'ORIGIN'
    df_plot_data$TYPE[df_plot_data$PRACTICE_CODE %in% df_practice_neighbours$dest[df_practice_neighbours$orig==input$selOrg]] <- 'NEIGHBOUR'

    df_plot_data <- df_plot_data %>% 
      mutate(
        LABEL = paste0('[', PRACTICE_CODE, '] - ', PRACTICE_NAME)
      )
    pal <- colorFactor(palette = c('ORIGIN' = '#e41a1c', 'NEIGHBOUR' = '#4daf4a', 'OTHER' = '#377eb8'), levels = c('ORIGIN','NEIGHBOUR','OTHER'))
    plt <- plot_ly(data = df_plot_data) %>%
      add_trace(
        type='bar',
        x = ~LABEL, 
        y = ~METRIC,
        text = ~TYPE,
        hoverinfo = 'x+y+text',
        markers = list(color = ~pal(TYPE))
      ) %>%
      layout(
        title = paste0('National Distribution of ', sel_var_desc, ' by Practice'),
        xaxis = list(title = 'Practice', categoryorder = "total ascending"), 
        yaxis = list(title = sel_var_desc)
      )
    plt    
  } else if(input$selLevel=='PCN'){
    df_plot_data$TYPE[df_plot_data$PCN_CODE==input$selOrg] <- 'ORIGIN'
    df_plot_data$TYPE[df_plot_data$PCN_CODE %in% df_pcn_neighbours$dest[df_pcn_neighbours$orig==input$selOrg]] <- 'NEIGHBOUR'
    
    df_plot_data$WIDTH <- 1
    df_plot_data$WIDTH[df_plot_data$TYPE=='ORIGIN'] <- 5
    
    vct_levels <- df_plot_data %>% 
      mutate(LABEL = paste0('[', PCN_CODE, '] - ', PCN_NAME)) %>%
      arrange(METRIC, LABEL) %>%
      .$LABEL
    
    df_plot_data <- df_plot_data %>% 
      mutate(LABEL = factor(paste0('[', PCN_CODE, '] - ', PCN_NAME), levels = vct_levels))
             
    plt <- plot_ly(data = df_plot_data) %>%
      add_trace(
        type='bar',
        x = ~LABEL, 
        y = ~METRIC,
        text = ~TYPE,
        hoverinfo = 'x+y+text',
        width = ~WIDTH,
        marker = list(color = ~pal(TYPE), opacity = ~ifelse(TYPE=='ORIGIN',1,0.1))
      ) %>%
      layout(
        title = paste0('National Distribution of ', sel_var_desc, ' by Primary Care Network'),
        xaxis = list(title = 'PCN'), 
        yaxis = list(title = sel_var_desc)
      )
    plt    
  }
})

output$tab02_pltNeighbours <- renderPlotly({
  
})