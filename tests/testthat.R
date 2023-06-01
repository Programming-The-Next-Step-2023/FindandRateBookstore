# This file is part of the standard setup for testthat.
# It is recommended that you do not modify it.
#
# Where should you do additional test configuration?
# Learn more about the roles of various files in:
# * https://r-pkgs.org/tests.html
# * https://testthat.r-lib.org/reference/test_package.html#special-files

install.packages("FindandRateBookstore")
install.packages("Rtools")

devtools::install_github("Programming-The-Next-Step-2023/FindandRateBookstore")

library(testthat)
library(FindandRateBookstore)

library(shinytest)
library(shiny)
library(leaflet)

#test_check("FindandRateBookstore")

# Define a test case for map zoom


test_that("Map zooms in correctly", {
  #start a new app session
  app <- ShinyDriver$new(testthat::test_path("startApp.R"), loadTimeout = 100000)

  # Set the latitude and longitude inputs
  app$setInputs(latitude = "52.0", longitude = "5.0", wait = FALSE, val = FALSE)

  # Click the "Update Map" button
  app$click("updateMap")

  # Get the current map state
  map_state <- app$getMapState("map_netherlands")


# Check if the map zoom level is correct
  expect_equal(map_state$zoom, 14)

  # Close the Shiny app session
  app$stop()
})



test_check("FindandRateBookstore")






