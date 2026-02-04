
# Read data in new script
# Label the Gaeta.cvs data as "fish_data"
fish_data = read.csv("Gaeta_etal_CLC_data.csv")

# Create new categorical size column
library(dplyr)
fish_data_cat = fish_data %>%
  mutate(length_cat = ifelse(length > 200, "big", "small"))

# Change cateogry cut-off size
fish_data_cat = fish_data %>% 
  mutate(length_cat = ifelse(length > 300, "big", "small"))

# Change code to read from new subdirectory (data)
fish_data = read.csv("data/Gaeta_etal_CLC_data.csv")



