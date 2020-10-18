.PHONY:clean
SHELL:/bin/bash	
	
project1_report.pdf:\
 project1_report.Rmd\
 image/overall_amazon_food_socre_helpfullness.png\
 image/top20_length_review.png\
 image/last20_length_review.png\
 image/review_length_distribution_score_1to5.png\
 image/top_words.png\
 image/Popular_Words_by_Review_Scores.png\
 image/sentiment_match_in_three_database.png\
 image/bing_plot_score.png\
 image/nrc_plot_score.png\
 image/sources_for_documents_for_5_topics.png\
 image/k_means_for_5_topics.png
		Rscript -e "rmarkdown::render('project1_report.Rmd',output_format='pdf_document')"
	
clean:
	rm -f derived_data/*.csv
	rm -f derived_data/*.json
	rm -f derived_data/*.rds
	rm -f image/*.png
	rm -f project1_report.pdf
	
derived_data/tidy_data.csv:\
 source_data/Reviews.csv\
 tidy_data.R
	Rscript tidy_data.R
	
image/Overall_score_distribution.png\
 image/Helpfulness_review.png\
 image/overall_amazon_food_socre_helpfullness.png\
 image/overall_amazon_food_socre_helpfullness.rds:\
 derived_data/tidy_data.csv\
 Overall.R
	Rscript Overall.R
	
derived_data/clean_data.csv:\
 derived_data/tidy_data.csv\
 tidy_text.R
	Rscript tidy_text.R
	
image/top20_length_review.png\
 derived_data/full_word_count.csv\
 image/last20_length_review.png:\
 derived_data/clean_data.csv\
 length_rank.R
	Rscript length_rank.R
	
image/histogram_review_length.png\
 image/distribution_of_review_length_score\=5.png\
 image/distribution_of_review_length_score\=4.png\
 image/distribution_of_review_length_score\=3.png\
 image/distribution_of_review_length_score\=2.png\
 image/distribution_of_review_length_score\=1.png\
 image/review_length_distribution_score_1to5.png:\
 derived_data/full_word_count.csv\
 length_hist.R
	Rscript length_hist.R
	
full_word_count.csv\
 derived_data/review_words_filtered.csv\
 image/top_words.png:\
 derived_data/clean_data.csv\
 top_word.R
	Rscript top_word.R
	
popular_words.csv\
 image/Popular_Words_by_Review_Scores.png:\
 top_words_by_score.R
	Rscript top_words_by_score.R
	
image/lexical_density.png\
 image/lexical_diversity.png\
 derived_data/lex_density_per_score.csv\
 derived_data/lex_diversity_per_score.csv:\
 derived_data/clean_data.csv\
 lexical_density_diversity.R
	Rscript lexical_density_diversity.R
	
image/TF-IDF.png:\
 derived_data/clean_data.csv\
 TF-IDF.R
	Rscript TF-IDF.R
	
derived_data/review_bing.rds\
 derived_data/review_nrc.rds\
 image/sentiment_match_in_three_database.png:\
 derived_data/review_words_filtered.csv\
 sentiment_explore.R
	Rscript sentiment_explore.R
	
image/bing_plot_score.png:\
 derived_data/review_bing.rds\
 bing_sentiment.R
	Rscript bing_sentiment.R
	
image/nrc_plot_score.png:\
 derived_data/review_nrc.rds\
 nrc_sentiment.R
	Rscript nrc_sentiment.R
	
derived_data/five_cat_merge.csv:\
 source_data/Video_Games_5.json\
 source_data/All_Beauty_5.json\
 source_data/Movies_and_TV_5.json\
 source_data/Sports_and_Outdoors_5.json\
 derived_data/tidy_data.csv\
 clean_up_five_category_reviews.R
	Rscript clean_up_five_category_reviews.R
	
derived_data/source_dtm.rds\
 derived_data/source_tidy.rds:\
 derived_data/five_cat_merge.csv\
 topic_modeling_machine_learning.R
	Rscript topic_modeling_machine_learning.R
	
image/sources_for_documents_for_5_topics.png:\
 derived_data/source_dtm.rds\
 derived_data/source_tidy.rds\
 lda_topic_modeling.R
	Rscript lda_topic_modeling.R
	
image/k_means_for_5_topics.png:\
 derived_data/source_dtm.rds\
 derived_data/source_tidy.rds\
 k_means_topic_modeling.R
	Rscript k_means_topic_modeling.R
















