##### CREATE TEST AND TRAIN SETS #####
set.seed(1997)
test_index <- createDataPartition(y = edx$rating, times = 1, p = 0.2, 
                                  list = FALSE)
train_set <- edx[-test_index,]
test_set <- edx[test_index,]



### SIMPLE AVERAGE RMSE ###
avg <- mean(train_set$rating)
simple_rmse <- RMSE(test_set$rating, avg, na.rm = TRUE)
simple_rmse





##### BETA REPLACEMENT FOR LINEAR REGRESSION #####
movie_avgs <- train_set %>% 
  group_by(movieId) %>% 
  summarize(b_i = mean(rating - avg))

pred_b_i <- avg + test_set %>% 
  left_join(movie_avgs, by='movieId') %>%
  pull(b_i)

RMSE(pred_b_i, test_set$rating, na.rm = TRUE)
# RMSE improves OVER simple average