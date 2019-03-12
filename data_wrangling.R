library("dplyr")
library("tidyr")
library("shiny")

### references ###
# https://www.eia.gov/environment/emissions/state/analysis/
# https://www.eia.gov/state/seds/seds-data-complete.php?sid=US#Production

biofuel <- read.csv("data/biofuel.csv", stringsAsFactors = FALSE)
co2 <- read.csv("data/co2.csv", stringsAsFactors = FALSE)
co2_per_capita <- read.csv("data/co2_per_capita.csv", stringsAsFactors = FALSE)
crude_oil <- read.csv("data/crude_oil.csv", stringsAsFactors = FALSE)
fuel_ethanol <- read.csv("data/fuel_ethanol.csv", stringsAsFactors = FALSE)
natural_gas <- read.csv("data/natural_gas.csv", stringsAsFactors = FALSE)

# data wrangling
# select only 2016 values
co2 <- select(co2, ï..State, X2016)
colnames(co2) <- c("ï..State", "co2")

co2_per_capita <- select(co2_per_capita, ï..State, X2016)
colnames(co2_per_capita) <- c("ï..State", "co2_per_capita")

combined <- inner_join(biofuel, crude_oil, by = "ï..State") %>%
  inner_join(., fuel_ethanol, by = "ï..State") %>%
  inner_join(., natural_gas, by = c("ï..State" = "State")) %>%
  inner_join(., co2_per_capita, by = "ï..State") %>%
  inner_join(., co2, by = "ï..State")

colnames(combined)[1] <- "State"

View(combined)
combined$biofuel..trillion.btu. <- as.numeric(combined$biofuel..trillion.btu.)
combined$natural_gas..million.cubic.feet. <- as.numeric(gsub(",", "", combined$natural_gas..million.cubic.feet.))
combined$crude_oil..thousand.barrels. <- as.numeric(gsub(",", "", combined$crude_oil..thousand.barrels.))
combined$fuel_ethanol..thousand. <- as.numeric(gsub(",", "", combined$fuel_ethanol..thousand.))
combined$co2 <- as.numeric(gsub(",", "", combined$co2))

feature <- colnames(combined)[2:5]

my_ui <- fluidPage(
  
  #shows the widgets
  sidebarLayout(
    sidebarPanel(
      selectInput(inputId = "feature", 
                  label = "Energy Used",
                  choices = feature,
                  selected = feature[1])
    ),
     
    #shows the result from the widgets in tabs
    mainPanel(
      
      plotOutput(outputId = "plot")
      
      
    )
  )
)


my_server <- function(input, output) {
  
  output$plot <- renderPlot({
    ggplot(data = combined) + 
      geom_text(mapping = aes(
        x = combined$biofuel..trillion.btu.,
        y = combined$co2,
        label = combined$State
      )) +
      geom_point(mapping = aes(
        x = combined$biofuel..trillion.btu.,
        y = combined$co2
      )) +
      geom_line(mapping = aes(
        x = combined$biofuel..trillion.btu.,
        y = combined$co2
      ))
    
  })
}

shinyApp(ui = my_ui, server = my_server)
