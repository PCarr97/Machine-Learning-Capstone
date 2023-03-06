## Data Exploration

head(edx)
summary(edx)

# Remove Timestamp #
edx <- edx[,-4]

# Separate title and year variables #
edx <- edx %>% mutate(title = str_trim(title)) %>%
  extract(title, c("title_temp", "year"), regex = "^(.*) \\(([0-9 \\-]*)\\)$", remove = F) %>%
  mutate(year = if_else(str_length(year) > 4, as.integer(str_split(year, "-", simplify = T)[1]), as.integer(year))) %>%
  mutate(title = if_else(is.na(title_temp), title, title_temp)) %>%
  select(-title_temp)

# Separate genre variable
edx <- edx %>% separate_rows(genres, sep ="\\|")

head(edx)
