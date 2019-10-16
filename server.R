library(shiny)

shinyServer(function(input, output) {
   
 mtcars$mpg_Plot <- ifelse(mtcars$mpg-20>0, mtcars$mpg-20,0)
 mod_1 <- lm(hp~mpg, data = mtcars)
 mod_2 <- lm(hp~mpg_Plot+mpg, data = mtcars)
 
 pred_mod_1 <-reactive({
   mpg_in <- input$slider_miles
   predict(mod_1, newdata = data.frame(mpg = mpg_in))
 })
    
 pred_mod_2 <- reactive({
   mpg_in <- input$slider_miles
   predict(mod_2, newdata =
             data.frame(mpg = mpg_in,
                        mpg_Plot =ifelse(mpg_in-20>0,
                                         mpg_in-20,0)))
 })
  output$mile_Plot <- renderPlot({
    mpg_in<-input$slider_miles
    
    plot(mtcars$mpg, mtcars$hp, xlab = "MILES PER GALLON",
         ylab = "HORSEPOWER", bty = "n", pch = 16,
         xlim = c(10,35), ylim = c(50,350))
    if(input$show_model1){
      abline(mod_1, col = "purple", lwd = 2)
    }
    if(input$show_model2){
      line_mod_2 <- predict(mod_2, newdata= data.frame(
        mpg = 10:35, mpg_Plot = ifelse(10:35-20>0, 10:35-20, 0)
      ))
      lines(10:35, line_mod_2, col = "yellow", lwd= 2)
    }
    legend(25,250, c("Prediction with Model 1", "Prediction with Model 2"), pch = 16,
           col = c("purple","yellow"), bty = "n", cex = 1.2)
    points(mpg_in, pred_mod_1(), col = "purple", pch = 16, cex = 2)
    points(mpg_in, pred_mod_2(), col = "yellow", pch = 16, cex = 2)
  })
  output$Pred_model1 <- renderText({
    pred_mod_1()
  })
  output$Pred_model2 <- renderText({
    pred_mod_2()
  })
})
