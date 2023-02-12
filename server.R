# =================================================== #
# Desc: Server File for Nearest Neighbour Display App #
# File: server.R                                      #
# =================================================== #

shinyServer(function(session, input, output) {
  rv_data <- reactive({
    if(input$selLevel=='Practice'){
      df_practice_data
    } else if(input$selLevel=='PCN'){
      df_pcn_data
    }
  })

  observeEvent(
    rv_data(),
    {
      if(input$selLevel=='Practice'){
        vct_Orgs <- rv_data() %>% 
          distinct(SUB_ICB_LOCATION_CODE, PRACTICE_CODE, PRACTICE_NAME) %>% 
          filter(SUB_ICB_LOCATION_CODE==input$selSubICB) %>%
          transmute(
            name = paste0('[', PRACTICE_CODE, '] - ', PRACTICE_NAME),
            code = PRACTICE_CODE
          ) %>%
          arrange(name) %>%
          deframe()
      } else if(input$selLevel=='PCN'){
        vct_Orgs <- rv_data() %>% 
          distinct(SUB_ICB_LOCATION_CODE, PCN_CODE, PCN_NAME) %>% 
          filter(SUB_ICB_LOCATION_CODE==input$selSubICB) %>%
          transmute(
            name = paste0('[', PCN_CODE, '] - ', PCN_NAME),
            code = PCN_CODE
          ) %>%
          arrange(name) %>%
          deframe()
      }
      updateSelectInput(
        inputId = 'selOrg', 
        choices = c('', vct_Orgs),
        selected = NULL
      )
    }
  )
    
  observeEvent(
    input$selRegion,
    {
      updateSelectInput(
        inputId = 'selICB', 
        choices = rv_data() %>% 
          distinct(COMM_REGION_CODE, ICB_CODE, ICB_NAME) %>% 
          filter(COMM_REGION_CODE==input$selRegion) %>%
          transmute(
            name = paste0('[', ICB_CODE, '] - ', ICB_NAME),
            code = ICB_CODE
          ) %>%
          arrange(name) %>%
          deframe()
      )
    }
  )
  
  observeEvent(
    input$selICB,
    {
      updateSelectInput(
        inputId = 'selSubICB', 
        choices = rv_data() %>% 
          distinct(ICB_CODE, SUB_ICB_LOCATION_CODE, SUB_ICB_LOCATION_NAME) %>% 
          filter(ICB_CODE==input$selICB) %>%
          transmute(
            name = paste0('[', SUB_ICB_LOCATION_CODE, '] - ', SUB_ICB_LOCATION_NAME),
            code = SUB_ICB_LOCATION_CODE
          ) %>%
          arrange(name) %>%
          deframe()
      )
    }
  )
  
  observeEvent(
    input$selSubICB,
    {
      if(input$selLevel=='Practice'){
        vct_Orgs <- rv_data() %>% 
          distinct(SUB_ICB_LOCATION_CODE, PRACTICE_CODE, PRACTICE_NAME) %>% 
          filter(SUB_ICB_LOCATION_CODE==input$selSubICB) %>%
          transmute(
            name = paste0('[', PRACTICE_CODE, '] - ', PRACTICE_NAME),
            code = PRACTICE_CODE
          ) %>%
          arrange(name) %>%
          deframe()
      } else if(input$selLevel=='PCN'){
        vct_Orgs <- rv_data() %>% 
          distinct(SUB_ICB_LOCATION_CODE, PCN_CODE, PCN_NAME) %>% 
          filter(SUB_ICB_LOCATION_CODE==input$selSubICB) %>%
          transmute(
            name = paste0('[', PCN_CODE, '] - ', PCN_NAME),
            code = PCN_CODE
          ) %>%
          arrange(name) %>%
          deframe()
      }
      updateSelectInput(
        inputId = 'selOrg', 
        choices = c('', vct_Orgs),
        selected = NULL
      )
    }
  )

  observeEvent(
    input$tabPanel,
    {
      if(input$tabPanel=='tab01'){
        shinyjs::hide(id = 'selVarGroup')
        shinyjs::hide(id = 'selVar')
      } else if(input$tabPanel=='tab02'){
        shinyjs::show(id = 'selVarGroup')
        shinyjs::show(id = 'selVar')
      }
    }
  )
  
  source('serverMap.R', local = TRUE, encoding = "UTF-8")
  source('serverComparison.R', local = TRUE, encoding = "UTF-8")
  source('serverTable.R', local = TRUE, encoding = "UTF-8")
  
  output$tab04_htmlDataSources <- renderUI({withMathJax(includeHTML('data_sources.html'))})
  output$tab05_htmlVariables <- renderUI({withMathJax(includeHTML('variables.html'))})
  output$tab06_htmlMethodology <- renderUI({withMathJax(includeHTML('methodology.html'))})
  
  # Ensure the session stops
  session$onSessionEnded(stopApp)
  }
)

