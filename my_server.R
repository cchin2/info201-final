source("data_wrangling.R")

my_server <- function(input, output) {
  
  output$message1 <- renderText({
    msg <- **
    msg
  })
  
  output$message2 <- renderText({
    msg <- **
    msg
  })
  
  #create the table
  output$table <- renderDataTable({
    df <- **
    df
  })
  
  #create the plot
  output$plot <- renderPlot({
    show_map <- **
      
    ggplot(data = show_map) +
      geom_polygon(mapping = aes(x = long, y = lat, group = group, fill = amount_of_forest_area)) +
      scale_color_brewer(type = 'div', palette = 2) +
      coord_quickmap() 
  })
}