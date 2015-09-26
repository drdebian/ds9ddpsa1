
# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
# 
# http://www.rstudio.com/shiny/
#

library(shiny)

shinyUI(fluidPage(
  
  # Application title
  titlePanel("Marketing campaign a/b test calculator"), 
  
  # Sidebar with a slider input for number of bins
  sidebarLayout(
    sidebarPanel(
      helpText(h5("Enter the parameters for the desired campaign testing scenario below:"))
      ,sliderInput("totsize" ,label = h4("Size of total campaign [a+b+c]")
                  ,min = 0
                  ,max = 10000
                  ,value = min(max(round(rnorm(1, mean = 5000, sd = 2500), -2), 500), 9500)
                  ,step = 100
                  )
      ,radioButtons("radiobsize", label = h4("Size of test group [b] (max)"),
                    choices = list("0 %" = 0, "50 %" = .5), 
                    selected = .5)
      ,radioButtons("radiocsize", label = h4("Size of control group [c] (max)"),
                    choices = list("0 %" = 0, "5 %" = .05, "10 %" = .1), 
                    selected = .1)
      ,radioButtons("radioci", label = h4("Confidence interval"),
                    choices = list("99 %" = 2.58, "95 %" = 1.96, "90 %" = 1.64), 
                    selected = 1.96)
      ,radioButtons("radioae", label = h4("Acceptable error"),
                    choices = list("1 %" = .01, "5 %" = .05, "10 %" = .1), 
                    selected = .05)
      
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
      #plotOutput("distPlot")
      helpText(h4("Using this small app you can calculate how to most effectively split up recipients 
                  of a marketing campaign for a/b testing while keeping a control group [c]."))
      ,plotOutput("piechart")
      ,helpText(h5("How to use these groups:
                   You send your proven marketing material to group [a]. If you want to test
                  something new, you send that test version to group [b]. If you want to verify
                  that your marketing material made a difference, don't send anything to control
                  group [c].
                   "))
      ,helpText("The formula being used is n >= N / (1 + (N-1)*e^2 / z^2*p*q)")
      
    )
  )
))
