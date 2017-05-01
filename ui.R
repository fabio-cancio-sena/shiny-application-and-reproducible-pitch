#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(plotly)
library(shinythemes)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  theme = shinytheme("cerulean"),
  # Application title
  titlePanel("Explore the relation between two mtcars variables",
    h5("Developed by Fabio C. Sena")),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
      h4("Configuration"),
      selectInput("paramx", "X axis:", names(mtcars)[1:11], selected = "mpg"),
      selectInput("paramy", "Y axis:", names(mtcars)[1:11], selected = "qsec"),
      selectInput("paramc", "Colour (Facet):", c("cyl", "vs", "am", "gear", "carb"), selected = "cyl"),
      selectInput("parammethod", "Smooth method:", c("lm", "glm", "gam", "loess"), selected = "lm"),
      checkboxInput("facet", "Facet?", value = FALSE),
      h4("Instructions"),
      p("* See the data tab to see the data and the the description of the dataset and variables."),
      p("** See the documentation tab for help on how to use the tool.")
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
      tabsetPanel(
        tabPanel("Plot", plotlyOutput("distPlot")),
        tabPanel("Data", 
          dataTableOutput("dataTable"),
          h4("Dataset description"),
          p("The data was extracted from the 1974 Motor Trend US magazine, and comprises fuel consumption and 10 aspects of automobile design and performance for 32 automobiles (1973–74 models)."),
          h4("Dataset format"),
          p("A data frame with 32 observations on 11 variables."),
          tags$ul(
            tags$li("[, 1]	 mpg	 Miles/(US) gallon"),
            tags$li("[, 2]	 cyl	 Number of cylinders"),
            tags$li("[, 3]	 disp	 Displacement (cu.in.)"),
            tags$li("[, 4]	 hp	 Gross horsepower"),
            tags$li("[, 5]	 drat	 Rear axle ratio"),
            tags$li("[, 6]	 wt	 Weight (1000 lbs)"),
            tags$li("[, 7]	 qsec	 1/4 mile time"),
            tags$li("[, 8]	 vs	 V/S"),
            tags$li("[, 9]	 am	 Transmission (0 = automatic, 1 = manual)"),
            tags$li("[,10]	 gear	 Number of forward gears"),
            tags$li("[,11]	 carb	 Number of carburetors</ul>")
          )
        ),
        tabPanel("Correlations", 
                 h4("Correlation Matrix (All variables)"),
                 plotlyOutput("corrPlot"),
                 h4("Correlation Data Table"),
                 dataTableOutput("corrTable")
        ),
        tabPanel("Documentation", 
          h2("Instructions"),
          h3("Plot tab"),
          p("Objective: to show a smoonth line to understand the relation between two mtcars variables."),
          p("This tool allows you to explore the dataset mtcars, displaying two variables that can be selected and a third as the color of the scatterplot. In the graph that is shown on the right it is possible to see a line representing a linear regression of the variable Y as a function of the variable X. The method used in the regression can also be selected."),
          p("To use, select a mtcars dataset column or variable to show in the X axis and another to show in the Y axis."),
          p("The tool shows the correlation as a line."),
          p("The shaded band is a pointwise 95% confidence interval on the fitted values (the line). This confidence interval contains the true, population, regression line with 0.95 probability. Or, in other words, there is 95% confidence that the true regression line lies within the shaded region. It shows us the uncertainty inherent in our estimate of the true relationship between your response and the predictor variable."),
          p("You can select another variable from mtcars dataset as the color of the points and for faceting the data if you select the corresponding checkbox."),
          h3("Data tab"),
          p("If you want to view the mtcars data, select the \"Table\" tab."),
          h3("Correlations tab"),
          p("In this tab is possible to see the correlation coeficient between each variable combination as well as all the same data in table format"),
          h3("Documentation tab"),
          p("In the \"Documentation\" tab you can view these instructions.")
        )
      )
    )
  ),
  tags$script(' var setInitialCodePosition = function() { setCodePosition(false, false); }; setInitialCodePosition(); '),
  shinythemes::themeSelector()
))
