##### CLEAN VALIDATION DATASET #####
head(validation)

# Remove Timestamp #
validation <- validation[,-4]

# Separate Title and Year #
validation <- validation %>% mutate(title = str_trim(title)) %>%
  extract(title, c("title_temp", "year"), regex = "^(.*) \\(([0-9 \\-]*)\\)$", remove = F) %>%
  mutate(year = if_else(str_length(year) > 4, as.integer(str_split(year, "-", simplify = T)[1]), as.integer(year))) %>%
  mutate(title = if_else(is.na(title_temp), title, title_temp)) %>%
  select(-title_temp)

# Separate genre variable
validation <- validation %>% separate_rows(genres, sep ="\\|")
head(validation)





##### APPLY FINAL MODEL TO VALIDATION SET #####
valid_model <- validation %>%
  left_join(b_i, by="movieId") %>%
  left_join(b_u, by="userId") %>%
  left_join(b_g, by="genres") %>%
  left_join(b_y, by="year") %>%
  mutate(pred = avg + b_i + b_u + b_g + b_y) %>%
  pull(pred)

# Calculate final validation RMSE
RMSE(valid_model, validation$rating) # Result: RMSE of 0.8625806
