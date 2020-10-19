library(tidytext)
library(stringr)
library(textdata)
library(dplyr)
library(tidyr)
library(formattable)
library(knitr)
library(kableExtra)
library(tidyverse)
library(gridExtra)


my_colors <- c("#E69F00", "#56B4E9", "#009E73", "#CC79A7", "#D55E00", "#D65E00")


my_kable_styling <- function(dat, caption) {
  kable(dat, "html", escape = FALSE, caption = caption) %>%
    kable_styling(bootstrap_options = c("striped", "condensed", "bordered"),
                  full_width = FALSE)
}



bing <- get_sentiments("bing") %>% 
  mutate(lexicon = "bing", 
         words_in_lexicon = n_distinct(word))    


nrc <- get_sentiments("nrc") %>% 
  mutate(lexicon = "nrc", 
         words_in_lexicon = n_distinct(word))



new_sentiments <- bind_rows(bing, nrc)


new_sentiments <- new_sentiments %>% #From the tidytext package
  group_by(lexicon) %>%
  mutate(words_in_lexicon = n_distinct(word)) %>%
  ungroup()

new_sentiments %>%
  group_by(lexicon, sentiment, words_in_lexicon) %>%
  summarise(distinct_words = n_distinct(word)) %>%
  ungroup() %>%
  spread(sentiment, distinct_words) %>%
  mutate(lexicon = color_tile("lightblue", "lightblue")(lexicon),
         words_in_lexicon = color_bar("lightpink")(words_in_lexicon)) %>%
  my_kable_styling(caption = "Word Counts Per Lexicon")

review_words_filtered <- read_csv("derived_data/review_words_filtered.csv")

review_tidy <-
  mutate(review_words_filtered,words_in_review = n_distinct(review_words_filtered$word)) %>%
  inner_join(new_sentiments) %>%
  group_by(lexicon, words_in_review, words_in_lexicon) %>%
  summarise(lex_match_words = n_distinct(word)) %>%
  ungroup() %>%
  mutate(total_match_words = sum(lex_match_words), #Not used but good to have
         match_ratio = lex_match_words / words_in_review) %>%
  select(lexicon, lex_match_words,  words_in_review, match_ratio) %>%
  mutate(lex_match_words = color_bar("lightpink")(lex_match_words),
         lexicon = color_tile("lightgreen", "lightgreen")(lexicon)) %>%
  my_kable_styling(caption = "Reviews Found In Lexicons")

save_kable(review_tidy,"image/sentiment_match_in_three_database.png")

#bing clean up
review_bing <- review_words_filtered %>%
  inner_join(get_sentiments("bing"))

saveRDS(review_bing, "derived_data/review_bing.rds")

#nrc clean_up

review_nrc <- review_words_filtered %>%
  inner_join(get_sentiments("nrc"))

saveRDS(review_nrc,"derived_data/review_nrc.rds")

