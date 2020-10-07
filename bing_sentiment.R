review_bing<-readRDS("derived_data/review_bing.rds")

review_bing_1<-review_bing  %>% filter(review_bing$score==1)
review_bing_2<-review_bing  %>% filter(review_bing$score==2)
review_bing_3<-review_bing  %>% filter(review_bing$score==3)
review_bing_4<-review_bing  %>% filter(review_bing$score==4)
review_bing_5<-review_bing  %>% filter(review_bing$score==5)


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
  ggtitle("Overall") +
  coord_flip()+
  theme(aspect.ratio=1/2)+
  ggsave("image/review_bing_sentiment.png")


bing_plot_1 <- review_bing_1 %>%
  group_by(sentiment) %>%
  summarise(word_count = n()) %>%
  ungroup() %>%
  mutate(sentiment = reorder(sentiment, word_count)) %>%
  ggplot(aes(sentiment, word_count, fill = sentiment)) +
  geom_col() +
  guides(fill = FALSE) +
  labs(x = NULL, y = "Word Count") +
  scale_y_continuous(limits = c(0, 200000)) +
  ggtitle("Score=1") +
  coord_flip()+
  theme(aspect.ratio=1/2)

bing_plot_2 <- review_bing_2 %>%
  group_by(sentiment) %>%
  summarise(word_count = n()) %>%
  ungroup() %>%
  mutate(sentiment = reorder(sentiment, word_count)) %>%
  ggplot(aes(sentiment, word_count, fill = sentiment)) +
  geom_col() +
  guides(fill = FALSE) +
  labs(x = NULL, y = "Word Count") +
  scale_y_continuous(limits = c(0, 100000)) +
  ggtitle("Score=2") +
  coord_flip()+
  theme(aspect.ratio=1/2)


bing_plot_3 <- review_bing_3 %>%
  group_by(sentiment) %>%
  summarise(word_count = n()) %>%
  ungroup() %>%
  mutate(sentiment = reorder(sentiment, word_count)) %>%
  ggplot(aes(sentiment, word_count, fill = sentiment)) +
  geom_col() +
  guides(fill = FALSE) +
  labs(x = NULL, y = "Word Count") +
  scale_y_continuous(limits = c(0, 100000)) +
  ggtitle("Score=3") +
  coord_flip()+
  theme(aspect.ratio=1/2)

bing_plot_4 <- review_bing_4 %>%
  group_by(sentiment) %>%
  summarise(word_count = n()) %>%
  ungroup() %>%
  mutate(sentiment = reorder(sentiment, word_count)) %>%
  ggplot(aes(sentiment, word_count, fill = sentiment)) +
  geom_col() +
  guides(fill = FALSE) +
  labs(x = NULL, y = "Word Count") +
  scale_y_continuous(limits = c(0, 250000)) +
  ggtitle("Score=4") +
  coord_flip()+
  theme(aspect.ratio=1/2)

bing_plot_5 <- review_bing_5 %>%
  group_by(sentiment) %>%
  summarise(word_count = n()) %>%
  ungroup() %>%
  mutate(sentiment = reorder(sentiment, word_count)) %>%
  ggplot(aes(sentiment, word_count, fill = sentiment)) +
  geom_col() +
  guides(fill = FALSE) +
  labs(x = NULL, y = "Word Count") +
  scale_y_continuous(limits = c(0, 1000000)) +
  ggtitle("Score=5") +
  coord_flip()+
  theme(aspect.ratio=1/2)

bing_plot_score_1to5<-grid.arrange(bing_plot,bing_plot_1,bing_plot_2,
                                   bing_plot_3,bing_plot_4,bing_plot_5,
                                   nrow=3,top="bing sentiment distribution in different scores"
                                   )

ggsave(bing_plot_score_1to5, file="image/bing_plot_score.png")
