source("data_wrangling.R")

my_server <- function(input, output) {
  # Question 1 graph
  output$question_one <- renderPlot({
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
  
  # Question 2 graph
  output$message1 <- renderText({
    msg <- paste0("These graphs show the percentage share for production of ", 
                  input$element1, " and of ", 
                  input$element2, 
                  " from different states in USA.")
    msg
  })
  
  output$plot1 <- renderPlot({
    if(input$element1 == "Bio Fuel"){
      select_value1 <- "BioFuel"
    }else {
      select_value1 <- "Fuel_Ethanol"
    }
    show_pie <- select(correct_colnames_numeric, State, select_value1)
    colnames(show_pie) <- c("States", "Percentage")
    show_pie$Percentage <- show_pie$Percentage / sum(show_pie$Percentage) * 100
    other_sum <- sum(show_pie$Percentage)
    show_pie <- show_pie %>%
      filter(show_pie$Percentage >= input$slide_key)
    df <- data.frame("Others", other_sum - sum(show_pie$Percentage))
    names(df)<-c("States","Percentage")
    show_pie <- rbind(show_pie, df)
    
    pie = ggplot(show_pie, aes(x = "", y = Percentage, fill = States)) + 
      geom_bar(stat = "identity", width = 1)
    pie = pie + coord_polar("y", start = 0) 
    #if you want to change color, use this code below
    #pie = pie + scale_fill_manual(values = c("#e00808", "#33658A", "#2F4858", "#F6AE2D", "#F26419", "#55ADE0", "#999999", "#cb3cd8", "#cb3cd6"))
    pie = pie + geom_text(aes(label = paste0(round(show_pie$Percentage), "%")), position = position_stack(vjust = 0.5))
    pie
  })
  
  output$plot2 <- renderPlot({
    if(input$element2 == "Crude Oil"){
      select_value1 <- "Crude_Oil"
    }else {
      select_value1 <- "Natural_Gas"
    }
    show_pie <- select(correct_colnames_numeric, State, select_value1)
    colnames(show_pie) <- c("States", "Percentage")
    show_pie$Percentage <- show_pie$Percentage / sum(show_pie$Percentage) * 100
    other_sum <- sum(show_pie$Percentage)
    show_pie <- show_pie %>%
      filter(show_pie$Percentage >= input$slide_key)
    df <- data.frame("Others", other_sum - sum(show_pie$Percentage))
    names(df)<-c("States","Percentage")
    show_pie <- rbind(show_pie, df)
    
    pie = ggplot(show_pie, aes(x = "", y = Percentage, fill = States)) + 
      geom_bar(stat = "identity", width = 1)
    pie = pie + coord_polar("y", start = 0) 
    #if you want to change color, use this code below
    #pie = pie + scale_fill_manual(values = c("#e00808", "#33658A", "#2F4858", "#F6AE2D", "#F26419", "#55ADE0", "#999999", "#cb3cd8", "#cb3cd6"))
    pie = pie + geom_text(aes(label = paste0(round(show_pie$Percentage), "%")), position = position_stack(vjust = 0.5))
    pie
  })
  
  # Question 3 graph
  output$question_three <- renderPlot({
    ggplot(data = correct_colnames_numeric) +
      if (input$points_text_co2 == 1) {
        geom_label(mapping = aes_string(
          x = input$choice_x_co2, y = "CO2",
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
      input$choice_x_co2, "of twenty states in 2016 "
    )
  })
}