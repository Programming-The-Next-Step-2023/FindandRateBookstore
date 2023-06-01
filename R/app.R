# install.packages("shiny")
# install.packages("leaflet")
# install.packages("maps")
# #install.packages("Rtools")
# install.packages("rlang")
# install.packages("shinytest")
# install.packages("testthat")
# install.packages("usethis")
#install.packages("shinyWidgets")

install.packages("rmarkdown")

library(leaflet) #for making the interactive map
library(shiny)
library(maps)
library(rlang)
library(usethis)
library(devtools)
library(testthat)
library(shinytest)
library(FindandRateBookstore)
library(shinyWidgets)


devtools::document()
devtools::install("FindandRateBookstore")

#' @importFrom usethis use_package_doc
#' @export
run_use_package_doc <- function() {
  usethis::use_package_doc(override = TRUE, includeFiles = TRUE)
}


#add all the things i want to instal to the discription file
##the user interface

ui <- fluidPage(
  #set the backgroundcolour of the shiny app page
  setBackgroundColor(
    color = "#d9f0c1",
    gradient = c("linear", "radial"),
    direction = c("bottom", "top", "right", "left"),
    shinydashboard = FALSE
  ),
  #add a title
  titlePanel(
    tags$div(
    # Use the img tag to add the image
      tags$img(src = system.file("www\Picture4.jpg", package = "FindandRateBookstore"),
               height = "150px", width = "150px"),
    # Add a space between the image and text
    tags$span(style = "margin-left: 20px;"),
    # Add the text
    "Find and Rate a Bookstore"),
  ),
  #add a side bar
  sidebarLayout(
    position = "right",
    #panel on the right that allows for latitude and longitude input
    sidebarPanel(
      h1("Where are you right now?"),
      textInput("latitude", "Latitude:"),
      helpText("Enter the latitude of your location."),
      textInput("longitude", "Longitude:"),
      helpText("Enter the longitude of your location."),
      actionButton("updateMap", "Update Map")
      ),
    #main panel on the left that depicts a map
    mainPanel(
      h1("Map"),
      leafletOutput("map_netherlands"),
      br(), # Add a line break
      textOutput("map_description") # Display text below the map
    )

  )
)



###### delete this documentation

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

  # Add points on the map
  observeEvent(input$addPoint, {
    lat <- as.numeric(52.36895$newLatitude)
    lng <- as.numeric(4.889547$newLongitude)

    if (!is.na(lat) && !is.na(lng)) {
      leafletProxy("map_netherlands") %>%
        addMarkers(lng = lng, lat = lat, label = "The American Book Center",  icon = leaflet::icon("star", color = "blue", size = "large"))
    }
  })




  #add the text for under the map
    output$map_description <- renderText({
      "Add you longitude and latitude to the right and this map will show you your location"
      })
}


#add documentation to this function
#this is the function that will run the app


startApp <- function(){
shinyApp(ui= ui, server= server) }

list.files("www")
