# Find duplicates

# set working directory
# setwd("~/Dropbox/hsf/test/initial_script")

# clear environment
rm(list = ls())

# load packages
if (!require(pacman)) install.packages("pacman")
pacman::p_load(tidyverse, janitor, babynames, stringr)

load(url("https://github.com/hubchev/courses/raw/main/dta/df_names.RData"))

# Remove all objects except df_2022 and df_2022_error
rm(list = setdiff(ls(), c("df_2022_error", "df_2022")))

# Re-order the data so that surname, name, and age appears first. 
# Save the changed data in a tibble called `df`.
df <- df_2022 |> 
  relocate(surname, name, age)

# Sort the data according to surname, name, and age.
df <- df |> 
  arrange(surname, name, age)

# Inspect df_2022 and df_2022_error 
df
dim(df)
head(df)
tail(df) 
glimpse(df)
summary(df)

df_2022_error

# Make a variable that contains the year of birth. Name the variable `born` 
# and new dataframe `df`.
df <- df_2022 |> 
  mutate(born = time - age)  

# Make a new variable that identifies each person by surname, name, 
# and their birth born. Name the variable `id`.
df <- df |> 
mutate(id = paste(surname, name, born, sep = "_")) 

# How many different groups do exist?
df <- df |> 
  group_by(id) |> 
  mutate(id_num = cur_group_id()) |> 
  ungroup()

max(df$id_num)

# Show groups that exist more than once.
df <- df |>  
  group_by(id) |>  
  mutate(
    dup_count = row_number(),
    dup_sum   = n()     
  ) |> 
  ungroup() |> 
  arrange(id)

df |> filter(dup_sum > 1)
df |> get_dupes(name, surname)

# Make yourself familiar with the function `get_dupes()` from `janitor` package.
df |> get_dupes()
df |> get_dupes(surname, name)
df |> get_dupes(id)

df_uni <- df |> 
  arrange() |> 
  distinct(id, .keep_all = TRUE)

df_uni_b <- df |> 
  arrange(desc(dup_count)) |> 
  distinct(id, .keep_all = TRUE)

anti_join(df, df_uni)
anti_join(df, df_uni_b)

# unload packages
pacman::p_unload(tidyverse, janitor, babynames, stringr)