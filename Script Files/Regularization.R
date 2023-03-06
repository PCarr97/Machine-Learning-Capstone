##### REGULARIZATION #####
lambdas <- seq(1, 6, 0.1)

rmses <- sapply(lambdas, function(l){
  b_i <- train_set %>%
    group_by(movieId) %>%
    summarise(b_i = sum(rating - avg)/(n()+l))
  
  b_u <- train_set %>%
    left_join(b_i, by="movieId") %>%
    group_by(userId) %>%
    summarise(b_u = sum(rating - b_i - avg)/(n()+l))
  
  b_g <- train_set %>%
    left_join(b_i, by="movieId") %>%
    left_join(b_u, by="userId") %>%
    group_by(genres) %>%
    summarise(b_g = sum(rating - b_i - b_u - avg)/(n()+l))
  
  b_y <- train_set %>%
    left_join(b_i, by="movieId") %>%
    left_join(b_u, by="userId") %>%
    left_join(b_g, by="genres") %>%
    group_by(year) %>%
    summarise(b_y = sum(rating - b_i - b_u - b_g - avg)/(n()+l))
  
  predicted_ratings <- test_set %>%
    left_join(b_i, by="movieId") %>%
    left_join(b_u, by="userId") %>%
    left_join(b_g, by="genres") %>%
    left_join(b_y, by="year") %>%
    mutate(pred = avg + b_i + b_u + b_g + b_y) %>%
    pull(pred)
  
  return(RMSE(predicted_ratings, test_set$rating, na.rm = TRUE))
})

lambdas[which.min(rmses)] # Result: 4.3 #
lambda <- 4.3
min(rmses)
# Regularization improves RMSE over all non-regularized models

