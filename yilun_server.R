source("data_wrangling.R")

my_server <- function(input, output) {
  
  output$plot <- renderPlot({
    ggplot(data = correct_colnames_numeric) +
      if (input$points_text == 1) {
        geom_label(mapping = aes_string(
          x = input$choice_x, y = "CO2",
          label = "correct_colnames_numeric$State"
        ))
      } else {
        geom_point(mapping = aes_string(
          x = input$choice_x, y = "CO2"
        ))
      }
  })
  
  output$message <- renderText({
    message <- paste(
      "The plot shows the relationship between CO2 emission and ",
      input$choice_x, "of twenty states in 2016 "
    )
  })
}
