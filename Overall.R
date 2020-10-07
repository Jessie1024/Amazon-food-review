#####overall score distribution#############
library(tidyverse)
library(gridExtra)
raw_data<-read_csv("derived_data/tidy_data.csv")
overall_hist<-ggplot(raw_data, aes(x=raw_data$score))+
  geom_histogram(binwidth=1,fill="#69b3a2", color="#e9ecef", alpha=0.9)+
  xlab("Score")+
 ggsave("image/Overall_score_distribution.png")

#####overall helpfulness##############
help_hist<-ggplot(raw_data, aes(x=raw_data$helpfulnessnumerator))+
  geom_histogram(binwidth=1,fill="darkolivegreen1",alpha=0.8)+
  xlim(0,20)+
  ylim(0,1.5e+05)+
  xlab("Helpfulness")+
  ggsave("image/Helpfulness_review.png")

#combine the two

overall<-grid.arrange(
  overall_hist,
  help_hist,
  nrow=1,
  top="Amazon food review score and helpfulness"
)
ggsave(overall,file="image/overall_amazon_food_socre_helpfullness.png")

  saveRDS(overall,file= "image/overall_amazon_food_socre_helpfullness.rds")











