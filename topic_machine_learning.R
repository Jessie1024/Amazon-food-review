library(tidyverse) #tidyr, #dplyr, #magrittr, #ggplot2
library(tidytext) #unnesting text into single words
library(mlr) #machine learning framework for R
library(kableExtra) #create attractive tables
library(dplyr)
library(stringr)
my_colors<-c("skyblue1","seagreen1","pink1","slateblue","salmon")

my_kable_styling <- function(dat, caption) {
  kable(dat, "html", escape = FALSE, caption = caption) %>%
    kable_styling(bootstrap_options = c( "condensed", "bordered"),
                  full_width = FALSE)
}
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

#feature engineering

number_of_words=10000

top_words_per_cat<-five_cat_by_word %>%
  group_by(cat)%>%
  mutate(cat_word_count=n())%>%
  group_by(cat,word)%>%
  mutate(word_count=n(),
         word_pct=word_count/cat_word_count*100)%>%
  select(word,cat,cat_word_count,word_count, word_pct)%>%
  distinct()%>%
  ungroup()%>%
  arrange(desc(word_pct))%>%
  top_n(number_of_words)%>%
  select(cat,word,word_pct)


#remove words that are in more than one cat
top_words <- top_words_per_cat %>%
  ungroup() %>%
  group_by(word) %>%
  mutate(multi_cat = n()) %>%
  filter(multi_cat< 2) %>%
  select(cat, top_word = word)

#create lists of the top words per cat
beauty_words <- lapply(top_words[top_words$cat == "Beauty",], as.character)
videogame_words <- lapply(top_words[top_words$cat == "VideoGame",], as.character)
food_words <- lapply(top_words[top_words$cat == "Food",], as.character)
outdoor_words <- lapply(top_words[top_words$cat == "Outdoor",], as.character)
movietv_words <- lapply(top_words[top_words$cat == "MovieTV",], as.character)

#splitting data
smp_siz<-floor(0.75*nrow(top_words))
set.seed(123)
train_ind<-sample(seq_len(nrow(top_words)),size=smp_siz)
train<-top_words[train_ind,]
test<-top_words[-train_ind,]


#Feature Engineering
features_func_cat <- function(data) {
  features <- data %>%
    mutate(word_frequency = n(),
           lexical_diversity = n_distinct(word),
           lexical_density = lexical_diversity/word_frequency,
           repetition = word_frequency/lexical_diversity,
           document_avg_word_length = mean(nchar(word)),
           title_word_count = lengths(gregexpr("[A-z]\\W+",
                                               document)) + 1L,
           title_length = nchar(document),
           large_word_count =
             sum(ifelse((nchar(word) > 7), 1, 0)),
           small_word_count =
             sum(ifelse((nchar(word) < 3), 1, 0)),
           #assign more weight to these words using "10" below
           explicit_word_count =
             sum(ifelse(word %in% explicit_words$explicit_word,10,0)),
           #assign more weight to these words using "20" below
           book_word_count =
             sum(ifelse(word %in% book_words$top_word,20,0)),
           christian_word_count =
             sum(ifelse(word %in% christian_words$top_word,1,0)),
           country_word_count =
             sum(ifelse(word %in% country_words$top_word,1,0)),
           hip_hop_word_count =
             sum(ifelse(word %in% hip_hop_words$top_word,1,0)),
           pop_rock_word_count =
             sum(ifelse(word %in% pop_rock_words$top_word,1,0))
    ) %>%
    select(-word) %>%
    distinct() %>% #to obtain one record per document
    ungroup()
  
  features$genre <- as.factor(features$genre)
  return(features)
}



#normalization
task_train_subset<-normalizeFeatures(top_words,method = "standardize",
                                     col=NULL,range = c(0,1), on.constant = "quiet")










