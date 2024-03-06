# This is the "initial_script.R".
# It sets up R. 
# In particular, it installs frequently used packages 
# and shows what you can do with R. 

# set working directory
setwd("~/Dropbox/hsf/test/initial_script")

# clear environment
rm(list = ls())

# install packages (this may take several minutes)
install.packages("tidyverse")
install.packages("tinytex")
install.packages("rmarkdown")
install.packages("bundesligR")
install.packages(
  c("arrow", "babynames", "curl", "duckdb", "gapminder", 
    "ggrepel", "ggridges", "ggthemes", "hexbin", "janitor", "Lahman", 
    "leaflet", "maps", "nycflights13", "openxlsx", "palmerpenguins", 
    "repurrrsive", "tidymodels", "writexl", "datasouRus", "datasets"
    )
)

# Once you installed all packages you can comment out the installation.

# Load packages
library("tidyverse")


## The following example stems from the lecture notes
# Create a vector that contains the sales data
# <- assignment operator
sales_by_month <- c(0, 100, 200, 50, 3, 4, 8, 0, 0, 0, 0, 0)
sales_by_month
sales_by_month[2]
sales_by_month[4]
february_sales <- sales_by_month[2]
february_sales
sales_by_month[5] <- 25 # added May sales data
sales_by_month
# Do I have 12 month?
length( x = sales_by_month )
# Assume each unit costs 7 Euro, then the revenue is
price <- 7
revenue <- sales_by_month*price
revenue
# To get statistics for daily revenue we define the number of days:
days_per_month <- c(31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31)
# Calculate the daily revenue
revenue_per_day <- revenue/days_per_month
revenue_per_day 
# round number 
round(digits = 2, revenue_per_day) 

# Search for help: call the R documentation of `round()`
?round()



