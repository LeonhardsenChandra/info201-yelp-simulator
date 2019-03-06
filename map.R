library("dplyr")
library("ggplot2")
library("lubridate")
library("tidyr")
library("ggmap")
library("lintr")
library("styler")
library("leaflet")
library("htmltools")

source("data.R")

palette_fn <- colorFactor(palette = "Set3", domain = businesses$category)

# visual map
map <- leaflet(data = businesses) %>%
  addTiles() %>%
  addCircleMarkers(
    lat = ~coordinates.latitude,
    lng = ~coordinates.longitude,
    stroke = FALSE, # remove border from each circle
    label = ~name,
    radius = ~rating, # size varies with casualty
    color = ~palette_fn(category), # color varies by month
    fillOpacity = 0.7
  )
