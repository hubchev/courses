# load packages
if (!require(pacman)) install.packages("pacman")
suppressMessages(pacman::p_unload(all))
# setwd("~/Dropbox/hsf/exams/24-01/Rmd")

rm(list = ls())

pacman::p_load(tidyverse, haven, janitor, jtools)

df <- read_dta("https://github.com/hubchev/courses/raw/main/dta/city.dta",
  encoding = "latin1"
) |>
  as_tibble()

head(df)
tail(df)

dim(df)

summary(df)

df <- df |>
  rename(city = stadt)

df <- df |>
  select(-pop1970, -pop1987)

df |>
  group_by(state) |>
  summarise(
    mean(pop2011),
    sum(pop2011)
  )

df <- df |>
  mutate(state = case_when(
    state == "Baden-Wrttemberg" ~ "Baden-Württemberg",
    state == "Th_ringen" ~ "Thüringen",
    TRUE ~ state
  ))

df |>
  group_by(state) |>
  summarise(
    mean(pop2011),
    sum(pop2011)
  )

df |>
  filter(state == "Saarland") |>
  print(n = 100)

df <- df |>
  filter(!(city == "Perl" & is.na(pop2011)))

df |>
  filter(state == "Saarland") |>
  print(n = 100)

df |>
  filter(state == "Saarland") |>
  summarise(
    mean(pop2011),
    sum(pop2011)
  )

df |>
  group_by(city) |>
  mutate(unique_count = n()) |>
  arrange(city, state) |>
  filter(unique_count > 1) |>
  select(city, status, state, starts_with("pop"), unique_count) |>
  print(n = 100)

df |>
  group_by(city, state) |>
  mutate(unique_count = n()) |>
  arrange(city, state) |>
  filter(unique_count > 1) |>
  select(city, status, state, starts_with("pop"), unique_count) |>
  print(n = 100)


df <- df |>
  group_by(city, state) |>
  mutate(n_row = row_number()) |>
  filter(n_row == 1) |>
  select(-n_row)

df |>
  group_by(city, state) |>
  mutate(unique_count = n()) |>
  arrange(city, state) |>
  filter(unique_count > 1) |>
  select(city, status, state, starts_with("pop"), unique_count) |>
  print(n = 100)

save(df, file = "city_clean.RData")

df <- df |>
  ungroup() |>
  arrange(desc(pop2011)) |>
  mutate(rank = row_number())

df |>
  select(-rankX, -status, -state) |>
  head()


cor(df$pop2011, df$rank, method = c("pearson"))

ggplot(df, aes(x = rank, y = pop2011)) +
  geom_point() +
  geom_smooth(method = "lm", se = FALSE, color = "blue")

df <- df |>
  mutate(lnrank = log(rank)) |>
  mutate(lnpop2011 = log(pop2011))

df |>
  select(city, rank, lnrank, pop2011, lnpop2011) |>
  head()


cor(df$lnpop2011, df$lnrank, method = c("pearson"))

ggplot(df, aes(x = lnrank, y = lnpop2011)) +
  geom_point() +
  geom_smooth(method = "lm", se = FALSE, color = "blue") +
  labs(
    title = "Scatterplot with Regression Line",
    x = "lnrank (Logarithmized Rank)",
    y = "lnpop2011 (Logarithmized Population 2011)"
  )

zipf <- lm(lnpop2011 ~ lnrank, data = df)
summary(zipf)

df <- df |>
  mutate(prediction = predict(zipf, newdata = df)) |>
  mutate(pred_pop = exp(prediction))
df |>
  select(city, pop2011, pred_pop) |>
  filter(city == "Regensburg")

suppressMessages(pacman::p_unload(tidyverse, haven, janitor, jtools))

# rmarkdown::render("24-01_dsda.Rmd", "all")

# knitr::purl(input = "24-01_dsda.Rmd", output = "24-01_dsda_solution.R",documentation = 0)
