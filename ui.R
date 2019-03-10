# ui.R

library("shiny")

# map.R -------------------------------------------------------------------

source("map.R")

cities <- c("New York", "Los Angeles", "Chicago",
            "Philadelphia", "San Diego", "San Francisco",
            "Seattle", "Orange County", "Atlanta",
            "Las Vegas", "Orlando")

cuisines <- c("American (New)", "American (Traditional)", "Chinese", "Mexican",
              "Italian", "French", "Indian", "Thai", "Mediterranean", "Korean",
              "Vietnamese", "Vegan")

city_select_box <- selectInput(
  "city_select_box",
  label = h3("City"),
  choices = cities,
  selected = "Seattle"
)

cuisine_check_box <- checkboxGroupInput(
  "cuisine_check_box",
  label = h3("Cuisine"),
  choices = cuisines,
  selected = cuisines
)


# Navigation Bar ----------------------------------------------------------

shinyUI(navbarPage(
  "Whelp",
  
  # Map Panel
  tabPanel(
    "Map",
    sidebarLayout(
      sidebarPanel(
        h2(strong("Widgets")),
        city_select_box,
        cuisine_check_box
      ),
      mainPanel(
        h2(strong("Map")),
        leafletOutput("map")
      )
    )
  )
))
