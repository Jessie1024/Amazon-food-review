library(stringr)
library(kableExtra)
library(tidyverse)
library(tidytext)

review_words_filtered<-read_csv("derived_data/review_words_filtered.csv")

popular_words <- review_words_filtered %>% 
  group_by(score) %>%
  count(word, score, sort = TRUE) %>%
  slice(seq_len(10)) %>%
  ungroup() %>%
  arrange(score,n) %>%
  mutate(row = row_number()) 

write_csv(popular_words, "derived_data/popular_words.csv")

popular_words %>%
  ggplot(aes(row, n, fill = score)) +
  geom_col(show.legend = NULL) +
  labs(x = NULL, y = "Word Count") +
  ggtitle("Popular Words by Review Scores") +
  facet_wrap(~score, scales = "free") +
  scale_x_continuous(  
    breaks = popular_words$row, 
    labels = popular_words$word) +
  coord_flip()
  ggsave("image/Popular_Words_by_Review_Scores.png")
  