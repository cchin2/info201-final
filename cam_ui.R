source("data_wrangling.R")

page_one <- tabPanel(
  "Crude Oil",
  p(strong("Defintion:"), "most common form of fossil fuel made of a mixture of hydrocarbons, found in underground reservoirs."),
  p(strong("Units:"), "thousands of barrels ")
  
)

page_two <- tabPanel(
  "Natural Gas",
  p(strong("Defintion:"), "naturally occurring gas made of primarily of methane and other hydrocarbons, found in natural gas 
     deposits made from hydrocarbons being heated/pressurized into gas."),
  p(strong("Units:"), "millions of cubic feet")
  
)

page_three <- tabPanel(
  "Fuel Ethanol",
  p(strong("Defintion:"), "a renewable fuel that is commonly domestically produced or fermented from agricultural waste,
    grain or corn. Ethanol fuel is also produced in a chemical extraction from ethylene (via hydration)."),
  p(strong("Units:"), "thousand barrels")
  
)

page_four <- tabPanel(
  "Biofuel",
  p(strong("Defintion:"), "a renewable fuel that is produced through contemporary biological processes, such as agriculture and anaerobic 
    digestion"),
  p(strong("Units:"), "trillion btu")
  
)

page_five <- tabPanel(
  "CO2",
  p(strong("Defintion:"), "a colorless gas made with one carbon atom and two oxygen atoms."),
  p(strong("Units:"), "million metric tons"),
  p(strong("CO2 per capita:"), "metric tons of carbon dioxide per person.")
)

page_six <- tabPanel(
  "Renewable",
  p(strong("Renewable"), "energy is generally defined as energy that is collected from resources which are naturally replenished on a human timescale,
    such as sunlight, wind, rain, tides, waves, and geothermal heat.")
)

page_seven <- tabPanel(
  "Nonrenewable",
  p("A ", strong("non-renewable"), " resource (also called a finite resource) is a resource that does not renew itself at a sufficient rate for sustainable
    economic extraction in meaningful human time-frames. ")
)

my_ui <- fluidPage(
  titlePanel("Energy Sources and CO2 in the United States"),
  h5(strong("Our project is focused on the different production levels of energy sources in the United States. 
            These are used for energy in everyday life such as the gas for transportation and heating systems. 
            Some of these energy sources include crude oil, natural gas, biofuel, and ethanol. While these serve
            similar purposes, they are different in their impacts on the environment. There are two main factors
            that one should consider with these different options: cost and impact. For example, one key 
            difference is that crude oil releases a significant amount of carbon dioxide into the atmosphere. 
            Compared to natural gas, that is about 30% more carbon dioxide produced. The other is that crude oil 
            is considered cheaper than natural gas, giving reason to why most commercial cars are designed to use crude 
            oil. These two fuel options are better than burning coal but are still causes of significant air pollution and 
            are nonrenewable. We will also be examining renewable energy sources like biofuel and ethanol.  ")),
  navbarPage(
    "Definitions",
    page_one,
    page_two,
    page_three,
    page_four,
    page_five,
    page_six,
    page_seven
  ),
  sidebarLayout(
    sidebarPanel(
      selectInput(
        inputId = "choice_x", label = "X Varaible",
        choices = c("BioFuel", "Crude_Oil", "Fuel_Ethanol", "Natural_Gas"),
        selected = "Crude_Oil"
      ),
      selectInput(
        inputId = "choice_y", label = "Y Variable",
        choices = c("BioFuel", "Crude_Oil", "Fuel_Ethanol", "Natural_Gas"),
        selected = "BioFuel"
      ),
      radioButtons(inputId = "points_text", label = "Would you like to view points or see state names?",
         choices = list("States" = 1, "Points" = 2), 
         selected = 1)
    ),
    mainPanel(
      plotOutput(outputId = "table2")
    )
  )
)