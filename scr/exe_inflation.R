if (!require(pacman)) install.packages("pacman")
pacman::p_load(tidyverse, janitor, expss)
# setwd("~/yourdirectory-of-choice")
rm(list = ls())


# read in raw data
# PCEPI <- read.csv("PCEPI.csv")
PCEPI <- read.csv("https://raw.githubusercontent.com/hubchev/courses/main/dta/PCEPI.csv")

# clean data
pce_cl <- PCEPI |>
  mutate(pce = PCEPI_NBD20190101/100) |>
  mutate(year = str_sub(DATE, 1, 4)) |>
  mutate(year = as.integer(year)) |>
  select(pce, year) 

# make a plot
pce_cl |>
  ggplot( aes(x=year, y=pce))+
  geom_line() +
  geom_point()

# make a barplot
pce_cl |>
  ggplot( aes(x=year, y=pce))+
  geom_bar(stat="identity")

# make a plot for all years from 2000 onwards
pce_cl |>
  filter(year > 2000 ) |>
  ggplot( aes(x=year, y=pce)) +
  geom_bar(stat="identity")

# make a plot for all years except the 90s
pce_cl |>
  filter(year > 2000 | year <1990) |>
  ggplot( aes(x=year, y=pce)) +
  geom_bar(stat="identity")

# calculate yearly inflation
pce_cl <- pce_cl |>
  mutate(inflation_rate = (pce/lag(pce)-1)*100 )

# plot the inflation rate
pce_cl |>
  ggplot( aes(x=year, y=inflation_rate))+
  geom_bar(stat="identity")

# what is the avergage inflation rate
pce_cl |>
  summarize(avg_mpg = mean(inflation_rate, na.rm = TRUE))

# make a variable that indicates the decades 1 for 60s, 2 for 70s, etc.

pce_cl <- pce_cl |>
  mutate(decade = case_when(
    year < 1970  ~ "1960s",
    (year > 1969 & year < 1980) ~ "1970s",
    (year > 1979 & year < 1990) ~ "1980s",
    (year > 1989 & year < 2000) ~ "1990s",
    (year > 1999 & year < 2010) ~ "2000s",
    (year > 2009 & year < 2020) ~ "2010s",
    (year > 2019 & year < 2030) ~ "2020s",
  )) 


pce_decade <- pce_cl |>
  group_by(decade) |>
  summarize(avg_inf = mean(inflation_rate, na.rm = TRUE)) 

pce_decade
pce_decade |>
  ggplot( aes(x=decade, y=avg_inf))+
  geom_bar(stat="identity")

