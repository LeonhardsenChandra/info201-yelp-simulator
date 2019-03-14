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
    h2("Visual Map"),
    p("An", strong(em("interactive map")), "of roughly", strong("150"), 
      "restaurants for each of the cities selected. Restaurants are",
      "color-coded according to the type of cuisine, which were selected",
      "by the popularity of the cuisines in the U.S. Difficulties in",
      "obtaining the full data from all the cities and states in the U.S.",
      "led us to choose only the most popular cities to visit, and the most",
      "popular cuisines, which we feel is useful enough for our target",
      "audience, which are mainly tourists and food adventurers."),
    sidebarLayout(
      sidebarPanel(
        h2("Options"),
        city_select_box,
        cuisine_check_box
      ),
      mainPanel(
        h2("Map"),
        leafletOutput("map")
      )
    )
  ),
  # WordCloud Panel
  tabPanel(
    "Word Cloud",
    width = 500,
    h2("Word Cloud"),
    p("A", strong(em("word cloud")), "of reviews of restaurants obtained",
      "from the", strong("Yelp"), "API. As of now, only the three most",
      "relevant reviews for each restaurant could be obtained, which were",
      "identified to the restaurant and then categorized into the different",
      "types of cuisines. We feel this could provide useful and interesting",
      "insight onto the key words associated to a certain cuisine."),
    sidebarLayout(
      sidebarPanel(
        h2("Options"),
        cuisine_select_menu2
      ),
      mainPanel(
        h2("Cloud"),
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
        h2("Options"),
        city_select_menu,
        cuisine_select_menu
      ),
      mainPanel(
        h2("Chart"),
        DTOutput("chart")
      )
    )
  ),
  # Plot Panel
  tabPanel(
    "Scatter Plot",
    width = 500,
    h2("Scatter Plot"),
    p("A", strong(em("scatter plot")), "that compares the average price and
          rating in the major cities across the country. The price ranges from 
      1 (under $10 per person) to 4 (over $60 per person). The ratings are
      based on the number of stars given by customers on the Yelp. As we 
      can see, there're great variations for different cuisines in each
      state."),
    sidebarLayout(
      sidebarPanel(
        h2("Options"),
        cuisine_select_menu3
      ),
      mainPanel(
        h2("Plot"),
        plotlyOutput("plot")
      )
    )
  )
))
