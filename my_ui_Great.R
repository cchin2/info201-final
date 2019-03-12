library("dplyr")
library("ggplot2")
library("tidyr")
library("maps")

source("data_wrangling.R")

selectThis1 <- c("Bio Fuel", "Ethanol")
selectThis2 <- c("Crude Oil", "Natural Gas")

my_ui <- fluidPage(
  titlePanel("abc"),
  h4(strong("abc")),
  
  #shows the widgets
  sidebarLayout(
    sidebarPanel(
      selectInput(inputId = "element1", 
                  label = strong("Please select the renewable energy source from below"),
                  choices = selectThis1
                  
      ),
      selectInput(inputId = "element2", 
                  label = strong("Please select the non-renewable energy source from below"),
                  choices = selectThis2
                  
      ),
      sliderInput(inputId = "slide_key", 
                  label = "Please choose the percentage that you want to exclude from the pie chart",            
                  min = 0, 
                  max = 20, 
                  value = 4 
      )
    ),
    
    
    #shows the result from the widgets in tabs
    mainPanel(
      tabsetPanel(
        id = 'dataset',
        tabPanel("Page 1", 
                 textOutput(outputId = "message1"),
                 plotOutput("plot1"), 
                 plotOutput("plot2")
                )
      )
    )
  )
)#my ui

my_server <- function(input, output) {
  
  output$message1 <- renderText({
    msg <- paste0("These graphs show the percentage share for production of ", 
                         input$element1, " and of ", 
                         input$element2, 
                         " from different states in USA.")
    msg
  })
  
  output$plot1 <- renderPlot({
    if(input$element1 == "Bio Fuel"){
      select_value1 <- "biofuel..trillion.btu."
    }else {
      select_value1 <- "fuel_ethanol..thousand."
    }
    show_pie <- select(combined, State, select_value1)
    colnames(show_pie) <- c("States", "Percentage")
    show_pie$Percentage <- as.numeric(gsub(",", "", show_pie$Percentage))
    show_pie$Percentage <- as.numeric(show_pie$Percentage)
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
    if(input$element1 == "Crude Oil"){
      select_value1 <- "crude_oil..thousand.barrels."
    }else {
      select_value1 <- "natural_gas..million.cubic.feet."
    }
    show_pie <- select(combined, State, select_value1)
    colnames(show_pie) <- c("States", "Percentage")
    show_pie$Percentage <- as.numeric(gsub(",", "", show_pie$Percentage))
    show_pie$Percentage <- as.numeric(show_pie$Percentage)
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
}


