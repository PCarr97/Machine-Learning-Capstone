##### APPLY LAMBDA TO EDX DATASET BETAS #####
b_i <- edx %>%
  group_by(movieId) %>%
  summarise(b_i = sum(rating - avg)/(n()+lambda))

b_u <- edx %>%
  left_join(b_i, by="movieId") %>%
  group_by(userId) %>%
  summarise(b_u = sum(rating - b_i - avg)/(n()+lambda))

b_g <- edx %>%
  left_join(b_i, by="movieId") %>%
  left_join(b_u, by="userId") %>%
  group_by(genres) %>%
  summarise(b_g = sum(rating - b_i - b_u - avg)/(n()+lambda))

b_y <- edx %>%
  left_join(b_i, by="movieId") %>%
  left_join(b_u, by="userId") %>%
  left_join(b_g, by="genres") %>%
  group_by(year) %>%
  summarise(b_y = sum(rating - b_i - b_u - b_g - avg)/(n()+lambda))
