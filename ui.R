# Carbon Dioxide measurements at Mauna Loa, Hawaii
# Project assignment for Developing Data Products, Coursera
# January, 2015
# Data sources:
#   Scripps Inst. of Oceanography, U. of California
#   

# Input data description:
# Time series of carbon dioixide in ppm from 1959 to 1997
# 468 monthly observations

require(ggplot2)

shinyUI(navbarPage( strong("Carbon Dioxide Data Predictions"),
                    
  tabPanel(strong("Data"),
    sidebarLayout(
      sidebarPanel( width = 3,
        h4(htmlOutput("text1")),
        br(),
        sliderInput("firstYear", strong("First Year for Model"),
                    1959, 1994, 1959,
          step = 1, round = FALSE, format = "0",
          locale = "us", ticks = TRUE, animate = FALSE, width = NULL),
        numericInput(inputId = "yearsPred",
            label = strong("Years to Predict"), value = 10),
        numericInput(inputId = "refLev",
            label = strong("Reference Level Line"), value = 350),
        numericInput(inputId = "refYear",
            label = strong("Reference Year Line"), value = 1995),
        br(),
        h4(htmlOutput("text2"))
      ), # end sidebarPanel

      mainPanel(
       plotOutput("plot1", height = 400),
       plotOutput("plot2", height = 320)
      )  # end mainPanel
    ) # end sidebarLayout
  ), # end Data tabPanel
  
  tabPanel(strong("Documentation"),
      h4(htmlOutput("doc1"))
  ) # end Data tabPanel
) # end navbarPage
) # end shinyUI
