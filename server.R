#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(plotly)
library(GGally)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  output$dataTable <- renderDataTable(mtcars, options = list(lengthMenu = c(5, 10, 20), pageLength = 5))
  
  output$distPlot <- renderPlotly({

    parammethod <- input$parammethod
    paramx <- input$paramx
    paramy <- input$paramy
    paramc <- input$paramc
    
    ggplot_mtcars <- ggplot(data = mtcars, aes(x = get(paramx), y = get(paramy), colour = get(paramc))) +
      geom_point(size = 2) + 
      geom_smooth(method = parammethod, fill = "lightgreen") +
      ggtitle(paste(paramx ," vs ", paramy, "(method = ", parammethod, ")")) + 
      labs(x = paramx, y = paramy, colour = paramc) 
    
    if(input$facet) {
      ggplot_mtcars <- ggplot_mtcars + facet_grid(~get(paramc))
    }

    ggplot_mtcars

  })
  
  output$corrTable <- renderDataTable(ggcorr(mtcars)$data , options = list(lengthMenu = c(5, 10, 20), pageLength = 5))

  output$corrPlot <- renderPlotly({ 
    
    ggcorr_mtcars <- ggcorr(mtcars, label = TRUE, label_size = 2.5, color = "grey50") 
    
    ggcorr_mtcars
    
  })
  
})
