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
      selectInput(inputId = "", 
                  label = strong(""),
                  choices = unique(),
                  selected = "")
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