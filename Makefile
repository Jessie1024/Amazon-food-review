

derived_data/tidy_data.csv:\
	source_data/Reviews.csv\
	tidy_data.R
	Rscript tidy_data.R
	
image/Overall_score_distribution.png\
	image/Helpfulness of the review.png:\
	derived_data/tidy_data.csv\
	Overall.R
	Rscript Overall.R
	
derived_data/clean_data.csv:\
	derived_data/tidy_data.csv\
	tidy_text.R
	Rscript tidy_text.R
	
top20 length review.png\
	last20 length review.png\
	derived_data/full_word_count.csv:\
	derived_data/clean_data.csv\
	length_rank.R
	Rscript length_rank.R
	
image/distribution of review length.png\
	image/distribution of review length score=5.png\
	image/distribution of review length score=4.png\
	image/distribution of review length score=3.png\
	image/distribution of review length score=2.png\
	image/distribution of review length score=1.png:\
	derived_data/full_word_count.csv\
	length_rank.R
	Rscript length_rank.R
	
full_word_count.csv\
	top words.png:\
	derived_data/clean_data.csv\
	top_words.R
	Rscript top_words.R
	
	
	
popular_words.csv\
	image/Popular Words by Review Scores.png:\
	top_words_by_score.R
	Rscipt top_words_by_score.R
	
	
