#####overall score distribution#############
library(tidyverse);
raw_data<-read_csv("derived_data/tidy_data.csv")
overall_hist<-ggplot(raw_data, aes(x=raw_data$score))+
  geom_histogram(binwidth=1,fill="#69b3a2", color="#e9ecef", alpha=0.9)+
  ggtitle("Histogram of Amazon food review score distribution")+
  xlab("Score")
ggsave("image/Overall_score_distribution.png", plot = overall_hist)

#####overall helpfulness##############
help_hist<-ggplot(raw_data, aes(x=raw_data$helpfulnessnumerator))+
  geom_histogram(color="black",fill="white", alpha=0.5)+
  xlim(0,20)+
  stat_bin(bins=30)+
  ylim(0,1.5e+05)+
  ggtitle("Histogram of Amazom foor review helpfullness distribution")+
  xlab("Helpfulness of the review")
ggsave("image/Helpfulness of the review.png", plot=help_hist)
##This does not make sense.....#######
