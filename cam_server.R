source("data_wrangling.R")

my_server <- function(input, output) {
  # Question 1 table
  output$table2 <- renderPlot({
    ggplot(data = correct_colnames_numeric) +
      if (input$points_text == 1) {
        geom_label(mapping = aes_string(
          x = input$choice_x, y = input$choice_y,
          label = "correct_colnames_numeric$State"
        ))
      } else {
        geom_point(mapping = aes_string(
          x = input$choice_x, y = input$choice_y
        ))
      }
  })
}