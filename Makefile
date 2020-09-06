

derived_data/tidy_data.csv:\
	source_data/Reviews.csv\
	tidy_data.R
	Rscript tidy_data.R
	
image/Overall_score_distribution.png\
	image/Helpfulness of the review.png:\
	derived_data/tidy_data.csv\
	Overall.R
	Rscript Overall.R
	