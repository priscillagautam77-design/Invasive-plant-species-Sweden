######################################################
# Project: Distribution of Impatiens glandulifera in Sweden
# Data source: GBIF
# Author: Priscilla Gautam
# Date: July 2026
######################################################

# 1. Load packages
library(tidyverse)
library(sf)
library(ggplot2)
library(rnaturalearth)
library(rnaturalearthdata)

# 2. Import GBIF occurrence data
#GBIF files are tab-separated
Impatiens <- read_tsv("data/occurrence.csv")
dim(Impatiens)
glimpse(Impatiens)
names(Impatiens)
head(Impatiens)

# 3. Data cleaning
impatiens_clean <- Impatiens %>% select(scientificName, decimalLatitude, decimalLongitude, year, basisOfRecord)
dim(impatiens_clean)
glimpse(impatiens_clean)
names(impatiens_clean)
colSums(is.na(impatiens_clean))
impatiens_clean <- impatiens_clean %>%
drop_na(decimalLatitude, decimalLongitude)
dim(impatiens_clean)
unique(impatiens_clean$scientificName)
table(impatiens_clean$scientificName)
impatiens_clean <- impatiens_clean %>% filter(scientificName != "Impatiens roylei Walp.")
table(impatiens_clean$scientificName)
impatiens_clean <- impatiens_clean %>% mutate(species_standard = "Impatiens glandulifera")
table(impatiens_clean$scientificName)
summary(impatiens_clean$decimalLatitude)
summary(impatiens_clean$decimalLongitude)
summary(impatiens_clean$year)
write_csv(impatiens_clean,"data/impatiens_clean.csv")
impatiens_clean %>% filter(year == 2026)
names(Impatiens)
Impatiens %>% filter(year == 2026) %>% select(year, eventDate, basisOfRecord)

# 4. Convert to spatial data
imp_points <- st_as_sf(impatiens_clean, coords = c("decimalLongitude", "decimalLatitude"),crs = 4326)
imp_points
class(imp_points)

# 5. Create map
sweden <- ne_countries(country = "Sweden",returnclass = "sf")
ggplot() + geom_sf(data = sweden) + geom_sf(data = imp_points, size = 0.7, alpha = 0.4) + labs(title = "Distribution of Impatiens glandulifera in Sweden", subtitle = "GBIF occurrence records") + theme_classic()
ggsave("figures/Impatiens_distribution_map.png", width = 8, height = 6, dpi = 300)

# 6. Year trend analysis
impatiens_year <- impatiens_clean %>% filter(!is.na(year))
year_count <- impatiens_year %>% count(year)
year_count
ggplot(year_count, aes(x = year, y = n)) + geom_line() + geom_point() + labs(title = "Temporal trend of Impatiens glandulifera records in Sweden", x = "Year",  y = "Number of observations", caption = "Source: GBIF") + theme_classic()
ggsave("figures/Impatiens_year_trend.png", width = 8, height = 5, dpi = 300)

