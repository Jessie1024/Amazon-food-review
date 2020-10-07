review_nrc<-readRDS("derived_data/review_nrc.rds")

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
  ggtitle("Overall") +
  coord_flip()+
  ggsave("image/review_nrc_sentiment.png")

review_nrc_5<- review_words_filtered %>%
  inner_join(get_sentiments("nrc"))%>%
  filter(score==5)

review_nrc_4<- review_words_filtered %>%
  inner_join(get_sentiments("nrc"))%>%
  filter(score==4)

review_nrc_3<- review_words_filtered %>%
  inner_join(get_sentiments("nrc"))%>%
  filter(score==3)

review_nrc_2<- review_words_filtered %>%
  inner_join(get_sentiments("nrc"))%>%
  filter(score==2)

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
  ggtitle("Score=5") +
  coord_flip()



nrc_plot_4 <- review_nrc_4 %>%
  group_by(sentiment) %>%
  summarise(word_count = n()) %>%
  ungroup() %>%
  mutate(sentiment = reorder(sentiment, word_count)) %>%
  #Use `fill = -word_count` to make the larger bars darker
  ggplot(aes(sentiment, word_count, fill = -word_count)) +
  geom_col() +
  guides(fill = FALSE) + #Turn off the legend
  labs(x = NULL, y = "Word Count") +
  scale_y_continuous(limits = c(0, 500000)) + #Hard code the axis limit
  ggtitle("Score=4 ") +
  coord_flip()

nrc_plot_3 <- review_nrc_3 %>%
  group_by(sentiment) %>%
  summarise(word_count = n()) %>%
  ungroup() %>%
  mutate(sentiment = reorder(sentiment, word_count)) %>%
  #Use `fill = -word_count` to make the larger bars darker
  ggplot(aes(sentiment, word_count, fill = -word_count)) +
  geom_col() +
  guides(fill = FALSE) + #Turn off the legend
  labs(x = NULL, y = "Word Count") +
  scale_y_continuous(limits = c(0, 200000)) + #Hard code the axis limit
  ggtitle("Score=3 ") +
  coord_flip()

nrc_plot_2 <- review_nrc_2 %>%
  group_by(sentiment) %>%
  summarise(word_count = n()) %>%
  ungroup() %>%
  mutate(sentiment = reorder(sentiment, word_count)) %>%
  #Use `fill = -word_count` to make the larger bars darker
  ggplot(aes(sentiment, word_count, fill = -word_count)) +
  geom_col() +
  guides(fill = FALSE) + #Turn off the legend
  labs(x = NULL, y = "Word Count") +
  scale_y_continuous(limits = c(0, 100000)) + #Hard code the axis limit
  ggtitle("Score=2 ") +
  coord_flip()

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
  ggtitle("score=1 ") +
  coord_flip()

nrc_plot_score_1to5<-grid.arrange(nrc_plot, nrc_plot_1,nrc_plot_2,
                                  nrc_plot_3,nrc_plot_4,nrc_plot_5,
                                  nrow=3, top="NRC sentiment analysis distribution among scores")
ggsave(nrc_plot_score_1to5, file="image/nrc_plot_score.png")
