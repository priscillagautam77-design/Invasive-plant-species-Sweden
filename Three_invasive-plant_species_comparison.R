###############################################################################
#Project: Comparison of distribution of three invasive plant species in Sweden
#Plant species: Impatiens glandulifera, Lupinus polyphyllus, Heracleum mantegazzianum
#Data source: GBIF
#Author: Priscilla Gautam
#Date: July 2026
###############################################################################

# 1. Load packages
library(tidyverse)
library(ggplot2)
library(sf)
library(rnaturalearth)
library(rnaturalearthdata)

# 2. Import dataset
impatiens <- read_csv("data/impatiens_clean.csv")
lupinus <- read_csv("data/lupinus_clean.csv")
heracleum <- read_csv("data/heracleum_clean.csv")
lupinus$species_standard <- "Lupinus polyphyllus"
heracleum$species_standard <- "Heracleum mantegazzianum"
plants <- bind_rows(impatiens, lupinus,heracleum)
dim(plants)
table(plants$species_standard)

# 3. Convert to spatial data
plants_sf <- plants %>% st_as_sf(coords = c("decimalLongitude", "decimalLatitude"), crs = 4326)
class(plants_sf)
st_geometry_type(plants_sf)

# 4. Create map
Sweden <- ne_countries(country = "Sweden", scale = "medium", returnclass = "sf") 
class(Sweden)
ggplot() + geom_sf(data= Sweden) + geom_sf(data= plants_sf, aes(color = species_standard), size = 0.8, alpha = 0.5) + scale_color_manual(values = c("Impatiens glandulifera" = "red", "Lupinus polyphyllus" = "blue", "Heracleum mantegazzianum" = "green")) + labs(title = "Distribution of Three Invasive Plant Species in Sweden", color ="Species") + theme_minimal()
ggsave("figures/Three_invasive_plants_distribution_map.png", width = 8, height = 6, dpi = 300 )

# 5. Create grid
library(dplyr)
Sweden_3006 <- st_transform(Sweden, crs = 3006)
Plants_3006 <- st_transform(plants_sf, crs = 3006)
Sweden_grid <- st_make_grid(Sweden_3006, cellsize = 10000, square = TRUE) %>% st_sf()       
grid_species <- st_join(Sweden_grid, Plants_3006)
richness <- grid_species %>% group_by(geometry) %>% summarize(species_richness = n_distinct(species_standard, na.rm = TRUE))
ggplot() +geom_sf(data = richness, aes(fill = species_richness)) + geom_sf(data = Sweden, fill = NA) + scale_fill_viridis_c() + labs(title = "Invasive Plant Species Richness in Sweden", fill = "Number of species") + theme_minimal()
ggsave("figures/Three_invasive_species_richness_map.png", width = 8, height = 6, dpi = 300 )
       
       