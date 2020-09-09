#######Text Mining################

######tidy the summary and text#######

library(stringr)
library(tidytext)
library(tidyverse)
#####tidy the summary and text#######
raw_data<-read_csv("derived_data/tidy_data.csv")
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
class(raw_data$time) <- c('POSIXt','POSIXct')
write_csv(raw_data,"derived_data/clean_data.csv")
summary(raw_data)

####change to data format######

