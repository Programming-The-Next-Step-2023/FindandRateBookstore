# This file is part of the standard setup for testthat.
# It is recommended that you do not modify it.
#
# Where should you do additional test configuration?
# Learn more about the roles of various files in:
# * https://r-pkgs.org/tests.html
# * https://testthat.r-lib.org/reference/test_package.html#special-files

#install.packages("FindandRateBookstore")
#install.packages("Rtools")

devtools::install_github("Programming-The-Next-Step-2023/FindandRateBookstore")

library(testthat)
library(FindandRateBookstore)

library(shinytest)
library(shiny)
library(leaflet)



test_that("zoom_to_location sets the correct view", {

  mock_leafletProxy <- leaflet() %>%
    setView(lng = 0, lat = 0, zoom = 0)

  # initial state of the map
  output <- list(map_netherlands = mock_leafletProxy)
  input <- list()

  # Call the zoom_to_location function
  zoom_to_location("anne_frank", input, output)

  # resulting state of the map
  result_state <- mock_leafletProxy$getProxyData()

  # Check that the view has been set correctly
  expect_equal(result_state$view$lng, 4.8839, tolerance = 0.0001)
  expect_equal(result_state$view$lat, 52.3752, tolerance = 0.0001)
  expect_equal(result_state$view$zoom, 17)
})

test_check("FindandRateBookstore")





