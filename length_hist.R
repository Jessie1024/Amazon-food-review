library(tidyverse)
library(stringr)
library(gridExtra)
library(ggplot2)
full_word_count<-read_csv("derived_data/full_word_count.csv")

#####make histogram of the length distribution among score##
as.factor(full_word_count $score)

full_word_count %>%
  ggplot(aes(x = num_words)) +
  geom_histogram(aes(fill="word count per review")) +
  ylim(0, 350)+
  xlim(500,3500)+
  ggtitle("Word Count Distribution") +
  ggsave("image/histogram_review_length.png")

score5<-full_word_count[which(full_word_count$score=="5"),]
score4<-full_word_count[which(full_word_count$score=="4"),]
score3<-full_word_count[which(full_word_count$score=="3"),]
score2<-full_word_count[which(full_word_count$score=="2"),]
score1<-full_word_count[which(full_word_count$score=="1"),]

score_5<-score5%>%
  ggplot(aes(x = num_words)) +
  geom_histogram(binwidth=50,fill="chartreuse") +
  ylim(0, 40)+
  xlim(500,3000)+
  ggtitle("score=5")+
 ggsave("image/distribution_of_review_length_score=5.png")

score_4<-score4%>%
  ggplot(aes(x = num_words)) +
  geom_histogram(binwidth=50,fill="cornflowerblue") +
  ylim(0, 350)+
  xlim(300,2000)+
  ggtitle("score=4")+
  ggsave("image/distribution_of_review_length_score=4.png") 

score_3<-score3%>%
  ggplot(aes(x = num_words)) +
  geom_histogram(binwidth=50,fill="burlywood3") +
  ylim(0, 100)+
  xlim(500,1500)+
  ggtitle("score=3")+
  ggsave("image/distribution_of_review_length_score=3.png") 

score_2<-score2%>%
  ggplot(aes(x = num_words)) +
  geom_histogram(binwidth=50,fill="brown4") +
  ylim(0, 50)+
  xlim(500,1500)+
  ggtitle("score=2")+
  ggsave("image/distribution_of_review_length_score=2.png") 

score_1<-score1%>%
  ggplot(aes(x = num_words)) +
  geom_histogram(binwidth=50,fill="brown1") +
  ylim(0, 40)+
  xlim(500,2000)+
  ggtitle("score=1")+
  ggsave("image/distribution_of_review_length_score=1.png") 

score_1to5<-grid.arrange(
  score_1, 
  score_2,
  score_3,
  score_4, 
  score_5, 
  nrow=2,
  top="review length distribution score 1 to 5"
)

ggsave(score_1to5,file="image/review_length_distribution_score_1to5.png")





