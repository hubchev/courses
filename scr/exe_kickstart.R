# This script demonstrates a typical data analysis workflow in R
# ---------------------------------------------------------------

# Install and load required libraries
# Installs 'pacman' if not already available, which is used for package management
if (!require(pacman)) install.packages("pacman")

# Unload all previously loaded packages to start fresh
suppressMessages(pacman::p_unload(all))

# Load necessary packages for data manipulation, cleaning, and visualization
pacman::p_load(
  tidyverse, # A suite of packages designed for data science that includes tools for data manipulation, plotting, and more.
  haven, # Used for importing and exporting data with SPSS, Stata, and SAS formats.
  janitor, # Provides functions for examining and cleaning data, such as `clean_names()` and `tabyl()`.
  WDI, # Facilitates downloading data from the World Bank's World Development Indicators database.
  wbstats # Provides an interface to the World Bank's APIs for a comprehensive range of data sets.
)

# Set the working directory to a project-specific folder
setwd("~/Dropbox/hsf/courses/dsr")

# Clear the current environment of any objects
rm(list = ls())

# ---------------------------------------------------------------

# Load data from a Stata file available online
auto <- read_dta("http://www.stata-press.com/data/r8/auto.dta")
# 'auto': Dataset contains information about different car models

# Display basic information about the dataset
ncol(auto) # Number of columns
nrow(auto) # Number of rows
dim(auto) # Dimensions of the dataset
names(auto) # Names of variables
head(auto) # First few rows
tail(auto) # Last few rows
summary(auto) # Summary statistics for each column
glimpse(auto) # Compact display of the structure of the dataset
print(auto, n = Inf) # Print all rows of the dataset

# Check for duplicate entries based on the 'make' variable
auto |>
  get_dupes(make)

# Create and display a scatter plot of car price versus weight
plot_weight_price <- ggplot(auto, aes(x = weight, y = price)) +
  geom_point()
plot_weight_price

# Save the plot to a file
ggsave("fig/plot_weight_price.png", plot = plot_weight_price, dpi = 300)

# Create a scatter plot with a linear regression line of price vs weight
plot_weight_price_fit <- ggplot(auto, aes(x = weight, y = price)) +
  geom_point() +
  geom_smooth(method = lm, se = FALSE) # 'lm' denotes linear model, 'se' is standard error
plot_weight_price_fit

# Save the plot to a file
ggsave("fig/plot_weight_price_fit.png", plot = plot_weight_price_fit, dpi = 300)

# Perform a linear regression to analyze the relationship between weight and price
reg_result <- lm(price ~ weight, data = auto)
summary(reg_result) # Display the regression results

# Load and demonstrate usage of World Development Indicators (WDI) data
# Two different packages can help here:
# WDI:
# --- https://cran.r-project.org/web/packages/WDI/WDI.pdf
# --- https://github.com/vincentarelbundock/WDI
# wbstats:
# --- https://cran.r-project.org/web/packages/wbstats/wbstats.pdf
# --- https://github.com/gshs-ornl/wbstats
# ?WDI  # Access documentation for the WDI package
# ?wbstats # # Access documentation for the wbstats package

# Search for GDP indicators and display the first 10
WDIsearch("gdp")[1:10, ]

# Retrieve GDP per capita data for specified countries and years
df_WDI <- WDI(
  indicator = "NY.GDP.PCAP.KD",
  country = c("MX", "CA", "US"),
  start = 1960,
  end = 2012
)

# Plot GDP per capita over time for the specified countries
ggplot(df_WDI, aes(year, NY.GDP.PCAP.KD, color = country)) +
  geom_line() +
  xlab("Year") +
  ylab("GDP per capita")

# Retrieve GDP per capita data for specified countries and years using the wbstats package
df_wb <- wb(
  indicator = "NY.GDP.PCAP.KD",
  country = c("MX", "CA", "US"),
  start = 1960,
  end = 2012,
  return_wide = TRUE
)

# Plot GDP per capita over time for the specified countries
ggplot(df_wb, aes(date, NY.GDP.PCAP.KD, color = country)) +
  geom_line() +
  xlab("Year") +
  ylab("GDP per capita (constant 2010 US$)")

# !!! This does not work !!!
# Why?

# Look at the data types year and date are different:
glimpse(df_WDI)
glimpse(df_wb)

# Answer: A lineplot with a character variable on the x-axis does not work!

# make the two dataframe equal:
df_wb_cln <- df_wb |>
  # Convert 'date' in df_wb from character to integer
  mutate(year = as.integer(date)) |>
  # Since 'year' has been created, remove the original 'date' column
  select(-date) |>
  # Relocate columns to organize the data frame
  relocate(country, iso2c, iso3c, year, NY.GDP.PCAP.KD)

glimpse(df_WDI)
glimpse(df_wb_cln)

# Now it works:
# Plot GDP per capita over time for the specified countries
ggplot(df_wb_cln, aes(year, NY.GDP.PCAP.KD, color = country)) +
  geom_line() +
  xlab("Year") +
  ylab("GDP per capita (constant 2010 US$)")

suppressMessages(pacman::p_unload(
  tidyverse, # A suite of packages designed for data science that includes tools for data manipulation, plotting, and more.
  haven, # Used for importing and exporting data with SPSS, Stata, and SAS formats.
  janitor, # Provides functions for examining and cleaning data, such as `clean_names()` and `tabyl()`.
  WDI, # Facilitates downloading data from the World Bank's World Development Indicators database.
  wbstats # Provides an interface to the World Bank's APIs for a comprehensive range of data sets.
))