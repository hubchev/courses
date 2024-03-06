# Generate and drop variables
# exe_genanddrop.R
# Stephan Huber; 2023-05-09

# setwd("/home/sthu/Dropbox/hsf/test")
rm(list=ls())

# load packages
if (!require(pacman)) install.packages("pacman")
pacman::p_load(datasets, tidyverse)

# a)
mtcars_new <- mtcars |> 
  rownames_to_column(var = "car") |>
  as_tibble() |> 
  mutate(d_cyl_6to8 = if_else(cyl > 6, 1, 0))
mtcars_new

# b)
mtcars_new <- mtcars_new |> 
  mutate(posercar = if_else(cyl > 6 & mpg < 18, 1, 0))
mtcars_new

# c) 
mtcars_new <- mtcars_new |> 
  select(-d_cyl_6to8)
mtcars_new  

# unload packages
suppressMessages(pacman::p_unload(datasets, tidyverse))
