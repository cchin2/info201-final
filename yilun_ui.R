source("data_wrangling.R")

my_ui <- fluidPage(
  
  #shows the widgets
  sidebarLayout(
    sidebarPanel(
      selectInput(inputId = "choice_x", 
                  label = "X Variable",
                  choices = c("BioFuel", "Crude_Oil", "Fuel_Ethanol", "Natural_Gas"),
                  selected = "Crude_Oil")
    ),
    radioButtons(inputId = "points_text", label = "Would you like to view points or see state names?",
                 choices = list("States" = 1, "Points" = 2), 
                 selected = 1)
  ),
  
  #shows the result from the widgets in tabs
  mainPanel(
    
    plotOutput(outputId = "plot"),
    textOutput(outputId = "message")
    
  )
)