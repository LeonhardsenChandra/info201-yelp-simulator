# ui.R

library("shiny")

cities <- c("New York", "Los Angeles", "Chicago",
            "Philadelphia", "San Diego", "San Francisco",
            "Seattle", "Orange County", "Atlanta",
            "Las Vegas", "Orlando")

cuisines <- c("American (New)", "American (Traditional)", "Chinese", "Mexican",
              "Italian", "French", "Indian", "Thai", "Mediterranean", "Korean",
              "Vietnamese", "Vegan")


# map.R -------------------------------------------------------------------

source("map.R")

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

# wordcloud.R -------------------------------------------------------------

source("wordcloud.R")

cuisine_select_menu2 <- selectInput(
  "cuisine_select_menu2",
  label = h3("Cuisine"),
  choices = cuisines,
  selected = cuisines[1]
)

# chart.R -------------------------------------------------------------------

source("chart.R")

city_select_menu <- selectInput(
  "city_select_menu",
  label = h3("City"),
  choices = cities,
  selected = "Seattle"
)

cuisine_select_menu <- selectInput(
  "cuisine_select_menu",
  label = h3("Cuisine"),
  choices = cuisines,
  selected = cuisines
)


# plot.R ------------------------------------------------------------------

source("plot.R")

cuisine_select_menu3 <- selectInput(
  "cuisine_select_menu3",
  label = h3("Cuisine"),
  choices = cuisines,
  selected = cuisines[1]
)

# Navigation Bar ----------------------------------------------------------

shinyUI(navbarPage(
  theme = "web.css",
  "Whelp",
  # Intro Panel
  tabPanel(
    "Introduction",
    width = 500,
    mainPanel(
      includeMarkdown("intro.md")
    )
  ),
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
  # WordCloud Panel
  tabPanel(
    "Word Cloud",
    width = 500,
    sidebarLayout(
      sidebarPanel(
        h2(strong("Options")),
        cuisine_select_menu2
      ),
      mainPanel(
        h2(strong("Word Cloud")),
        plotOutput("wordcloud")
      )
    )
  ),
  # Chart Panel
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
  ),
  # Plot Panel
  tabPanel(
    "Plot",
    width = 500,
    sidebarLayout(
      sidebarPanel(
        h2(strong("Options")),
        cuisine_select_menu3
      ),
      mainPanel(
        h2(strong("Plot")),
        plotlyOutput("plot")
      )
    )
  )
))
