# Distribution mapping and visualization of temporal patterns of Three invasive plant species in Sweden using GBIF data and R programming.
# Overview

The project compares the spatial distribution, species richness patterns and temporal trends of three invasive plant species in Sweden using biodiversity occurrence records from the Global Biodiversity Information Facility (GBIF). The analysis combines biodiversity data cleaning, GIS- based mapping, spatial grid analysis, and temporal visualization to explore where these species occur, where multiple invasive species overlap, and how recorded observations have changed over time.

The analysis was conducted in R using reproducible methods for ecological data processing and spatial analysis workflow.

# Research Question

How are three invasive plant species distributed across Sweden, and how have their recorded occurrence changed through time?

# Study species

¤ Impatiens glandulifera

¤ Lupinus polyphyllus

¤ Heracleum mantegazzianum

# Objectives

Clean and prepare GBIF occurrence datasets.

Create distribution maps for each species.

Produce a combined distribution map.

Identify invasive plant species richness using a spatial grid.

Analyze temporal trends in occurrence records.

# Data Source

Occurrence records were downloaded from the Global Biodiversity Information Facility (GBIF).

The datasets included:

Scientific name

Year

Basis of record

Decimal latitude

Decimal longitude

# Methods

The workflow included:

Data cleaning in R

Removing records without geographic coordinates

Checking coordinate quality

Standardizing species names

Combining cleaned datasets

Spatial analysis using the sf package

Mapping with ggplot2

Coordinate transformation to SWEREF 99 TM (EPSG:3006)

Species richness analysis using a 10 km grid

Temporal trend analysis by year

# Results

This project produced:

Individual distribution maps for each species

(figures/Impatiens_distribution_map.png)

Combined distribution map

Species richness grid map

Temporal trend graph

