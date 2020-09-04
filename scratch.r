#####Part One: text mining and exploratory analysis
library(tidyverse);
raw_data<-read_csv("source_data/Reviews.csv")

#####tidyverse the dataset##########
library(stringr)
names(raw_data)<-names(raw_data) %>%
  tolower() %>%
  str_replace_all ("-", " ") %>%
  str_replace_all (" ", "_");

#####overall score distribution#############
overall_hist<-ggplot(raw_data, aes(x=raw_data$score))+
  geom_histogram(binwidth=1,fill="#69b3a2", color="#e9ecef", alpha=0.9)+
  ggtitle("Histogram of Amazon food review score distribution")+
  xlab("Score")
ggsave("bios611-project1/image/Overall_score_distribution.png", plot = overall_hist)

#####overall helpfulness##############
help_hist<-ggplot(raw_data, aes(x=raw_data$helpfulnessnumerator))+
  geom_histogram(color="black",fill="white", alpha=0.5)+
  xlim(0,20)+
  stat_bin(bins=30)+
  ylim(0,1.5e+05)+
  ggtitle("Histogram of Amazom foor review helpfullness distribution")+
  xlab("Helpfulness of the review")
ggsave("bios611-project1/image/Helpfulness of the review.png", plot=help_hist)
##This does not make sense.....#######


####Top 20 food################

####first group by productid#######
sub_data<-raw_data[c(2,7)]
library(dplyr)
sub_data<-sub_data %>%
  group_by(productid)%>%
  summarise_at(vars(score), mean, na.rm=T)%>%
  arrange(desc(
    score
  ))

####This shows that top 20 does not exist...so instead use another histogram

Average_hist<-ggplot(sub_data, aes(x=score))+
  geom_histogram(binwidth=1,fill="#FF6C90", color="#FF6C90", alpha=0.9)+
  ggtitle("Histogram of Amazon food average review score")+
  xlab("Average Score")
ggsave("bios611-project1/image/Average_score_distribution.png", plot = Average_hist)

#######Text Mining################

######tidy the summary and text#######

library(stringr)
library(tidytext)

#####tidy the summary and text#######
raw_data$summary<-raw_data$summary%>%
  tolower() %>%
  str_replace_all (",", " ") %>%
  str_replace_all ("-", " ") %>%
  str_replace_all ("&", " ") %>%
  str_replace_all ("!", " ") 

raw_data$text<-raw_data$text%>%
  tolower() %>%
  str_replace_all (",", " ") %>%
  str_replace_all ("-", " ") %>%
  str_replace_all ("&", " ") %>%
  str_replace_all ("!", " ") 

####expand the contractions##########
fix.contractions<-function(doc){
  doc<-gsub("won't", "will not", doc)
  doc<-gsub("can't", "can not", doc)
  doc<-gsub("n't", " not", doc)
  doc<-gsub("'ll", " will", doc)
  doc<-gsub("'re", " are", doc)
  doc<-gsub("'ve", " have", doc)
  doc<-gsub("'m", " am", doc)
  doc<-gsub("'d", "would", doc)
  
  return(doc)
}

raw_data$summary<-sapply(raw_data$summary,fix.contractions)
raw_data$text<-sapply(raw_data$text, fix.contractions)

write_csv(raw_data,"derived_data/clean_data.csv")
summary(raw_data)

####change to data format######
class(raw_data$time) <- c('POSIXt','POSIXct')

####Word Frequency#############
full_word_count<-raw_data %>%
  unnest_tokens(word,text) %>%
  group_by(id,productid, summary,score) %>%
  summarise(num_words=n()) %>%
  arrange(desc(num_words))

full_word_count[1:10,] %>%
  ungroup(num_)


