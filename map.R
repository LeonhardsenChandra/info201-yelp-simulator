library("dplyr")
library("leaflet")
#library("htmltools")
#library("RColorBrewer")
library("randomcoloR")

businesses <- read.csv("/data/all_data.csv", stringsAsFactors = FALSE)
categories <- read.csv("/data/categories.csv", stringsAsFactors = FALSE)

# rename category name for join
colnames(categories)[colnames(categories) == "title"] <- "category"
joined_data <- full_join(businesses, categories, by = "category")

# number of selected categories
ncategories <- 20

# only get top n categories
top_categories <- joined_data %>% 
  group_by(parent_aliases) %>% 
  count() %>%
  arrange(-n) %>% 
  ungroup() %>% 
  top_n(ncategories)

top_categories_list <- as.list(top_categories$parent_aliases)

filtered_data <- joined_data %>% 
  filter(parent_aliases %in% top_categories_list)

# get n distinct colors for map
palette <- distinctColorPalette(ncategories)
palette_fn <- colorFactor(palette = palette, domain = filtered_data$parent_aliases)

# visual map
leaflet(data = filtered_data) %>%
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
    title = paste0("Top ", ncategories, " Categories"),
    pal = palette_fn, # the color palette described by the legend
    values = ~parent_aliases, # the data values described by the legend
    opacity = 1
  )
