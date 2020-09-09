#Define some colors to use throughout
my_colors <- c("#E69F00", "#56B4E9", "#009E73", "#CC79A7", "#D55E00", "#D65E00")

#Customize ggplot2's default theme settings
#This tutorial doesn't actually pass any parameters, but you may use it again in future tutorials so it's nice to have the options

{
  theme(plot.title = element_text(hjust = 0.5), #Center the title
        axis.ticks = aticks, #Set axis ticks to on or off
        panel.grid.minor = pgminor, #Turn the minor grid lines on or off
        legend.title = lt, #Turn the legend title on or off
        legend.position = lp) #Turn the legend on or off
}

#Customize the text tables for consistency using HTML formatting
my_kable_styling <- function(dat, caption) {
  kable(dat, "html", escape = FALSE, caption = caption) %>%
    kable_styling(bootstrap_options = c("striped", "condensed", "bordered"),
                  full_width = FALSE)
}

library(tidytext)
library(stringr)
library(textdata)
library(dplyr)
library(tidyr)
library(formattable)
library(knitr)
library(kableExtra)
library(tidyverse)


bing <- get_sentiments("bing") %>% 
  mutate(lexicon = "bing", 
         words_in_lexicon = n_distinct(word))    

nrc <- get_sentiments("nrc") %>% 
  mutate(lexicon = "nrc", 
         words_in_lexicon = n_distinct(word))

afinn <- get_sentiments("afinn") %>% 
  mutate(lexicon = "afinn", 
         words_in_lexicon = n_distinct(word))

new_sentiments <- bind_rows(afinn, bing, nrc)


new_sentiments <- new_sentiments %>% #From the tidytext package
  mutate( sentiment = ifelse(lexicon == "AFINN" & value >= 0, "positive",
                             ifelse(lexicon == "AFINN" & value < 0,
                                    "negative", sentiment))) %>%
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

review_bing <- review_words_filtered %>%
  inner_join(get_sentiments("bing"))

bing_plot <- review_bing %>%
  group_by(sentiment) %>%
  summarise(word_count = n()) %>%
  ungroup() %>%
  mutate(sentiment = reorder(sentiment, word_count)) %>%
  ggplot(aes(sentiment, word_count, fill = sentiment)) +
  geom_col() +
  guides(fill = FALSE) +
  labs(x = NULL, y = "Word Count") +
  scale_y_continuous(limits = c(0, 1500000)) +
  ggtitle("Review Bing Sentiment") +
  coord_flip()+
  ggsave("image/review_bing_sentiment.png")


review_nrc <- review_words_filtered %>%
  inner_join(get_sentiments("nrc"))



nrc_plot <- review_nrc %>%
  group_by(sentiment) %>%
  summarise(word_count = n()) %>%
  ungroup() %>%
  mutate(sentiment = reorder(sentiment, word_count)) %>%
  #Use `fill = -word_count` to make the larger bars darker
  ggplot(aes(sentiment, word_count, fill = -word_count)) +
  geom_col() +
  guides(fill = FALSE) + #Turn off the legend
  labs(x = NULL, y = "Word Count") +
  scale_y_continuous(limits = c(0, 2000000)) + #Hard code the axis limit
  ggtitle("Review NRC Sentiment") +
  coord_flip()+
  ggsave("image/review_nrc_sentiment.png")

review_nrc_5<- review_words_filtered %>%
  inner_join(get_sentiments("nrc"))%>%
  filter(score==5)

nrc_plot_5 <- review_nrc_5 %>%
  group_by(sentiment) %>%
  summarise(word_count = n()) %>%
  ungroup() %>%
  mutate(sentiment = reorder(sentiment, word_count)) %>%
  #Use `fill = -word_count` to make the larger bars darker
  ggplot(aes(sentiment, word_count, fill = -word_count)) +
  geom_col() +
  guides(fill = FALSE) + #Turn off the legend
  labs(x = NULL, y = "Word Count") +
  scale_y_continuous(limits = c(0, 1500000)) + #Hard code the axis limit
  ggtitle("Positive Review NRC Sentiment ") +
  coord_flip()+
  ggsave("image/score5review_nrc_sentiment.png")


review_nrc_1<- review_words_filtered %>%
  inner_join(get_sentiments("nrc"))%>%
  filter(score==1)

nrc_plot_1 <- review_nrc_1 %>%
  group_by(sentiment) %>%
  summarise(word_count = n()) %>%
  ungroup() %>%
  mutate(sentiment = reorder(sentiment, word_count)) %>%
  #Use `fill = -word_count` to make the larger bars darker
  ggplot(aes(sentiment, word_count, fill = -word_count)) +
  geom_col() +
  guides(fill = FALSE) + #Turn off the legend
  labs(x = NULL, y = "Word Count") +
  scale_y_continuous(limits = c(0, 150000)) + #Hard code the axis limit
  ggtitle("Negative Review NRC Sentiment ") +
  coord_flip()+
  ggsave("image/score1review_nrc_sentiment.png")


