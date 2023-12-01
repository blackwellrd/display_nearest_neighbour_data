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
          distinct(ICB_CODE, ORG_CODE, ORG_NAME) %>% 
          filter(ICB_CODE==input$selICB) %>%
          transmute(
            name = paste0('[', ORG_CODE, '] - ', ORG_NAME),
            code = ORG_CODE
          ) %>%
          arrange(name) %>%
          deframe()
      } else if(input$selLevel=='PCN'){
        vct_Orgs <- rv_data() %>% 
          distinct(ICB_CODE, ORG_CODE, ORG_NAME) %>% 
          filter(ICB_CODE==input$selICB) %>%
          transmute(
            name = paste0('[', ORG_CODE, '] - ', ORG_NAME),
            code = ORG_CODE
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
          distinct(NHSER_CODE, ICB_CODE, ICB_NAME) %>% 
          filter(NHSER_CODE==input$selRegion) %>%
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
      if(input$selLevel=='Practice'){
        vct_Orgs <- rv_data() %>% 
          distinct(ICB_CODE, ORG_CODE, ORG_NAME) %>% 
          filter(ICB_CODE==input$selICB) %>%
          transmute(
            name = paste0('[', ORG_CODE, '] - ', ORG_NAME),
            code = ORG_CODE
          ) %>%
          arrange(name) %>%
          deframe()
      } else if(input$selLevel=='PCN'){
        vct_Orgs <- rv_data() %>% 
          distinct(ICB_CODE, ORG_CODE, ORG_NAME) %>% 
          filter(ICB_CODE==input$selICB) %>%
          transmute(
            name = paste0('[', ORG_CODE, '] - ', ORG_NAME),
            code = ORG_CODE
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
        shinyjs::hide(id = 'chkFocus')
      } else if(input$tabPanel=='tab02'){
        shinyjs::show(id = 'selVarGroup')
        shinyjs::show(id = 'selVar')
        shinyjs::show(id = 'chkFocus')
      }
    }
  )
  
  source('serverMap.R', local = TRUE, encoding = "UTF-8")
  source('serverComparison.R', local = TRUE, encoding = "UTF-8")
  source('serverTable.R', local = TRUE, encoding = "UTF-8")
  
  output$tab04_htmlAuthor <- renderUI({withMathJax(includeHTML('author.html'))})
  output$tab05_htmlDataSources <- renderUI({withMathJax(includeHTML('data_sources.html'))})
  output$tab06_htmlVariables <- renderUI({withMathJax(includeHTML('variables.html'))})
  output$tab07_htmlMethodology <- renderUI({withMathJax(includeHTML('methodology.html'))})
  
  # Ensure the session stops
  session$onSessionEnded(stopApp)
  }
)

