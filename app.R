library("shiny")

source("cam_ui.R")
source("cam_server.R")

shinyApp(ui = my_ui, server = my_server)