library(dplyr)
library(tidyverse)
library(knitr)
library(kableExtra)
library(formattable)
library(stringr)
library(tidytext)
my_colors <- c("#E69F00", "#56B4E9", "#009E73", "#CC79A7", "#D55E00")

theme_lyrics <- function( ) 
  { 
  theme(plot.title = element_text(hjust = 0.5),
        axis.text.x = element_blank(), 
        axis.ticks = element_blank(),
        panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        legend.position = "none")
  }

raw_data<-read_csv("derived_data/clean_data.csv")

lex_diversity_per_score <- raw_data %>%
  filter(score != "NA") %>%
  unnest_tokens(word, text) %>%
  group_by(id,score) %>%
  summarise(lex_diversity = n_distinct(word)) %>%
  arrange(desc(lex_diversity)) 

write_csv(lex_diversity_per_score, "derived_data/lex_diversity_per_score.csv")
diversity_plot <- lex_diversity_per_score %>%
  ggplot(aes(score, lex_diversity)) +
  geom_point(color = my_colors[3],
             alpha = .4, 
             size = 4, 
             position = "jitter") + 
  stat_smooth(color = "black", se = FALSE, method = "lm") +
  geom_smooth(aes(x = score, y = lex_diversity), se = FALSE,
              color = "blue", lwd = 2) +
  ggtitle("Lexical Diversity of Reviews") +
  xlab("score from 1 to 5") + 
  ylab("unique words per review") +
  scale_color_manual(values = my_colors) +
  theme_classic() + 
  theme_lyrics()+
  ggsave("image/lexical_diversity.png")

diversity_plot

#####lexical_density###############
lex_density_per_year <- raw_data %>%
  filter(score != "NA") %>%
  unnest_tokens(word, text) %>%
  group_by(id,score) %>%
  summarise(lex_density = n_distinct(word)/n()) %>%
  arrange(desc(lex_density))

write_csv(lex_density_per_year, "derived_data/lex_density_per_score.csv")
density_plot <- lex_density_per_year %>%
  ggplot(aes(score, lex_density)) + 
  geom_point(color = my_colors[4],
             alpha = .4, 
             size = 4, 
             position = "jitter") + 
  stat_smooth(color = "black", 
              se = FALSE, 
              method = "lm") +
  geom_smooth(aes(x = score, y = lex_density), 
              se = FALSE,
              color = "blue", 
              lwd = 2) +
  ggtitle("Lexical Density") + 
  xlab("") + 
  ylab("") +
  scale_color_manual(values = my_colors) +
  theme_classic() + 
  theme_lyrics()+
  ggsave("image/lexical_density.png")


density_plot







