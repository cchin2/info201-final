source("data_wrangling.R")

# tab panels for definitions
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
  "Ethanol",
  p(strong("Defintion:"), "a renewable fuel that is commonly domestically produced or fermented from agricultural waste,
    grain or corn. Ethanol fuel is also produced in a chemical extraction from ethylene (via hydration). It is a type of bio fuel"),
  p(strong("Units:"), "thousand barrels")
)
page_four <- tabPanel(
  "Bio Fuel",
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

# tab panel with all defintions
definitions_tabs <- tabPanel(
  "Definitions",
  navbarPage(
    title = "Key Words",
    page_one,
    page_two,
    page_three,
    page_four,
    page_five,
    page_six,
    page_seven
  )
)

# tab panel for question one
question_one_tab <- tabPanel(
  "Energy vs Energy",
  p("We wanted to evaluate whether or not there was a correlation between states using certain energy types. 
    For example, we wanted to know if states made an equal amount of each energy type or made some more than others.
    The graph we made represents this correlation. As you can see, with crude oil and bio fuel, there is some correlation
    showing increasing amounts of crude oil also means increasing amounts of biofuel. However, the data show how states who 
    make larger amounts of bio fuel tend to make little crude oil. This could be do to some states choosing to use more 
    clean energy, or it could be due to the natural resources available. Texas is an outlier to both possible trends and 
    has a crude oil production rate of", max_crude_oil, "(in thousands of barrels)"),
  sidebarLayout(
    sidebarPanel(
      selectInput(
        inputId = "choice_x", label = "X Varaible",
        choices = c("Bio Fuel", "Crude Oil", "Ethanol", "Natural Gas"),
        selected = "Crude Oil"
      ),
      selectInput(
        inputId = "choice_y", label = "Y Variable",
        choices = c("Bio Fuel", "Crude Oil", "Ethanol", "Natural Gas"),
        selected = "Bio Fuel"
      ),
      radioButtons(
        inputId = "points_text", label = "Would you like to view points or see state names?",
        choices = list("States" = 1, "Points" = 2),
        selected = 1
      )
    ),
    mainPanel(
      h4(textOutput(outputId = "q1_title")),
      plotOutput(outputId = "question_one"),
      strong("Summary Statistics:"),
      textOutput(outputId = "message_one")
    )
  )
)

# tab panel for question two
question_two_tab <- tabPanel(
  "State Trends",
  p("We wanted to know if there was an unequal distribution in the production of certain fuel types, and to know 
    how the states compared to each other. These pie charts depict this for us.For example, we wanted to know which 
    state produce the most crude oil. The pie chart we made represents this finding. As you can see, the state that 
    produces the most nonrenewable fuel was Texas at 60%. It also shows that Texas, in comparison to other states,
    produced very little reneweable resources. The large amount of oil production is due to the large petroleum reserves
    present, but does not account for why they have no biofuel. They have of agricultural land, and thus could produce these 
    renewable resouces. It would be interesting to look into why they do not. It is also good to note that Texas is an outlier,
    and this can make the other results look smaller or harder to read in comparison."),
  sidebarLayout(
    sidebarPanel(
      selectInput(
        inputId = "element1",
        label = strong("Please select the renewable energy source from below"),
        choices = selectThis1
      ),
      selectInput(
        inputId = "element2",
        label = strong("Please select the non-renewable energy source from below"),
        choices = selectThis2
      ),
      sliderInput(
        inputId = "slide_key",
        label = "Please choose the percentage that you want to exclude from the pie chart",
        min = 0,
        max = 20,
        value = 4
      )
    ),
    mainPanel(
      h4(textOutput(outputId = "message1")),
      plotOutput("plot1"),
      plotOutput("plot2"),
      strong("Summary Statistics:"),
      textOutput(outputId = "message2"),
      textOutput(outputId = "message3")
    )
  )
)

# tab panel for question three
question_three_tab <- tabPanel(
  "Energy vs CO2",
  p("We wanted to know if there was a relationship between energy production and CO2 emmisions per capita. For example, we 
    were looking to see if more crude oil production led to higher CO2 emmission levels. We also used per capita data to account
    for differing population levels. Our analysis does not actually show this trend however, and none of the energies show much of a 
    correlation. There are many factors causing differing CO2 emmsions, so this could make it harder to see correlations. In this data set
    Texas and North Dakota are both outliers. Texas has a very large crude oil value of ", max_crude_oil, " (in thousands of barrels) and North
    Dakota has very large CO2 per capita value of ", max_CO2_Per_capita, " (in million metric tons)."),
  sidebarLayout(
    sidebarPanel(
      selectInput(
        inputId = "choice_x_co2",
        label = "X Variable",
        choices = c("Bio Fuel", "Crude Oil", "Ethanol", "Natural Gas"),
        selected = "Crude Oil"
      ),
      radioButtons(
        inputId = "points_text_co2", label = "Would you like to view points or see state names?",
        choices = list("States" = 1, "Points" = 2),
        selected = 1
      )
    ),
    mainPanel(
      h4(textOutput(outputId = "q3_title")),
      plotOutput(outputId = "question_three"),
      strong("Summary Statistics:"),
      textOutput(outputId = "message")
    )
  )
)

summary <- tabPanel(
  "Introduction",
  h3("Our Data"),
  p("Our project is focused on the different production levels of energy sources in the United States. 
    These are used for energy in everyday life such as the gas for transportation and heating systems. 
    Some of these energy sources include crude oil, natural gas, bio fuel, and ethanol. While these serve
    similar purposes, they are different in their impacts on the environment. There are two main factors
    that one should consider with these different options: cost and impact. For example, one key 
    difference is that crude oil releases a significant amount of carbon dioxide into the atmosphere. 
    Compared to natural gas, that is about 30% more carbon dioxide produced. The other is that crude oil 
    is considered cheaper than natural gas, giving reason to why most commercial cars are designed to use crude 
    oil. These two fuel options are better than burning coal but are still causes of significant air pollution and 
    are nonrenewable. We will also be examining renewable energy sources like biofuel and ethanol."),
  h3("Importance"),
  p("This domain is worth analyzing because we need to be aware of what kinds of impacts the fuel we choose to 
    use have on the environment. The issues of air pollution do not become something that is at the forefront of 
    everyone's minds since there are not clear incremental changes throughout our lives. For example, Washington's 
    emission check is discontinued in 2020 because people believe that we can maintain our clean air through 
    technology advancements for fuel-efficient cars. However, this shouldn't be the blanket solution to air 
    pollution as our focus must be on how much we are producing and whether we are making a conscious effort to 
    adapt to cleaner fuel.")
)

references <- tabPanel(
  "References",
  h3("Our Data"),
  p(
    "Our data was collected from the U.S. Energy Information Administration. We used their report of `Energy-Related
    Carbon Dioxide Emissions by State, 2005-2016` in order to find different data on various energy sources. You can find all the data",
    a("here", href = "https://www.eia.gov/environment/emissions/state/analysis/")
  ),
  p(
    "We also used their data set of `State Energy Data System (SEDS): 1960-2016 (complete)`. We only used 2016 data however.
    You can find the data",
    a("here", href = "https://www.eia.gov/state/seds/seds-data-complete.php?sid=US#Production")
  )
)

my_ui <- fluidPage(
  titlePanel("Energy Sources and CO2 in the United States"),
  h5("By Cameron Chin, Yilun Sun, and Chaichinda Siritantitam"),
  navbarPage(
    "Our Features",
    summary,
    definitions_tabs,
    question_one_tab,
    question_two_tab,
    question_three_tab,
    references
  )
)
