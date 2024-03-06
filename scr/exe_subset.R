# Subsetting with \R
# exe_subset.R
# Stephan Huber; 2022-06-07

# setwd("/home/sthu/Dropbox/hsf/22-ss/dsda/work/")
rm(list=ls())



# 0
# load packages
if (!require(pacman)) install.packages("pacman")
pacman::p_load(tidyverse, dplyr, tibble)

# 1
mtcars

# 2
cars <- mtcars

# 3
class(cars)

# 4
dim(cars)

# Alternative
ncol(cars)
nrow(cars)

# 5
cars <- rename(cars, MPG = mpg)

# 6
cars <- rename_all(cars, toupper)
# if you like lower cases:
# cars <- rename_all(cars, tolower)

# 7
cars <- rownames_to_column(mtcars, var = "car")

# 8
pvars <- select(cars, car, ends_with("p"))

# 9
carsSub <- select(cars, car, wt, qsec, hp)

# 10
dim(carsSub)

# 11
carsSub <- rename_all(carsSub, toupper)

# 12
cars_mpg <- filter(cars, mpg > 20)
dim(cars_mpg)

# 13
cars_whattever <- filter(cars, mpg < 16 & hp > 100)

# 14
carsSub <- filter(cars, cyl == 8) 
carsSub <- select(carsSub, wt, qsec, hp, car)
dim(carsSub)

# 15
# Alternative with pipe operator:
carsSub <- cars %>%
  filter(cyl == 8) %>%
  select(wt, qsec, hp, car)

# 16
carsSub <- arrange(carsSub, wt)

# 17
carsSub <- carsSub %>% 
  mutate(wt2 = wt^2)

# Alternatively you can put everything into one pipe:
carsSub2 <- cars %>%
  filter(cyl == 8) %>%
  select(wt, qsec, hp, car) %>% 
  arrange(carsSub, wt) %>% 
  mutate(wt2 = wt^2)


# unload packages
suppressMessages(pacman::p_unload(tidyverse, dplyr, tibble))
