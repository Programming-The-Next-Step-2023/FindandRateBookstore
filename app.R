install.packages("shiny")
install.packages("leaflet")
install.packages("maps")
#install.packages("Rtools")
install.packages("rlang")
install.packages("shinytest")
install.packages("testthat")
install.packages("usethis")


library(leaflet) #for making the interactive map
library(shiny)
library(maps)
library(rlang)
library(usethis)
library(devtools)
library(testthat)
library(shinytest)


##the user interface

ui <- fluidPage(
  titlePanel("Find and Rate a Bookstore"),
  sidebarLayout(
    position = "right",
    sidebarPanel(
      h1("Where are you right now?"),
      textInput("latitude", "Latitude:"),
      textInput("longitude", "Longitude:"),
      actionButton("updateMap", "Update Map")
      ),
    mainPanel(
      h1("map"),
      leafletOutput("map_netherlands")
      )
  )
)



##the server
#fist I want there to be a map of the Netherlands when the app opens


#' create a Map
#'
#' @param input latitude and longitude of the location
#' @param output map zoomed into the location
#'
#' @return the map
#' @export
#'
#' @examples
#' if you pot in latitude: 52.37 and longitude: 4.89 then it will zoom into Amsterdam


server <- function(input, output) {
  output$map_netherlands <- renderLeaflet({
    leaflet() %>%
      addTiles() %>%
      setView(lng = 5.2913, lat = 52.1326, zoom = 7)
  })
#then the user can type in their location using Latitude and Longitude
  #the map then zooms in closer to their location on the map
  observeEvent(input$updateMap, {
    lat <- as.numeric(input$latitude)
    lng <- as.numeric(input$longitude)

    if (!is.na(lat) && !is.na(lng)) {
      leafletProxy("map_netherlands") %>%
        clearMarkers() %>%
        addMarkers(lng = lng, lat = lat, label = "Your Location") %>%
        setView(lng = lng, lat = lat, zoom = 14)
    }
  })
}

##run the app
shinyApp(ui= ui, server= server)



usethis::use_testthat()







