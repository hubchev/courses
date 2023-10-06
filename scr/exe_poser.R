# Load the required libraries
library(tidyverse)
library(haven)

rm(list = ls())

# Read the Stata dataset
auto <- read_dta("http://www.stata-press.com/data/r8/auto.dta")

# Create a scatter plot of price vs. weight
scatter_plot <- ggplot(auto, aes(x = weight, y = price)) +
  geom_point(aes(label = make), size = 3) +
  labs(title = "Scatter Plot of Price vs. Weight of Cars",
       x = "Weight",
       y = "Price") +
  theme_minimal()

# Save the scatter plot in different formats
ggsave("scatter_plot.png", plot = scatter_plot, device = "png")
ggsave("scatter_plot.pdf", plot = scatter_plot, device = "pdf")

# Create 'lp100km' variable for fuel consumption
n_auto <- auto %>%
  mutate(lp100km = (1/(mpg * 1.6/ 3.8))  * 100)

# Create 'larger6000' dummy variable
n_auto <- n_auto %>%
  mutate(larger6000 = ifelse(price > 6000, 1, 0))

# Normalize variables

## Do it slowly
n_auto <- n_auto |> 
  mutate(sprice = ( price - min(auto$price) )/( max(auto$price) - min(auto$price) ) )

## Do it with a self-written function 
min_max_norm <- function(x) {
  (x - min(x, na.rm = TRUE)) / (max(x, na.rm = TRUE) - min(x, na.rm = TRUE))
}

n_auto <- n_auto |> 
  mutate(smpg = min_max_norm(mpg)) |> 
  mutate(sturn = min_max_norm(turn)) |> 
  mutate(slp100km = min_max_norm(lp100km)) |> 
  mutate(sprice = min_max_norm(price)) |> 
  mutate(srep78 = min_max_norm(rep78)) 

## With a loop:

# vars_to_normalize <- c("mpg", "turn", "lp100km", "price", "rep78")
# 
# # Loop through the selected variables and apply min_max_norm
# for (var in c("mpg", "turn", "lp100km", "price", "rep78")) {
#   auto <- auto |> 
#     mutate(!!paste0("s", var) := min_max_norm(!!sym(var))) |> 
#     select(make, starts_with("s"))
# }

## mpg and rep78 need to be changed because a SMALL value is poser-like 
n_auto <- n_auto |> 
  mutate(smpg = 1-smpg) |> 
  mutate(srep78 = 1-srep78) 

## create the poser (composite) indicator 
n_auto <- n_auto |> 
  mutate(poser = (sturn+smpg+sprice+srep78) / 4 )

## filter results
n_auto |> 
  arrange(desc(poser)) |> 
  select(make, poser) |> 
  head(, 5)  

df_poser <- n_auto |> 
  filter(larger6000 == 0) |> 
  arrange(desc(poser)) |> 
  select(make, poser) |> 
  na.omit()

# Five top poser cars
head(df_poser, 5)

# Five top non-poser cars
tail(df_poser, 5)
