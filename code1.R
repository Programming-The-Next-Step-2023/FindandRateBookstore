install.packages("shiny")
install.packages("leaflet")
install.packages("maps")


library(leaflet) #for making the interactive map
library(shiny)
library(maps)


##the user interface

ui <- fluidPage(
  titlePanel("Find and Rate a Bookstore"),
  theme = shinytheme("cerulean"),
  leafletOutput("map_netherlands")

)


##the server

server <- function(input, output) {
  output$map_netherlands <- renderLeaflet({
    leaflet() %>%
      addTiles() %>%
      setView(lng = 5.2913, lat = 52.1326, zoom = 7)
  })
}


##run the app
shinyApp(ui, server)


#comment


