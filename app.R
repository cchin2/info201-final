<<<<<<< HEAD
source("my_ui_Great.R")
=======
library("shiny")

source("my_ui.R")
source("my_server.R")
>>>>>>> 845c800576c07f421b8307784ef4709348326a61

shinyApp(ui = my_ui, server = my_server)