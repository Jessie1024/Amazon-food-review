#####Part One: text mining and exploratory analysis
library(tidyverse);
raw_data<-read_csv("source_data/Reviews.csv")

#####tidyverse the dataset##########
library(stringr)
names(raw_data)<-names(raw_data) %>%
  tolower() %>%
  str_replace_all ("-", " ") %>%
  str_replace_all (" ", "_");
tidy_data<-write.csv(raw_data, "derived_data/tidy_data.csv")
