source("data_wrangling.R")

my_server <- function(input, output) {
  # Question 1 table
  output$table2 <- renderPlot({
    ggplot(data = correct_colnames_numeric) +
      geom_label(mapping = aes_string(
        x = input$choice_x, y = input$choice_y,
        label = "correct_colnames_numeric$State"
      ))
  })
}
