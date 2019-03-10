library("dplyr")
library("tidyr")

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

state_colname <- function (data) {
  colnames(data)[1] = "State"
  return(data)
}

co2 <- state_colname(co2)
biofuel <- state_colname(biofuel)
co2_per_capita <- state_colname(co2_per_capita)
crude_oil <- state_colname(crude_oil)
fuel_ethanol <- state_colname(fuel_ethanol)

co2 <- select(co2, State, X2016)
colnames(co2) <- c("State", "co2")

co2_per_capita <- select(co2_per_capita, State, X2016)
colnames(co2_per_capita) <- c("State", "co2_per_capita")

combined <- inner_join(biofuel, crude_oil, by = "State") %>%
  inner_join(., fuel_ethanol, by = "State") %>%
  inner_join(., natural_gas, by = "State") %>%
  inner_join(., co2_per_capita, by = "State") %>%
  inner_join(., co2, by = "State")


