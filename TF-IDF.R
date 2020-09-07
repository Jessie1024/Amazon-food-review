library(dplyr)
library(tidyverse)
library(knitr)
library(kableExtra)
library(formattable)
library(stringr)
library(tidytext)

raw_data<-read_csv("derived_data/clean_data.csv")
undesirable_words<-c("3095826", "boo4ebuwhm", "15.63", "9.19", "1331447807", 
                     "b003xul1mk","b000zsz5pw","350mgs", "4thd","b00", "300mg")

popular_tfidf_words <-raw_data%>%
  unnest_tokens(word, text) %>%
  filter(!word %in% undesirable_words) %>%
  distinct() %>%
  filter(nchar(word) > 3) %>%
  count(score, word, sort = TRUE) %>%
  ungroup() %>%
  bind_tf_idf(word, score, n)

top_popular_tfidf_words <- popular_tfidf_words %>%
  arrange(desc(tf_idf)) %>%
  mutate(word = factor(word, levels = rev(unique(word)))) %>%
  group_by(score) %>% 
  slice(seq_len(20)) %>%
  ungroup() %>%
  arrange(score, tf_idf) %>%
  mutate(row = row_number())

top_popular_tfidf_words %>%
  ggplot(aes(x = row, tf_idf, 
             fill = score)) +
  geom_col(show.legend = NULL) +
  labs(x = NULL, y = "TF-IDF") + 
  ggtitle("Important Words using TF-IDF by View Score") +
  theme_lyrics() +  
  facet_wrap(~score, ncol = 5, scales = "free") +
  scale_x_continuous(  # This handles replacement of row 
    breaks = top_popular_tfidf_words$row, # notice need to reuse data frame
    labels = top_popular_tfidf_words$word) +
  coord_flip()+
  ggsave("image/TF-IDF.png")
