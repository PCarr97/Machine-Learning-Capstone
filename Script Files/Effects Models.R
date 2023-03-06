##### USER EFFECTS MODEL #####
user_avgs <- train_set %>% 
  left_join(movie_avgs, by='movieId') %>%
  group_by(userId) %>%
  summarize(b_u = mean(rating - avg - b_i))

pred_b_u <- test_set %>% 
  left_join(movie_avgs, by='movieId') %>%
  left_join(user_avgs, by='userId') %>%
  mutate(pred = avg + b_i + b_u) %>%
  pull(pred)

RMSE(pred_b_u, test_set$rating, na.rm = TRUE)
# RMSE improves over simple linear regression model





##### GENRE EFFECTS MODEL #####
genre_avgs <- train_set %>%
  left_join(movie_avgs, by = "movieId") %>%
  left_join(user_avgs, by = "userId") %>%
  group_by(genres) %>%
  summarise(b_g = mean(rating - avg - b_i - b_u))

pred_b_g <- test_set %>%
  left_join(movie_avgs, by = "movieId") %>%
  left_join(user_avgs, by = "userId") %>%
  left_join(genre_avgs, by = "genres") %>%
  mutate(pred = avg + b_i + b_u + b_g) %>%
  pull(pred)

RMSE(pred_b_g, test_set$rating, na.rm = TRUE)
# RMSE improves over user effects model





##### YEAR EFFECTS MODEL #####
year_avgs <- train_set %>%
  left_join(movie_avgs, by = "movieId") %>%
  left_join(user_avgs, by = "userId") %>%
  left_join(genre_avgs, by = "genres") %>%
  group_by(year) %>%
  summarise(b_y = mean(rating - avg - b_i - b_u - b_g))

pred_b_y <- test_set %>%
  left_join(movie_avgs, by = "movieId") %>%
  left_join(user_avgs, by = "userId") %>%
  left_join(genre_avgs, by = "genres") %>%
  left_join(year_avgs, by = "year") %>%
  mutate(pred = avg + b_i + b_u + b_g + b_y) %>%
  pull(pred)

RMSE(pred_b_y, test_set$rating, na.rm = TRUE)
# RMSE improves over user effects model
