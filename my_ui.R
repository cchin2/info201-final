source("data_wrangling.R")


my_ui <- fluidPage(
  titlePanel(""),
  h4(strong("")),
  
  #shows the widgets
  sidebarLayout(
    sidebarPanel(
      sliderInput(inputId = "slide_key", 
                  label = "",            
                  min = , 
                  max = , 
                  value =  
      ),
      selectInput(inputId = "state", 
                  label = strong("Please select the state from below"),
                  choices = unique(combined$State),
                  selected = "Arizona")
    ),
    
    #shows the result from the widgets in tabs
    mainPanel(
      tabsetPanel(
        id = 'dataset',
        tabPanel("Page 1", dataTableOutput("table"), textOutput(outputId = "message1")),
        tabPanel("Page 2", plotOutput("plot"), textOutput(outputId = "message2")) 
      )
    )
  )
)

