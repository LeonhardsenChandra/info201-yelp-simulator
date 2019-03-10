library("dplyr")
library("leaflet")
#library("htmltools")
#library("RColorBrewer")
library("randomcoloR")

businesses <- read.csv("data/all_cities_joined.csv", stringsAsFactors = FALSE)
categories <- read.csv("data/categories.csv", stringsAsFactors = FALSE)


# only get top n categories
top_categories <- businesses %>% 
  group_by(parent_aliases) %>% 
  count() %>%
  arrange(-n) %>% 
  ungroup()

filtered_data <- joined_data %>% 
  filter(parent_aliases %in% top_categories_list)

# get n distinct colors for map
palette <- distinctColorPalette(ncategories)
palette_fn <- colorFactor(palette = "Set3", domain = businesses$parent_aliases)

# visual map
leaflet(data = businesses) %>%
  addProviderTiles("CartoDB.Positron") %>%
  addCircleMarkers(
    lat = ~coordinates.latitude,
    lng = ~coordinates.longitude,
    stroke = FALSE, # remove border from each circle
    label = ~name,
    radius = ~rating, # size varies with casualty
    color = ~palette_fn(parent_aliases), # color varies by month
    fillOpacity = 0.7
  ) %>%
  addLegend(
    position = "bottomright",
    title = paste0("Top ", 10, " Categories"),
    pal = palette_fn, # the color palette described by the legend
    values = ~parent_aliases, # the data values described by the legend
    opacity = 1
  )
