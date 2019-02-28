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

response_business <- GET(
  paste0(base_uri, resource_business),
  add_headers("Authorization" = paste("Bearer", yelp_key)),
  query = list(location = place_of_interest,
               offset = 1)
)

parsed_data <- fromJSON(content(response_business, "text"))

businesses <- parsed_data_business$businesses

