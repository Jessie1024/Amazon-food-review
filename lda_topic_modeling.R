library(tidytext) 
library(topicmodels) 
library(tidyr) 
library(dplyr) 
library(ggplot2) 
library(kableExtra) 
library(knitr) 
library(gridExtra)
library(formattable) 
library(tm) 
library(plotly) 
library(tidyverse)
library(quanteda)
library(reshape2)
library(stringr)
library(ggrepel)
my_colors <- c("#66C2A5", "#FC8D62", "#8DA0C", "#E78AC3", "#A6D854", "#FFD92F")

#customize ggplot2's default theme settings
#this tutorial doesn't actually pass any parameters, but you may use it again in future tutorials so it's nice to have the options
theme_lyrics <- function(aticks = element_blank(),
                         pgminor = element_blank(),
                         lt = element_blank(),
                         lp = "none")
{
  theme(plot.title = element_text(hjust = 0.5), #center the title
        axis.ticks = aticks, #set axis ticks to on or off
        panel.grid.minor = pgminor, #turn on or off the minor grid lines
        legend.title = lt, #turn on or off the legend title
        legend.position = lp) #turn on or off the legend
}

#customize the text tables for consistency using HTML formatting
my_kable_styling <- function(dat, caption) {
  kable(dat, "html", escape = FALSE, caption = caption) %>%
    kable_styling(bootstrap_options = c("striped", "condensed", "bordered"),
                  full_width = FALSE)
}

word_chart <- function(data, input, title) {
  data %>%
    #set y = 1 to just plot one variable and use word as the label
    ggplot(aes(as.factor(row), 1, label = input, fill = factor(topic) )) +
    #you want the words, not the points
    geom_point(color = "transparent") +
    #make sure the labels don't overlap
    geom_label_repel(nudge_x = .2,  
                     direction = "y",
                     box.padding = 0.1,
                     segment.color = "transparent",
                     size = 3) +
    facet_grid(~topic) +
    theme_lyrics() +
    theme(axis.text.y = element_blank(), axis.text.x = element_blank(),
          #axis.title.x = element_text(size = 9),
          panel.grid = element_blank(), panel.background = element_blank(),
          panel.border = element_rect("lightgray", fill = NA),
          strip.text.x = element_text(size = 9)) +
    labs(x = NULL, y = NULL, title = title) +
    #xlab(NULL) + ylab(NULL) +
    #ggtitle(title) +
    coord_flip()
}


source_dtm<-readRDS("derived_data/source_dtm.rds")
source_tidy<-readRDS("derived_data/source_tidy.rds")

###fit the model###
k<-5
seed<-1234
lda <- LDA(source_dtm, k = k, method = "GIBBS", control = list(seed = seed))
class(lda)

tidy<-tidy(lda, matrix = "beta")

write_csv(tidy,"derived_data/5topic.csv")

num_words <- 10 #number of words to visualize

#create function that accepts the lda model and num word to display
top_terms_per_topic <- function(lda_model, num_words) {
  
  #tidy LDA object to get word, topic, and probability (beta)
  topics_tidy <- tidy(lda_model, matrix = "beta")
  
  
  top_terms <- topics_tidy %>%
    group_by(topic) %>%
    arrange(topic, desc(beta)) %>%
    #get the top num_words PER topic
    slice(seq_len(num_words)) %>%
    arrange(topic, beta) %>%
    #row is required for the word_chart() function
    mutate(row = row_number()) %>%
    ungroup() %>%
    #add the word Topic to the topic labels
    mutate(topic = paste("Topic", topic, sep = " "))
  #create a title to pass to word_chart
  title <- paste("LDA Top Terms for", k, "Topics")
  #call the word_chart function you built in prep work
  word_chart(top_terms, top_terms$term, title)
}
#call the function you just built!
lda_top_term_for_5_topics<-top_terms_per_topic(lda, num_words)
ggsave(filename = "image/lda_top_term_for_5_topics.png"
       ,plot=last_plot())
###top document###
number_of_documents = 5 #number of top docs to view
title <- paste("LDA Top Documents for", k, "Topics")

#create tidy form showing topic, document and its gamma value
topics_tidy <- tidy(lda, matrix = "gamma")

#same process as used with the top words
top_documents <- topics_tidy %>%
  group_by(topic) %>%
  arrange(topic, desc(gamma)) %>%
  slice(seq_len(number_of_documents)) %>%
  arrange(topic, gamma) %>%
  mutate(row = row_number()) %>%
  ungroup() %>%
  #re-label topics
  mutate(topic = paste("Topic", topic, sep = " "))

title <- paste("LDA Top Documents for", k, "Topics")
word_chart(top_documents, top_documents$document, title)+
  ggsave(filename = "image/lda_top_Doc_for_5_topics.png")
####identify source from topic####
title <- paste("Sources for Top Documents for", k, "Topics")

topics_tidy <- tidy(lda, matrix = "gamma")

names(source_tidy)[3] <- "document"
as.integer(source_tidy$document)

as.integer(top_documents$document)
write.csv(top_documents,"derived_data/top_documents.csv")
write.csv(source_tidy,"derived_data/source_tidy.csv")
#join back to the tidy form to get the source field
top_documents<-read_csv("derived_data/top_documents.csv")
source_tidy<-read_csv("derived_data/source_tidy.csv")

top_sources <-inner_join(top_documents,source_tidy, by="document") %>%
  select(document,cat, topic) %>%
  distinct() %>%
  group_by(topic) %>%
  mutate(row = row_number()) %>%
  ungroup()

word_chart(top_sources, top_sources$cat, title)+
  ggsave(filename = "image/sources_for_documents_for_5_topics.png")
