library(tidyverse)
library(stringr)
full_word_count<-read_csv("derived_data/full_word_count.csv")

#####make histogram of the length distribution among score##
as.factor(full_word_count $score)

full_word_count %>%
  ggplot(aes(x = num_words)) +
  geom_histogram(aes(fill="word count per review")) +
  ylim(0, 350)+
  xlim(500,3500)+
  ggtitle("Word Count Distribution") +
  ggsave("image/distribution of review length.png")

score5<-full_word_count[which(full_word_count$score=="5"),]
score4<-full_word_count[which(full_word_count$score=="4"),]
score3<-full_word_count[which(full_word_count$score=="3"),]
score2<-full_word_count[which(full_word_count$score=="2"),]
score1<-full_word_count[which(full_word_count$score=="1"),]

score5%>%
  ggplot(aes(x = num_words)) +
  geom_histogram(aes(fill="red ")) +
  ylim(0, 350)+
  xlim(500,3500)+
  ggtitle("Word Count Distribution for score=5")+
 ggsave("image/distribution of review length score=5.png")
score4%>%
  ggplot(aes(x = num_words)) +
  geom_histogram(aes(fill="red")) +
  ylim(0, 350)+
  xlim(500,3500)+
  ggtitle("Word Count Distribution for score=4")+
  ggsave("image/distribution of review length score=4.png") 

score3%>%
  ggplot(aes(x = num_words)) +
  geom_histogram(aes(fill="red")) +
  ylim(0, 350)+
  xlim(500,3500)+
  ggtitle("Word Count Distribution for score=3")+
  ggsave("image/distribution of review length score=3.png") 

score2%>%
  ggplot(aes(x = num_words)) +
  geom_histogram(aes(fill="red")) +
  ylim(0, 350)+
  xlim(500,3500)+
  ggtitle("Word Count Distribution for score=2")+
  ggsave("image/distribution of review length score=2.png") 

score1%>%
  ggplot(aes(x = num_words)) +
  geom_histogram(aes(fill="red")) +
  ylim(0, 350)+
  xlim(500,3500)+
  ggtitle("Word Count Distribution for score=1")+
  ggsave("image/distribution of review length score=1.png") 

