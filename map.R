library("dplyr")
library("leaflet")
#library("htmltools")
#library("RColorBrewer")
library("randomcoloR")
library("htmltools")

build_map <- function(city_select_box, cuisine_check_box) {
  
  businesses <- read.csv("data/filtered_all_cities.csv",
                         stringsAsFactors = FALSE)
  
  businesses <- businesses %>% 
    filter(location.city == city_select_box & category %in% cuisine_check_box) %>% 
    mutate(desc = paste0(
      "Name: ", name, "<br/>",
      "Phone Number: ", display_phone, "<br/>",
      "Price: ", price, "<br/>",
      "Rating: ", rating, "<br/>",
      "Address: ", location.address1
    ))
  
  palette_fn <- colorFactor(palette = "Set3", domain = businesses$category)
  
  # visual map
  leaflet(data = businesses) %>%
    addProviderTiles("CartoDB.Positron") %>%
    addCircleMarkers(
      lat = ~coordinates.latitude,
      lng = ~coordinates.longitude,
      stroke = FALSE, # remove border from each circle
      label = ~lapply(desc, HTML),
      radius = ~rating, # size varies with casualty
      color = ~palette_fn(category), # color varies by month
      fillOpacity = 0.7
    ) %>%
    addLegend(
      position = "bottomright",
      title = "Cuisines",
      pal = palette_fn, # the color palette described by the legend
      values = ~category, # the data values described by the legend
      opacity = 1
    )
  
}