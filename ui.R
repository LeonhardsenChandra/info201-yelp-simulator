# ui.R

library("shiny")
library("randomcoloR")
library("DT")

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

# chart.R -------------------------------------------------------------------

source("chart.R")

city_select_menu <- selectInput(
  "city_select_menu",
  label = h3("Metropolitan City"),
  choices = cities,
  selected = "Seattle"
)

cuisine_select_menu <- selectInput(
  "cuisine_select_menu",
  label = h3("Cuisine"),
  choices = cuisines,
  selected = cuisines
)

# Navigation Bar ----------------------------------------------------------

shinyUI(navbarPage(
  theme = "web.css",
  "Whelp",
  # Map Panel
  tabPanel(
    "Map",
    width = 500,
    sidebarLayout(
      sidebarPanel(
        h2(strong("Options")),
        city_select_box,
        cuisine_check_box
      ),
      mainPanel(
        h2(strong("Map")),
        leafletOutput("map")
      )
    )
  ),
  tabPanel(
    "Chart",
    width = 500,
    sidebarLayout(
      sidebarPanel(
        h2(strong("Options")),
        city_select_menu,
        cuisine_select_menu
      ),
      mainPanel(
        h2(strong("Chart")),
        DTOutput("chart")
      )
    )
  )
))
