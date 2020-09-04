

derived_data/clean_food_review.csv:\
	source_data/food_review.csv\
	tidy_source_data.R
	Rscript tidy_source_data.R