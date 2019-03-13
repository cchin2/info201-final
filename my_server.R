source("data_wrangling.R")

my_server <- function(input, output) {
  # Question 1 graph
  output$question_one <- renderPlot({
    x <- find_x_or_y(input$choice_x)
    y <- find_x_or_y(input$choice_y)
    ggplot(data = correct_colnames_numeric) +
      if (input$points_text == 1) {
        geom_label(mapping = aes_string(
          x = x, y = y,
          label = "correct_colnames_numeric$State"
        ))
      } else {
        geom_point(mapping = aes_string(
          x = x, y = y
        ))
      }
  })
  
  output$q1_title <- renderText({
    msg <- paste0("This Graph Shows ", input$choice_x, " vs ", input$choice_y)
    msg
  })
  
  output$message_one <- renderText({
    biof <- ""
    crdo <- ""
    ng <- ""
    fe <- ""
      if (input$choice_x == "Bio Fuel" | input$choice_y == "Bio Fuel") {
          biof <- paste("The average amount of biofuel
          for twenty states is", avg_bio_fuel, "trillion btu.", "The maximum amount is",
          max_bio_fuel, "trillion btu.", "The minimum amount is", min_bio_fuel, "trillion btu.")
      }
      if (input$choice_x == "Crude Oil" | input$choice_y == "Crude Oil") {
          crdo <- paste("The average amount of crude oil
          for twenty states is", avg_crude_oil, "(in thousands of barrels).", "The maximum amount is",
          max_crude_oil, "(in thousands of barrels).", "The minimum amount is", min_crude_oil, "(in thousands of barrels).")
      }
      if (input$choice_x == "Ethanol" | input$choice_y == "Ethanol") {
        fe <- paste(
          "The average amount of fuel ethanol
          for twenty states is", avg_fuel_ethanol, "(in thousands of barrels).", "The maximum amount is",
          max_fuel_ethanol, "(in thousands of barrels).", "The minimum amount is", min_fuel_ethanol, "(in thousands of barrels).")
      }
      if (input$choice_x == "Natural Gas" | input$choice_y == "Natural Gas") {
        ng <- paste(
          "The average amount of natural gas
          for twenty states is", avg_natural_gas, "millions of cubic feet.", "The maximum amount is",
          max_natural_gas, "millions of cubic feet.", "The minimum amount is", min_natural_gas, "millions of cubic feet.")
      }
    complete_msg <- paste(biof, crdo, ng, fe)
    complete_msg
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
    pie = pie + geom_text(aes(label = paste0(round(show_pie$Percentage), "%")), position = position_stack(vjust = 0.5))
    pie
  })
  
  
  
  # Question 3 graph
  output$question_three <- renderPlot({
    x <- find_x_or_y(input$choice_x_co2)
    ggplot(data = correct_colnames_numeric) +
      if (input$points_text_co2 == 1) {
        geom_label(mapping = aes_string(
          x = x, y = "CO2_Per_Capita",
          label = "correct_colnames_numeric$State"
        )) 
      } else {
        geom_point(mapping = aes_string(
          x = x, y = "CO2_Per_Capita"
        )) 
      }
  })
  
  output$q3_title <- renderText({
    msg <- paste0("This Graph Shows ", input$choice_x_co2, " vs CO2 (per capita)")
    msg
  })
  
  output$message <- renderText({
    if(input$choice_x_co2 == "Bio Fuel") {
      message <- paste(
        "The plot shows the relationship between CO2 emission and ",
        input$choice_x_co2, "of twenty states in 2016.", "The average amount of biofuel
        for twenty states is", avg_bio_fuel, "trillion btu.", "The maximum amount is",
        max_bio_fuel, "trillion btu.", "The minimum amount is", min_bio_fuel, "trillion btu.",
        "The average amount of CO2 emission is", avg_CO2, "million metric tons.", "The maximum amount is",
        max_CO2, "million metric tons.", "The minimum amount is", min_CO2, "million metric tons."
      )}
    else if(input$choice_x_co2 == "Crude Oil"){
      message <- paste(
        "The plot shows the relationship between CO2 emission and ",
        input$choice_x_co2, "of twenty states in 2016.", "The average amount of crude oil
        for twenty states is", avg_crude_oil, "(in thousands of barrels).", "The maximum amount is",
        max_crude_oil, "(in thousands of barrels).", "The minimum amount is", min_crude_oil, "(in thousands of barrels).",
        "The average amount of CO2 emission is", avg_CO2, "million metric tons.", "The maximum amount is",
        max_CO2, "million metric tons.", "The minimum amount is", min_CO2, "million metric tons."
      )
    }
    else if(input$choice_x_co2 == "Ethanol"){
      message <- paste(
        "The plot shows the relationship between CO2 emission and ",
        input$choice_x_co2, "of twenty states in 2016.", "The average amount of fuel ethanol
        for twenty states is", avg_fuel_ethanol, "(in thousands of barrels).", "The maximum amount is",
        max_fuel_ethanol, "(in thousands of barrels).", "The minimum amount is", min_fuel_ethanol, "(in thousands of barrels).",
        "The average amount of CO2 emission is", avg_CO2, "million metric tons.", "The maximum amount is",
        max_CO2, "million metric tons.", "The minimum amount is", min_CO2, "million metric tons."
      )
    }
    else {
      message <- paste(
        "The plot shows the relationship between CO2 emission and ",
        input$choice_x_co2, "of twenty states in 2016.", "The average amount of natural gas
        for twenty states is", avg_natural_gas, "millions of cubic feet.", "The maximum amount is",
        max_natural_gas, "millions of cubic feet.", "The minimum amount is", min_natural_gas, "millions of cubic feet.",
        "The average amount of CO2 emission is", avg_CO2, "million metric tons.", "The maximum amount is",
        max_CO2, "million metric tons.", "The minimum amount is", min_CO2, "million metric tons."
      )
    }
  })
}
