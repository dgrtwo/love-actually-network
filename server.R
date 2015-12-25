library(shiny)
library(ggplot2)
library(networkD3)
library(dplyr)
library(reshape2)

load("love_actually_data.rda")

mult <- speaker_scene_matrix[, colSums(speaker_scene_matrix) > 1]

# pre-generate cooccurrence data
cooccurences <- lapply(seq_len(ncol(mult)), function(i) {
  # use as.matrix to handle case where i == 1
  mat <- as.matrix(mult[, seq_len(i)])
  mat <- as.matrix(mat[rowSums(mat) > 0, ])
  co <- mat %*% t(mat)
  melt(co, varnames = c("Source", "Target"), value.name = "scenes") %>%
    filter(scenes > 0)
})

timeline <- ggplot(scenes, aes(scene, character)) +
  geom_point() +
  geom_path(aes(group = scene)) +
  theme_bw()

shinyServer(function(input, output) {
  output$timelinePlot <- renderPlot({
    timeline +
      geom_vline(xintercept = input$scene, color = "red", lty = 2)
  })
  
  output$networkPlot <- renderSimpleNetwork({
    simpleNetwork(cooccurences[[input$scene]])
  })

})
