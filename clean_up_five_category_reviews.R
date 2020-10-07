library(rjson)
library(stringr)
library(jsonlite)
library(dplyr)
#######first adjust the size, planning on do ANOVA, so keep same size 5000####
#######the sequence of the data are ordered by the product###
#######So directly choose the first 5000 data #########
VideoGame<-stream_in(file("source_data/Video_Games_5.json"))
VideoGame_Cut<-VideoGame[1:5000,]
Beauty<-stream_in(file("source_data/All_Beauty_5.json"))
Beauty_Cut<-Beauty[1:5000,]
MovieTV<-stream_in(file("source_data/Movies_and_TV_5.json"))
MovieTV_Cut<-MovieTV[1:5000,]
Outdoor<-stream_in(file("source_data/Sports_and_Outdoors_5.json"))
Outdoor_Cut<-Outdoor[1:5000,]
Food<-read.csv("derived_data/tidy_data.csv")
Food_Cut<-Food[1:5000,]
Food_Cut_Sub<-Food_Cut[c("id","text")]
VideoGame_Cut$id<-seq.int(nrow(VideoGame_Cut))
VideoGame_Cut_Sub<-VideoGame_Cut[c("id","reviewText")]
Beauty_Cut$id<-seq.int(nrow(Beauty_Cut))
Beauty_Cut_Sub<-Beauty_Cut[c("id","reviewText")]
Outdoor_Cut$id<-seq.int(nrow(Outdoor_Cut))
Outdoor_Cut_Sub<-Outdoor_Cut[c("id","reviewText")]
MovieTV_Cut$id<-seq.int(nrow(MovieTV_Cut))
MovieTV_Cut_Sub<-MovieTV_Cut[c("id","reviewText")]
MovieTV_Cut_Sub$Cat<-"MovieTV"
Outdoor_Cut_Sub$Cat<-"Outdoor"
Beauty_Cut_Sub$Cat<-"Beauty"
VideoGame_Cut_Sub$Cat<-"VideoGame"
Food_Cut_Sub$Cat<-"Food"
colnames(Food_Cut_Sub)
names(Food_Cut_Sub)[2]<-"reviewText"
five_cat_merge<-rbind(MovieTV_Cut_Sub,Outdoor_Cut_Sub,Beauty_Cut_Sub,
                       VideoGame_Cut_Sub,Food_Cut_Sub)
write.csv(five_cat_merge,file="derived_data/five_cat_merge.csv")                   

                       