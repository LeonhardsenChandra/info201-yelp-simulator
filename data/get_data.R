# Read in data from Yelp API

# load relevant libraries
library("httr")
library("jsonlite")
library("dplyr")
library("tidyr")

# get apikey from "https://www.yelp.com/developers/documentation/v3"
source("api-keys.R")


# Get Top 10 Most Visited U.S. Cities, and Seattle
cities <- c(
  "New York", "Los Angeles", "Chicago",
  "Philadelphia", "San Diego", "San Francisco",
  "Seattle", "Orange County", "Atlanta",
  "Las Vegas", "Orlando"
)

# Get Top 12 Most Popular Cuisines in U.S, and Vegan
cuisines <- c(
  "American (New)", "American (Traditional)", "Chinese", "Mexican",
  "Italian", "French", "Indian", "Thai", "Mediterranean", "Korean",
  "Vietnamese", "Vegan"
)


# Get Data ----------------------------------------------------------------

base_uri <- "https://api.yelp.com/v3"
resource_business <- paste0("/businesses/search")

# Get 250 businesses from a city

city <- cities[11]

# first set
response_business <- GET(
  paste0(base_uri, resource_business),
  add_headers("Authorization" = paste("Bearer", yelp_key)),
  query = list(location = city, offset = 0, limit = 50)
)
parsed_data_businesses <- fromJSON(content(response_business, "text"))
businesses <- flatten(parsed_data_businesses$businesses)

# return 250 businesses for each city
for (i in 1:5) {
  response_next <- GET(
    paste0(base_uri, resource_business),
    add_headers("Authorization" = paste("Bearer", yelp_key)),
    query = list(location = city, offset = i * 50, limit = 50)
  )
  parsed_data_next <- fromJSON(content(response_next, "text"))
  businesses_next <- flatten(parsed_data_next$businesses)
  businesses <- bind_rows(businesses, businesses_next)
}

businesses <- unnest(businesses, categories)
colnames(businesses)[colnames(businesses) == "title"] <- "category"

write.csv(businesses, paste0(city, ".csv"), row.names = FALSE)

# CATEGORIES

resource_cat <- paste0("/categories")

response_cat <- GET(
  paste0(base_uri, resource_cat),
  add_headers("Authorization" = paste("Bearer", yelp_key))
)

parsed_data_cat <- fromJSON(content(response_cat, "text"))

categories <- parsed_data_cat$categories %>%
  select(alias, title, parent_aliases) %>%
  unnest(parent_aliases)

write.csv(categories, "categories.csv", row.names = FALSE)

# Merge Data ---------------------------------------------------------------

atlanta <- read.csv("Atlanta, GA.csv", stringsAsFactors = FALSE)
chicago <- read.csv("Chicago, IL.csv", stringsAsFactors = FALSE)
lasvegas <- read.csv("Las Vegas, NV.csv", stringsAsFactors = FALSE)
losangeles <- read.csv("Los Angeles, CA.csv", stringsAsFactors = FALSE)
newyork <- read.csv("New York, NY.csv", stringsAsFactors = FALSE)
orangecounty <- read.csv("Orange County, CA.csv", stringsAsFactors = FALSE)
orlando <- read.csv("Orlando, FL.csv", stringsAsFactors = FALSE)
philadelphia <- read.csv("Philadelphia, PA.csv", stringsAsFactors = FALSE)
sandiego <- read.csv("San Diego, CA.csv", stringsAsFactors = FALSE)
sanfrancisco <- read.csv("San Francisco, CA.csv", stringsAsFactors = FALSE)
seattle <- read.csv("Seattle, WA.csv", stringsAsFactors = FALSE)

all_cities <- rbind(
  atlanta, chicago, lasvegas, losangeles, newyork,
  orangecounty, orlando, philadelphia, sandiego,
  sanfrancisco, seattle
)

all_cities <- all_cities %>%
  filter(location.city %in% cities)

write.csv(all_cities, "all_cities.csv", row.names = FALSE)

# Filter out cuisines
filtered_all_cities <- all_cities %>%
  filter(category == cuisines[1] | category == cuisines[2] |
    category == cuisines[3] | category == cuisines[4] |
    category == cuisines[5] | category == cuisines[6] |
    category == cuisines[6] | category == cuisines[7] |
    category == cuisines[7] | category == cuisines[8] |
    category == cuisines[9] | category == cuisines[10] |
    category == cuisines[11] | category == cuisines[12])

write.csv(filtered_all_cities, "filtered_all_cities.csv", row.names = FALSE)


# Reviews -----------------------------------------------------------------

filtered_all_cities <- read.csv("filtered_all_cities.csv",
                                stringsAsFactors = FALSE)

resource_reviews <- paste0("/businesses/", filtered_all_cities$id[1],
                           "/reviews")

response_reviews <- GET(
  paste0(base_uri, resource_reviews),
  add_headers("Authorization" = paste("Bearer", yelp_key))
)
parsed_data_reviews <- fromJSON(content(response_reviews, "text"))
reviews <- flatten(parsed_data_reviews$reviews)
reviews$bus_id <- filtered_all_cities$id[1]

for (business in filtered_all_cities$id[2:nrow(filtered_all_cities)]) {
  resource_reviews <- paste0("/businesses/", business, "/reviews")

  response_reviews_next <- GET(
    paste0(base_uri, resource_reviews),
    add_headers("Authorization" = paste("Bearer", yelp_key))
  )
  parsed_data_reviews_next <- fromJSON(content(response_reviews_next, "text"))
  reviews_next <- flatten(parsed_data_reviews_next$reviews)
  reviews_next$bus_id <- business
  reviews <- bind_rows(reviews, reviews_next)
}

write.csv(reviews, "reviews.csv", row.names = FALSE)

reviews_by_business <- reviews %>%
  select(text, bus_id) %>%
  group_by(bus_id) %>%
  summarise(texts = paste0(text, collapse = ""))

colnames(reviews_by_business)[colnames(reviews_by_business) == "bus_id"] <- "id"

word_data <- full_join(filtered_all_cities, reviews_by_business) %>%
  select(category, texts)

write.csv(word_data, "word_data.csv", row.names = FALSE)
