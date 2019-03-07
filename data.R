# Read in data from Yelp API

# load relevant libraries
library("httr")
library("jsonlite")
library("dplyr")
library("tidyr")

# get apikey from "https://www.yelp.com/developers/documentation/v3"
source("api-keys.R")


# Setup -------------------------------------------------------------------

place_of_interest <- "Seattle"
base_uri <- "https://api.yelp.com/v3"

# BUSINESS
resource_business <- paste0("/businesses/search")

# first set
response_business <- GET(
  paste0(base_uri, resource_business),
  add_headers("Authorization" = paste("Bearer", yelp_key)),
  query = list(location = place_of_interest, offset = 0)
)
parsed_data_businesses <- fromJSON(content(response_business, "text"))
businesses <- flatten(parsed_data_businesses$businesses)

# api only lets us return 1000 results
for (i in 1:49) {
  
  response_next <- GET(
    paste0(base_uri, resource_business),
    add_headers("Authorization" = paste("Bearer", yelp_key)),
    query = list(location = place_of_interest, offset = i * 20)
  )
  parsed_data_next <- fromJSON(content(response_next, "text"))
  businesses_next <- flatten(parsed_data_next$businesses)
  businesses <- bind_rows(businesses, businesses_next)

}

businesses <- unnest(businesses, categories)
colnames(businesses)[colnames(businesses)=="title"] <- "category"

write.csv(businesses, "businesses.csv", row.names = FALSE)


# CATEGORIES

resource_cat<- paste0("/categories")

response_cat <- GET(
  paste0(base_uri, resource_cat),
  add_headers("Authorization" = paste("Bearer", yelp_key))
)

parsed_data_cat <- fromJSON(content(response_cat, "text"))

categories <- parsed_data_cat$categories %>% 
  select(alias, title, parent_aliases) %>% 
  unnest(parent_aliases)

write.csv(categories, "categories.csv", row.names = FALSE)
