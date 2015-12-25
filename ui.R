library(shiny)
library(networkD3)

shinyUI(fluidPage(
  # Application title
  titlePanel("Love, Actually Network"),

  sidebarLayout(
    sidebarPanel(
      sliderInput("scene",
                  "Up to scene:",
                  min = 1,
                  max = 57,
                  value = 56),
      shiny::HTML("For more on how this was created, see <a href='http://varianceexplained.org/r/love-actually-network/'>this blog post</a>, or the <a href='https://github.com/dgrtwo/love-actually-network'>code on GitHub</a>.")
    ),

    mainPanel(
      simpleNetworkOutput("networkPlot", width = 600, height = 400),
      plotOutput("timelinePlot", width = 600, height = 400)
    )
  )
))
