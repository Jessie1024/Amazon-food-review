BIOS611 Project1
========================================
Food Review Analysis
-------------------------------------------
Proposal
-------------------------------------------
Introduction
-------------------------------------------

The project including an analysis of the food review in Amazon, the dataset consists of half a million Amazon food reviews and was originally published by SNAP.
Some interesting avenues of expolrations on it include:
1. what does the review score distribution look like?
2. Does the review score relate to the review length?
3. Does some customer tend to score higher than others?
4. Does the review score relate to the sentiment of the review?
5. What words tend to indicate positive and negative review?
Finally, we would like to build a machine learning model to predict the probabiliy of review being positve or negative.


Text Mining and Exploratory Analysis
------------------------------------------
First, we make thea histogram of Amazon food review score from 1-5.
![](assets/Overall_score_distribution.png)
Then, we makes a histogram of Amazon food review helpfulness distribution.
![](assets/Helpfulness_of_the_review.png)
After having a general desctription figure,we further analyze the length of the reviews.
![](assets/distribution of review length.png)
![](assets/distribution_of_review_length.png)
![](assets/distribution of review length score=1.png)
![](assets/distribution_of_review_length_score=2.png) 
![](assets/distribution of review length score=3.png) 
![](assets/distribution_of_review_length_score=4.png) 
![](assets/distribution of review length score=5.png) 
popular words by review scores.
![](assets/Popular_Words_by_Review_Scores.png)
lexical density of the reviews by scores
![](assets/lexical_density.png)
and lexical diversity of reviews by scores
![](assets/lexical_density.png)
and TF-IDF to discover the most unique words in the reviews by scores
![](assets/TF-IDF.pngg)


Positive or Negative? Upset or pleased? Sentiment Explre
------------------------------------------
Machine can't understand reviews but can in some-ways define the sentiment of the review.
Here we use the r library tidytext to "teach" the "machine"
Here are the same words that the review and the sentiment database has shared
![](assets/sentiment_match_in_three_database.png)
Using the database "bing" we found that most of the words in our review are positive.
![](assets/review_bing_sentiment.png)
Using the database "nrc" here are the top sentiments in general reviews and positive and nehative reviews
![](assets/review_nrc_sentiment.png)
![](assets/score1review_nrc_sentiment.png)
![](assets/score5review_nrc_sentiment.png)

The next goal is to discover the words most founds in those sentiments.

sentiments prediction
--------------------------------------------
This section will use the tricks from the last section and predict the semtiment of reviews.




Usage
-------------------------------------------

you will need Docker and the ability to run Docker as your current user.

    >docker build . -t project1
    >docker run -v /home/jessieyy/storage/bios611-project1
	:/home/rstudio -p 8787:8787 -e PASSWORD=mypassword -i project1
Then connect to the machine on port 8787.

Makefile
-------------------------------------------
Makefile shows the organization of the project.
Enter through terminal or Rstudio:
    >Make example-folder/example-image.png
    >Make example-folder/example-dataset.csv
