## Introduction

This project is concerned with a large dataset consisting of movie
titles, release years, genres, ratings, and ID numbers associated with
reviewers and movies. The goal of this project is to determine which
factors within this dataset will allow us to most accurately predict the
rating of a given movie.

First, we will further explore the dataset and break down any variables
that do not give us a clean and convenient view into what they can
contribute regarding their ability to predict the movies ratings. We
will then explore any possible trends in the data that may help us to
determine facts that will help in the prediction process. Finally, we
will take a number of different variables and fit them into a model that
will eventually give us a successful system to predict movie reviews.

In order to do this, we will split our data first into a separate
“validation” dataset, that we will use to test the model at the end of
our process. We are assuming that we know nothing about the values
within the dataset.

We will then split the data again into a “test” and “training” datasets.
The training set will be used to fit different specifications into our
model, which will then be compared to the test set to determine overall
accuracy. At the end of the model, this same process is applied to the
validation set.

We will be measuring model accuracy using the square root of the
variance of the residuals, referred to as RMSE. We are looking to
minimize this value, and ideally have it below 0.86490.

## Methods and Analysis

Our first step is to explore the dataset itself and look for any
potential difficulties. This is what we find:

    ##    userId movieId rating timestamp                         title
    ## 1:      1     122      5 838985046              Boomerang (1992)
    ## 2:      1     185      5 838983525               Net, The (1995)
    ## 3:      1     292      5 838983421               Outbreak (1995)
    ## 4:      1     316      5 838983392               Stargate (1994)
    ## 5:      1     329      5 838983392 Star Trek: Generations (1994)
    ## 6:      1     355      5 838984474       Flintstones, The (1994)
    ##                           genres
    ## 1:                Comedy|Romance
    ## 2:         Action|Crime|Thriller
    ## 3:  Action|Drama|Sci-Fi|Thriller
    ## 4:       Action|Adventure|Sci-Fi
    ## 5: Action|Adventure|Drama|Sci-Fi
    ## 6:       Children|Comedy|Fantasy

We would like to determine the impact of the release year on ratings;
therefore we separate the film’s title and the year, which are both
under the “title” variable.

Finally, we would like to determine the impact of individual genre on a
film’s rating; therefore we separate the genres that are currently all
lumped together in the “genres” category. Our resulting dataset now
looks like this:

    ## # A tibble: 6 × 6
    ##   userId movieId rating title      year genres  
    ##    <int>   <dbl>  <dbl> <chr>     <int> <chr>   
    ## 1      1     122      5 Boomerang  1992 Comedy  
    ## 2      1     122      5 Boomerang  1992 Romance 
    ## 3      1     185      5 Net, The   1995 Action  
    ## 4      1     185      5 Net, The   1995 Crime   
    ## 5      1     185      5 Net, The   1995 Thriller
    ## 6      1     292      5 Outbreak   1995 Action

It’s with this clean dataset that we create our test and training sets.

We will then test the impact of year, genre, and userID on a movie’s
rating to see if these factors can help us make a prediction.

## Results

Before we begin testing the impacts of year and genre, we must first
establish an RMSE baseline to determine whether our model is improving
or not. First, we assume that we simply take the average of the movie
rating of every movie in the database and make that our prediction. This
is our resulting RMSE:

    ## [1] 1.052045

This awfully high, and not even close to our target RMSE.

We will then look at the accuracy of using a simple linear regression
model with the rating being the only independent factor (i.e.,
subtracting the average rating from the individual rating of every movie
to act as the “beta” that would go into a linear model). This process is
applied to the training set, and then applied to the test set (we will
go through this process with every iteration of the model). Our
resulting RMSE:

    ## [1] 0.9410305

This is an improvement, but still nowhere near where it needs to be.

We can believe that certain reviewers will be more optimistic or
pessimistic than others. Next, we’ll take the userID variable into
account by adding it into our model. We will subtract both the average
and previous “beta” value from the individual movie’s ratings (this
process too will be repeated with each additional model). Our new RMSE:

    ## [1] 0.8577846

Another substantial improvement. This tells us that if we take into
account an individual critic’s history, it’s easier to make a correct
prediction as to what a movie’s rating will be. We can assume that
certain genres receive higher ratings than others, and repeat the above
process on the genre variable:

    ## [1] 0.8576922

We can also assume that movies during a certain period of time received
higher ratings than others, so we will repeat the above process with the
year variable:

    ## [1] 0.8573602

With the addition of each additional variable, our accuracy as measured
by RMSE improves. No included variable harms our accuracy. Next, we go
through the process of regularization. With any given model or dataset,
we can assume that there are outliers that skew the data. If one movie
with a five star rating only has one review, it is treated by the
dataset as equal to a movie with a five star review and 100 reviews.
Regularization will remove movies with a certain number of reviews or
less. What number will we select to maximize our accuracy?

This number is referred to as the “lambda” of regularization, and we can
test a wide range of lambdas on our model which will find the ideal
value. This is what we find:

    ## [1] 4.3

After applying this lambda to the model and removing outliers, we get
our final training set RMSE:

    ## [1] 0.8572433

This is the most accurate model we’ve yet come across, which shows the
regularization process has helped. In our last step, we clean the
validation set in the same way we did our original dataset (i.e.,
removing the timestamp and separating year and genre variables). We then
apply our final model to the validation set:

    ## [1] 0.8625806

We have successfully built a model with an accuracy above our desired
threshold.

## Conclusion

Our model has demonstrated that, based on the information in our
dataset, the genre, year, and nature of the critic are all significant
variables in determining how one can predict a movie’s rating.
Furthermore, by removing movies with only roughly four reviews, we
seriously improve our ability to predict ratings.

One limitation is that there are a number of other factors that are not
included in the dataset (e.g., film budgets, marketing, etc.). These
could have even more significant impacts than those we have explored.
