# setwd("/home/sthu/Dropbox/hsf/exams/22-11/scr/")

rm(list = ls())

# load packages
if (!require(pacman)) install.packages("pacman")
pacman::p_load(tidyverse, ggpubr, sjPlot)

load(url("https://github.com/hubchev/courses/raw/main/dta/forest.Rdata"))

head(df, 8)

tail(df, 1)

# panel data set
# date and country.x

observations_df <- dim(df)

df <- rename(df, nation = country.x)
df <- rename(df, year = date)

df <- df |>
  select(nation, year, gdp, pop, gdppc, unemployment)

df <- df |>
  mutate(gdp_pc = gdp / pop)

df <- df |> filter(nation == "Germany" | nation == "France")

df |>
  group_by(nation) |>
  summarise(mean(unemployment), mean(gdppc))

df |>
  filter(year == 2020) |>
  group_by(nation) |>
  summarise(mean(unemployment), mean(gdppc))

df |>
  group_by(nation) |>
  summarise(max(unemployment), max(gdppc))

df |>
  group_by(nation) |>
  summarise(sd(gdppc), sd(unemployment))

df |>
  group_by(nation) |>
  summarise(sd(unemployment), mean(unemployment), cov = sd(unemployment) / mean(unemployment))

df |>
  group_by(nation) |>
  summarise(sd(gdppc), mean(gdppc), cov = sd(gdppc) / mean(gdppc))

df_pger <- df |>
  filter(nation == "Germany")

pger <- ggplot(df_pger, aes(x = year, y = unemployment)) +
  geom_line() +
  ggtitle("Germany")

plot(pger)


labels <- 1992:2020
dfra <- df |> filter(nation == "France")
plot(dfra$gdppc, dfra$unemployment,
  type = "b",
  xlab = "GDP per capita", ylab = "Unemployment rate"
)
text(dfra$gdppc + 0.1, dfra$unemployment + 0.1, labels)
title("France")

# Data
x <- c(1, 2, 3, 4, 5, 4, 7, 8, 9)
y <- c(12, 16, 14, 18, 16, 13, 15, 20, 22)
labels <- 1970:1978

# Connected scatter plot with text
plot(x, y, type = "b", xlab = "Var 1", ylab = "Var 2")
text(x + 0.4, y + 0.1, labels)

dfger <- df |> filter(nation == "Germany")
labels <- 1992:2020
plot(dfger$gdppc, dfger$unemployment,
  type = "b",
  xlab = "Var 1", ylab = "Var 2"
)
text(dfger$gdppc + 0.7, dfger$unemployment + 0.4, labels)
title("Germany")

suppressMessages(pacman::p_unload(tidyverse, ggpubr, sjPlot))
