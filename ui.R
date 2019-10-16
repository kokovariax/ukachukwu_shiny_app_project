library(shiny)

shinyUI(fluidPage(
  
  # Application title
  titlePanel("Horsepowerof vehicles  using miles per gallon rating"),
  
  sidebarLayout(
    sidebarPanel(
       sliderInput("slider_miles","what is the mile per gallon rating of the car",10,35,value = 20),
       checkboxInput("show_model1", "CHECK TO SHOW MODEL 1", value = TRUE),
       checkboxInput("show_model2", "CHECK TO SHOW MODEL 2", value = TRUE)
    ),
    # Show a plot of the generated distribution
    mainPanel(
       plotOutput("mile_Plot"),
       h3("Predicted Horsepower from MilePerGallon rating using Model1"),
       textOutput("Pred_model1"),
       h3("Predicted Horsepower from MilePerGallon rating using Model2"),
       textOutput("Pred_model2")
    )
  )
))
