library(dplyr)
library(tidyverse)
library(knitr)
library(kableExtra)
library(formattable)
library(stringr)
library(tidytext)
webshot::install_phantomjs()

raw_data<-read_csv("derived_data/clean_data.csv")
#####review length rank by id####
full_word_count<-raw_data %>%
  unnest_tokens(word, text) %>%
  group_by(id, summary,score) %>%
  summarise(num_words=n()) %>%
  arrange(desc(num_words))

full_word_count<-write_csv(full_word_count,"derived_data/full_word_count.csv")
#####top20 graph#####3
  full_word_count[1:23,] %>%
  ungroup(num_words, id, summary,score) %>%
  mutate(num_words=color_bar("lightblue")(num_words))%>%
  mutate(id=color_tile("lightpink", "lightpink")(id))%>%
  kable("html", escape=FALSE, align = "c",caption = "Top 20 amazon food reviews 
        with Highest Word Count") %>%
  kable_styling(bootstrap_options = 
                  c("striped", "condensed", "bordered"), 
                full_width = FALSE)%>%
  save_kable("image/top20 length review.png")
  
  #######least20 graph#######
  
  full_word_count[268434:268454,]%>% 
    ungroup(num_words, id, summary,score) %>%
    mutate(num_words=color_bar("lightblue")(num_words))%>%
    mutate(id=color_tile("lightpink", "lightpink")(id))%>%
    kable("html", escape=FALSE, align = "c",caption = "Last 20 amazon food reviews 
        with Highest Word Count") %>%
    kable_styling(bootstrap_options = 
                    c("striped", "condensed", "bordered"), 
                  full_width = FALSE)%>%
    save_kable("image/last20 length review.png")
  
  
  
  
  
  
  
  
