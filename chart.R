# chart.R

library(shiny)
library(rsconnect)
library(dplyr)
library(DT)

build_chart <- function(city_select_menu, cuisine_select_menu) {
  businesses <- read.csv("data/filtered_all_cities.csv",
    stringsAsFactors = FALSE
  )

  # filter by widgets
  businesses <- businesses %>%
    filter(location.city == city_select_menu &
      category == cuisine_select_menu) %>%
    select(
      "Name" = name, "Rating" = rating,
      "Number of Reviews" = review_count,
      "Price" = price, "Phone Number" = display_phone,
      "Address" = location.address1,
      "Image" = image_url, url
    ) %>%
    mutate(Name = paste0(
      "<a href='", url,
      "' target='_blank' class='btn btn-primary'>",
      Name, "</a>"
    )) %>%
    mutate(Image = paste0("<img src=\"", Image, "\" height=\"52\"></img>")) %>%
    select(
      Name, Rating, "Number of Reviews",
      Price, "Phone Number", Address, Image
    ) %>%
    arrange(desc(Rating))

  # create chart
  datatable(businesses, escape = FALSE)
}
