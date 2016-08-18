###############################################################
#                                                             #
#                   Jesus Garcia-Mancilla                     #
#                (2015) - jegama70@gmail.com                  #
#                                                             #
###############################################################

library(shiny)
library(dplyr)
library(ggplot2)
library(reshape2)

shinyUI(fluidPage(    
  
  titlePanel("Crowd computed categorization"),
  
  plotOutput("plot", width = "100%", height = "200px"),
  
  hr(),
  
  fluidRow(
    column(3,
           h4("Create a plot with the information from the DataSet"),
           selectInput("tweet", 
                       label = "Choose a tweet",
                       choices = c(1:500),
                       selected = 1)
    ),
    column(9,
           h4("List of tweets"),
           dataTableOutput(outputId="table"))
  )
  
))