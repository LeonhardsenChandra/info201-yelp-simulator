# Read in data from Yelp API

# load relevant libraries
library("httr")
library("jsonlite")

# get apikey from "https://www.yelp.com/developers/documentation/v3"
# enable developer for events search
source("api-keys.R")


# Setup -------------------------------------------------------------------
place_of_interest <- "Seattle"

base_uri <- "https://api.yelp.com/v3"

resource_business <- paste0("/businesses/search")
resource_events <- paste0("/events")


response_business <- GET(
  paste0(base_uri, resource_business),
  add_headers("Authorization" = paste("Bearer", yelp_key)),
  query = list(location = place_of_interest)
)
response_events <- GET(
  paste0(base_uri, resource_events),
  add_headers("Authorization" = paste("Bearer", yelp_key)),
  query = list(location = place_of_interest)
)

parsed_data_business <- fromJSON(content(response_business, "text"))
parsed_data_events <- fromJSON(content(response_events, "text"))

businesses <- parsed_data$businesses
events <- parsed_data_events$events

