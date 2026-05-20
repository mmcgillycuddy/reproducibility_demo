library(tidyverse)
library(lubridate)
library(janitor)

setwd("C:/Users/Staff/OneDrive - UNSW/github_repos/reproducibility_demo")

raw <- read.csv("data/raw/banana_quality_dataset.csv")

str_raw <- str(raw)

bananas <- raw |>
  clean_names() |>
  mutate(harvest_date = dmy(harvest_date))

bananas <- bananas |>
  mutate(ripeness_category = factor(ripeness_category,
                                 levels = c("Green", "Turning", "Ripe", "Overripe")),
         quality_category  = factor(quality_category,
                                    levels = c("Unripe", "Processing", "Good", "Premium")),
         variety = as.factor(variety),
         region = as.factor(region),
         sample_id       = as.factor(sample_id) )

str_bananas <- str(bananas)

n_negative <- bananas |>
  filter(if_any(c(sugar_content_brix, firmness_kgf, length_cm,
                  weight_g, tree_age_years, altitude_m, rainfall_mm, soil_nitrogen_ppm), \(x) x < 0)) 

write.csv(bananas, "data/processed/banana_clean.csv", row.names = FALSE)
