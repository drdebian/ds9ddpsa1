
# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
# 
# http://www.rstudio.com/shiny/
#

library(shiny)

shinyServer(function(input, output) {
  
  calcn <- function(n, e, z, p, q) {
    n / (1+((n-1)*e**2)/(z**2*p*q))
  }
  
  calcc <- function(n, e, z, p, q, cprc) {
    csize1 <- round(n * cprc, 0)
    csize2 <- calcn(n, e, z, .5, .5)
    csize <- round(min(csize1, csize2), 0)
    csize
  }
  
  calcb <- function(n, e, z, p, q, bprc, c) {
    bsize1 <- round((n-c)*bprc)
    bsize2 <- calcn(n-c, e, z, .5, .5)
    bsize <- round(min(bsize1, bsize2), 0)
    bsize
  }
  
  calca <- function(n, c, b) {
    asize <- n - c - b
    asize
  }

 
    
  output$piechart <- renderPlot({
    my.n <- max(1, as.integer(input$totsize))
    my.percc <- as.numeric(input$radiocsize)
    my.percb <- as.numeric(input$radiobsize)
    my.ae <- as.numeric(input$radioae)
    my.ci <- as.numeric(input$radioci)
    
    csize <- calcc(my.n, my.ae, my.ci, .5, .5, my.percc)
    bsize <- calcb(my.n, my.ae, my.ci, .5, .5, my.percb, csize)
    asize <- calca(my.n, csize, bsize)

    slices <- c(asize, bsize, csize)
    lbls <- c("a: ", "b: ", "c: ")
    pct <- round(slices/sum(slices)*100)
    lbls <- paste0(lbls, slices, " (", pct, "%)")
    pie(slices, labels = lbls)
  })
  

  
})
