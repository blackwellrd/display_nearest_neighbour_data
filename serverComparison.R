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
  
  if(input$selLevel=='Practice'){
    df_plot_data <- rv_data() %>% transmute(PRACTICE_CODE, PRACTICE_NAME, METRIC = !!rlang::sym(input$selVar))
    df_plot_data$TYPE <- 'OTHER'
    
    df_plot_data$TYPE[df_plot_data$PRACTICE_CODE==input$selOrg] <- 'ORIGIN'
    df_plot_data$TYPE[df_plot_data$PRACTICE_CODE %in% df_practice_neighbours$dest[df_practice_neighbours$orig==input$selOrg]] <- 'NEIGHBOUR'

    nNeighbours = NROW(df_plot_data %>% filter(TYPE=='NEIGHBOUR'))
    dblJitter = 0.025
    
    df_plot_data <- df_plot_data %>% 
      mutate(
        LABEL = paste0('[', PRACTICE_CODE, '] - ', PRACTICE_NAME)
      )

    pal <- colorFactor(palette = c('ORIGIN' = '#e41a1c', 'NEIGHBOUR' = '#4daf4a', 'OTHER' = '#377eb8'), levels = c('ORIGIN','NEIGHBOUR','OTHER'))
    plt <- plot_ly(data = df_plot_data) %>%
      add_trace(
        name = 'National',
        type = 'box',
        x = 1,
        y = ~METRIC,
        hoverinfo = 'y'
      ) %>%
      add_trace(
        data = df_plot_data %>% filter(TYPE=='NEIGHBOUR'),
        name = 'NEIGHBOUR',
        type = 'scatter',
        mode = 'markers',
        size = 10,
        x = runif(n = nNeighbours, min = 1 - dblJitter, max = 1 + dblJitter),
        y = ~METRIC,
        text = ~LABEL,
        hoverinfo = 'y+text',
        markers = list(color = ~pal(TYPE))
      ) %>%
      add_trace(
        data = df_plot_data %>% filter(TYPE=='ORIGIN'),
        type = 'scatter',
        mode = 'markers',
        size = 10,
        x = 1,
        y = ~METRIC,
        text = ~LABEL,
        hoverinfo = 'y+text',
        markers = list(color = ~pal(TYPE))
      ) %>%
      layout(
        title = paste0('Box Plot of Distribution of ', sel_var_desc, ' by Practice with Neighbour and Origin Values'),
        yaxis = list(title = sel_var_desc)
      )
    plt
  } else if(input$selLevel=='PCN'){
    df_plot_data <- rv_data() %>% transmute(PCN_CODE, PCN_NAME, METRIC = !!rlang::sym(input$selVar))
    df_plot_data$TYPE <- 'OTHER'
    
    df_plot_data$TYPE[df_plot_data$PCN_CODE==input$selOrg] <- 'ORIGIN'
    df_plot_data$TYPE[df_plot_data$PCN_CODE %in% df_pcn_neighbours$dest[df_pcn_neighbours$orig==input$selOrg]] <- 'NEIGHBOUR'
    
    nNeighbours = NROW(df_plot_data %>% filter(TYPE=='NEIGHBOUR'))
    dblJitter = 0.025
    
    df_plot_data <- df_plot_data %>% 
      mutate(
        LABEL = paste0('[', PCN_CODE, '] - ', PCN_NAME)
      )
    
    pal <- colorFactor(palette = c('ORIGIN' = '#e41a1c', 'NEIGHBOUR' = '#4daf4a', 'OTHER' = '#377eb8'), levels = c('ORIGIN','NEIGHBOUR','OTHER'))
    plt <- plot_ly(data = df_plot_data) %>%
      add_trace(
        name = 'National',
        type = 'box',
        x = 1,
        y = ~METRIC,
        hoverinfo = 'y'
      ) %>%
      add_trace(
        data = df_plot_data %>% filter(TYPE=='NEIGHBOUR'),
        name = 'NEIGHBOUR',
        type = 'scatter',
        mode = 'markers',
        size = 10,
        x = runif(n = nNeighbours, min = 1 - dblJitter, max = 1 + dblJitter),
        y = ~METRIC,
        text = ~LABEL,
        hoverinfo = 'y+text',
        markers = list(color = ~pal(TYPE))
      ) %>%
      add_trace(
        data = df_plot_data %>% filter(TYPE=='ORIGIN'),
        type = 'scatter',
        mode = 'markers',
        size = 10,
        x = 1,
        y = ~METRIC,
        text = ~LABEL,
        hoverinfo = 'y+text',
        markers = list(color = ~pal(TYPE))
      ) %>%
      layout(
        title = paste0('Box Plot of Distribution of ', sel_var_desc, ' by PCN with Neighbour and Origin Values'),
        yaxis = list(title = sel_var_desc)
      )      
    plt    
  }
})
