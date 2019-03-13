library("dplyr")
library("tidyr")
library("ggplot2")
library("maps")

biofuel <- read.csv("data/biofuel.csv", stringsAsFactors = FALSE)
co2 <- read.csv("data/co2.csv", stringsAsFactors = FALSE)
co2_per_capita <- read.csv("data/co2_per_capita.csv", stringsAsFactors = FALSE)
crude_oil <- read.csv("data/crude_oil.csv", stringsAsFactors = FALSE)
fuel_ethanol <- read.csv("data/fuel_ethanol.csv", stringsAsFactors = FALSE)
natural_gas <- read.csv("data/natural_gas.csv", stringsAsFactors = FALSE)

# takes in the data and changes the first column name to "State" and 
# returns the data
state_colname <- function (data) {
  colnames(data)[1] = "State"
  return(data)
}

# Makes all the data have uniform "State" col names
co2 <- state_colname(co2)
biofuel <- state_colname(biofuel)
co2_per_capita <- state_colname(co2_per_capita)
crude_oil <- state_colname(crude_oil)
fuel_ethanol <- state_colname(fuel_ethanol)

# Select only 2016 values for co2 and co2 per capita
co2 <- select(co2, State, X2016)
colnames(co2) <- c("State", "co2")
co2_per_capita <- select(co2_per_capita, State, X2016)
colnames(co2_per_capita) <- c("State", "co2_per_capita")

# combine all of the csv files by "State" where they all have matching values
combined <- inner_join(biofuel, crude_oil, by = "State") %>%
  inner_join(., fuel_ethanol, by = "State") %>%
  inner_join(., natural_gas, by = "State") %>%
  inner_join(., co2_per_capita, by = "State") %>%
  inner_join(., co2, by = "State")

# remove all of the commas in the data and change the values to be numeric
correct_colnames_numeric <- combined
colnames(correct_colnames_numeric) <- c("State", "BioFuel", "Crude_Oil", "Fuel_Ethanol", "Natural_Gas", "CO2_Per_Capita", "CO2")
correct_colnames_numeric$Crude_Oil <- gsub(",", "", correct_colnames_numeric$Crude_Oil)
correct_colnames_numeric$Crude_Oil<- as.numeric(correct_colnames_numeric$Crude_Oil)
correct_colnames_numeric$BioFuel <- as.numeric(correct_colnames_numeric$BioFuel)
correct_colnames_numeric$Fuel_Ethanol <- gsub(",", "", correct_colnames_numeric$Fuel_Ethanol)
correct_colnames_numeric$Fuel_Ethanol <- as.numeric(correct_colnames_numeric$Fuel_Ethanol)
correct_colnames_numeric$Natural_Gas <- gsub(",", "", correct_colnames_numeric$Natural_Gas)
correct_colnames_numeric$Natural_Gas <- as.numeric(correct_colnames_numeric$Natural_Gas)
correct_colnames_numeric$CO2_Per_Capita <- as.numeric(correct_colnames_numeric$CO2_Per_Capita)
correct_colnames_numeric$CO2 <- as.numeric(correct_colnames_numeric$CO2)

# summary statistic values
max_bio_fuel <- max(correct_colnames_numeric$BioFuel)
min_bio_fuel <- min(correct_colnames_numeric$BioFuel)
avg_bio_fuel <- mean(correct_colnames_numeric$BioFuel)
max_crude_oil <- max(correct_colnames_numeric$Crude_Oil)
min_crude_oil <- min(correct_colnames_numeric$Crude_Oil)
avg_crude_oil <- mean(correct_colnames_numeric$Crude_Oil)
max_fuel_ethanol <- max(correct_colnames_numeric$Fuel_Ethanol)
min_fuel_ethanol <- min(correct_colnames_numeric$Fuel_Ethanol)
avg_fuel_ethanol <- mean(correct_colnames_numeric$Fuel_Ethanol)
max_natural_gas <- max(correct_colnames_numeric$Natural_Gas)
min_natural_gas <- min(correct_colnames_numeric$Natural_Gas)
avg_natural_gas <- mean(correct_colnames_numeric$Natural_Gas)
max_CO2_Per_capita <- max(correct_colnames_numeric$CO2_Per_Capita)
min_CO2_Per_capita <- min(correct_colnames_numeric$CO2_Per_Capita)
avg_CO2_Per_capita <- mean(correct_colnames_numeric$CO2_Per_Capita)
max_CO2 <- max(correct_colnames_numeric$CO2)
min_CO2 <- min(correct_colnames_numeric$CO2)
avg_CO2 <- mean(correct_colnames_numeric$CO2)

# Options for question 2 selection
selectThis1 <- c("Bio Fuel", "Ethanol")
selectThis2 <- c("Crude Oil", "Natural Gas")

#
find_x_or_y <- function (variable) {
  if (variable == "Bio Fuel") {
    variable <- "BioFuel"
  }
  if (variable == "Ethanol") {
    variable <- "Fuel_Ethanol"
  }
  if (variable == "Crude Oil") {
    variable <- "Crude_Oil"
  }
  if (variable == "Natural Gas") {
    variable <- "Natural_Gas"
  }
  variable
}
