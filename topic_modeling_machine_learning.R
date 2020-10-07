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
#####some function that may use#########
#define some colors to use throughout
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

#############LDA for five categories#############################
###tidy the head###
five_cat_raw<-read.csv("derived_data/five_cat_merge.csv")
names(five_cat_raw)<-names(five_cat_raw) %>%
  tolower() %>%
  str_replace_all ("-", " ") %>%
  str_replace_all (" ", "_");

###tidy the text###

five_cat_raw$reviewtext<-five_cat_raw$reviewtext%>%
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
  doc<-gsub("'s", "", doc)
  return(doc)
}

five_cat_raw$reviewtext<-sapply(five_cat_raw$reviewtext, fix.contractions)
five_cat_raw<-select(five_cat_raw,-1)
five_cat_raw$doc<-seq.int(nrow(five_cat_raw))
###dataset by word###
five_cat_by_word <- five_cat_raw %>%
  unnest_tokens(word,reviewtext) %>%
  anti_join(stop_words) %>%
  distinct() %>%
  filter(nchar(word) > 3) 

###Create the Document-Term-Matrix###

dtm<-five_cat_by_word %>%
  count(doc, word,sort=T)%>%
  ungroup()%>%
  cast_dfm(doc,word,n)

###set var###
source_dtm<-dtm
source_tidy<-five_cat_by_word
saveRDS(source_dtm, "derived_data/source_dtm.rds")
saveRDS(source_tidy, "derived_data/source_tidy.rds")


