# wordcloud.R

library("dplyr")
library("tidytext")
library("wordcloud")
library("tidyr")

build_wordcloud <- function(cuisine_select_menu2) {
  word_data <- read.csv("data/word_data.csv", stringsAsFactors = FALSE)

  # filter data according to specified cuisine
  data <- word_data[word_data$category == cuisine_select_menu2, ][2]

  # generate the full list of words
  all_words <- data %>%
    unnest_tokens(word, texts)

  # from special-topics-text repository
  # Remove stop words by performing an anti_join with the stop_words dataframe
  no_stop_words <- all_words %>%
    anti_join(stop_words, by = "word")

  # count number of each word
  non_stop_count <- no_stop_words %>%
    group_by(word) %>%
    summarize(n = n())

  # create word cloud
  non_stop_count %>%
    with(wordcloud(word, n,
      scale = c(4, .5), random.order = FALSE, max.words = 100,
      use.r.layout = FALSE, colors = brewer.pal(8, "Dark2")
    ))
}
