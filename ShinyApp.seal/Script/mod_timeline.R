# Spooky Shiny app!
# SB R-Ladies 2021-05-14
# Prepared by Megan Feddern

library(tidyverse)
library(shiny)
library(shinythemes)
library(timevis)
library(PNWColors)

Seal.pop <- read_csv("Data/seal.tot.csv")
col <- c('#24492e','#24492e', '#015b58', '#2c6184', '#59629b', '#89689d', '#ba7999', '#e69b99')



id<- c("The Marine Mammal Protection Act was passed in 1972. This legislation prohibited take of marine mammals, 
       including harbor seals except under certain circumstances. This greatly reduced hunting of harbor seals 
       in coastal Washington and the Salish Sea",
       
       "Hatchery production of Chinook salmon occurred in Washington to increase fisheries opportunities and conserve
       delining natural populations. While hatchery Chinook salmon are still released, it has declined in total number
       of fish released and biomass released in Washington since 1995",
       
       "Herring, an important prey species for Washington harbor seals, have been declining in Puget Sound since surveys 
       began for them in 1970s. Little is known about the cause, although changes in the environment and contaminants may 
       play a role",
       
       "The Pacific Decadal Oscillation is a climate pattern in the northeast Pacific associated with sea surface temperature,
       sea level pressure and wind. Warm-phase or positive years, are associated with decreased salmon prodution in Washington",
       
      "The Pacific Decadal Oscillation is a climate pattern in the northeast Pacific associated with sea surface temperature,
       sea level pressure and wind. Cool-phase or negative years, are associated with increased salmon prodution in Washington",
      
        "The Pacific Decadal Oscillation is a climate pattern in the northeast Pacific associated with sea surface temperature,
       sea level pressure and wind. Warm-phase or positive years, are associated with decreased salmon prodution in Washington.
      Since the 1990s it has not been exclusively warm or cool."
        
        
        
)
#ids<-seq(1,7)
data <- data.frame(
  id      = id,
  content = c("Marine Mammal Protection Act", 
              "Peak Hatchery Production of Chinook salmon",
              "Puget Sound Herring Depletion", 
              "Positive Pacific Decadal Oscillation",
              "Negative Pacific Decadal Oscillation", 
              "Positive Pacific Decadal Oscillation"
              ),
  
  start   = c(
              "1972-01-10", 
              "1975-01-11",
              "1995-01-11",
              "1925-01-11",
              "1947-01-11",
              "1977-01-11"
              ),
  
  end     = c(
              NA,
              "1995-02-04", 
              "2020-02-04",
              "1947-01-11",
              "1977-01-11",
              "2000-01-11"
              ),
 group    = c(
              3,
              2, 
              2,
              1,
              1,
              1
              ),
 type    = c(
             NA,
             "range",
             "range",
             "range",
             "range",
             "range"
             ),
style    = c(
             "font-family: verdana; background-color: #24492e; color: white; font-size: 15px;",
             "font-family: verdana; background-color: #015b58; color: white; font-size: 15px;",
             "font-family: verdana; background-color: #015b58; color: white; font-size: 15px;",
             "font-family: verdana; background-color: #ba7999; color: white; font-size: 15px;",
             "font-family: verdana; background-color: #2c6184; color: white; font-size: 15px;",
             "font-family: verdana; background-color: #ba7999; color: white; font-size: 15px;")
)
groups    = data.frame(id = 1:3,
                       content=c("Environment", "Food Web", "Legislation")) 





shinyApp(
  ui = fluidPage(
    timevisOutput("timeline"),
    textOutput("selected"),
    verbatimTextOutput("text")
  ),
  server = function(input, output, summ) {
    output$timeline <- renderTimevis({
      timevis(data, zoomFactor = 0.25, groups, showZoom=FALSE, fit=TRUE)
    })
    output$selected <- renderText({
      input$timeline_selected
    })
  }
)


