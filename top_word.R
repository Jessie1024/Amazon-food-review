library(dplyr)
library(tidyverse)
library(knitr)
library(kableExtra)
library(formattable)
library(stringr)
library(tidytext)

head(sample(stop_words$word, 15), 15)

clean_data<-read_csv("derived_data/clean_data.csv")

####filter the dataset to word
review_words_filtered <- clean_data %>%
  unnest_tokens(word,text) %>%
  anti_join(stop_words) %>%
  distinct() %>%
  filter(nchar(word) > 3) 
 
write_csv(review_words_filtered, "derived_data/review_words_filtered.csv")


review_words_filtered %>%
  count(word, sort = TRUE) %>%
  top_n(10) %>%
  ungroup() %>%
  mutate(word = reorder(word, n)) %>%
  ggplot() +
  geom_col(aes(word, n), fill="#00BDD0") +
  theme(legend.position = "none", 
        plot.title = element_text(hjust = 0.5),
        panel.grid.major = element_blank()) +
  xlab("") + 
  ylab("Word Count in review") +
  ggtitle("Most Frequently Used Words in Reviews") +
  coord_flip()+
  ggsave("image/top words.png")