install.packages("shiny")
library(shiny)
library(tree)

ui <- fluidPage("Hello World")

server <- function(input,output){}

shinyApp(
  ui = ui,
  server = server
)

ui <- fluidPage(
  titlePanel("Input and Output"),
  sidebarLayout(
    sidebarPanel(
      sliderInput(
        inputId = "num",
        label = "Choose a Number",
        min = 0,
        max = 100,
        value = 25
      )
    ),
    mainPanel(
      textOutput(
        outputId = "text"
      )
    )
  )
)

server <- function(input, output) {
  output$text <- renderText({
    paste0("You selected ", input$num)
  })
}

shinyApp(
  ui = ui,
  server = server
)

load("Tree.RData")
library(RColorBrewer)

palette <- brewer.pal(3, "Set2")

ui <- fluidPage(
  titlePanel("Iris Species Predictor"),
  sidebarLayout(
    sidebarPanel(
      sliderInput(
        inputId = "pedal.length",
        label = "Petal Length (cm)",
        min = 1,
        max = 7,
        value = 4
      ),
      sliderInput(
        inputId = "petal.width",
        label = "Petal Width (cm)",
        min = 0.0,
        max = 2.5,
        step = 0.5,
        value = 1.5
      )
    ),
    mainPanel(
      textOutput(
        outputId = "text"
      ),
      plotOutput(
        outputId = "plot"
      )
    )
  )
)

server <- function(input, output) {
  output$text = renderText({
    
    predictors <- data.frame(
      Petal.Length = input$petal.length,
      Petal.Width = input$petal.width,
      Sepal.Length = 0,
      Sepal.Width = 0
    )
    
    prediction = predict(
      object = model,
      newdata = predictors,
      type = "class"
    )
    
    paste(
      "The predicted species is ",
      as.character(prediction)
    )
  })
  
  output$plot = renderPlot({
    plot(
      x = iris$Petal.Length,
      y = iris$Petal.Width,
      pch = 19,
      col = palette[as.numeric(iris$Species)],
      main = "Iris Petal Length vs. Width",
      xlab = "Petal Length (cm)",
      ylab = "Petal Width (cm)"
    )
    
 
    
    points (
      x = input$petal.length,
      y = input$petal.width,
      col = "red",
      pch = 4,
      cex = 2,
      lwd = 2
    )
  })
}

shinyApp(
  ui = ui,
  server = server
)
