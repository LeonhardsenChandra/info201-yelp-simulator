# plot.R

library("dplyr")
library("plotly")

build_plot <- function(cuisine_select_menu3) {
  businesses <- read.csv("data/filtered_all_cities.csv",
    stringsAsFactors = FALSE
  )

  # select information needed
  by_major_cities <- businesses %>%
    filter(category == cuisine_select_menu3) %>%
    select(location.city, location.state, rating, price)

  # calculate the average prices for each major city
  by_major_cities <- by_major_cities %>%
    filter(!is.na(price)) %>%
    mutate(price_val = nchar(price)) %>%
    group_by(location.city) %>%
    summarise(
      rating_avg = mean(rating),
      price_avg = mean(price_val)
    )

  # plot the data
  p <- plot_ly(
    data = by_major_cities, x = ~price_avg, y = ~rating_avg,
    type = "scatter", mode = "markers", marker = list(size = 10),
    text = ~location.city,
    color = ~rating_avg
  ) %>%
    # Use pipe function to pass the plotly object into the `layout` function
    layout(
      title = "Average Price vs. Rating in major cities",
      xaxis = list(title = " Average price (1~4)", zeroline = FALSE),
      yaxis = list(title = " Average rating (1~5)", zeroline = FALSE)
    )

  # Show chart
  p
}
