# setwd("/home/sthu/Dropbox/hsf/23-ws/ds_mim/")
rm(list = ls())

# Load the packages datasauRus and tidyverse. If necessary, install these packages.

# load packages
if (!require(pacman)) install.packages("pacman")
pacman::p_load(datasauRus, tidyverse)

# The packagedatasauRus comes with a dataset in two different formats: 
#   datasaurus_dozen and datasaurus_dozen_wide. Store them as ds and ds_wide.

ds <- datasaurus_dozen
ds_wide <- datasaurus_dozen_wide

# Open and read the R vignette of the datasauRus package. 
#   Also open the R documentation of the dataset datasaurus_dozen.

??datasaurus

# Explore the dataset: What are the dimensions of this dataset? Look at the descriptive statistics.

ds
dim(ds)
head(ds)
glimpse(ds)
view(ds)
summary(ds)

# How many unique values does the variable dataset of the tibble ds have? 
#   Hint: The function unique() return the unique values of a variable and the 
#   function length() returns the length of a vector, such as the unique elements.

unique(ds$dataset)  

unique(ds$dataset) |> 
  length()

# Compute the mean values of the x and y variables for each entry in dataset. 
#   Hint: Use the group_by() function to group the data by the appropriate column and 
#   then the summarise() function to calculate the mean.

ds |> 
  group_by(dataset) |> 
  summarise(mean_x = mean(x),
            mean_y = mean(y))

# Compute the standard deviation, the correlation, and the median in the same way. Round the numbers.

ds |> 
  group_by(dataset) |> 
  summarise(mean_x = round(mean(x),2),
            mean_y = round(mean(y),2),
            sd_x = round(sd(x),2),
            sd_y = round(sd(y),2),
            med_x = round(median(x),2),
            med_y = round(median(y),2),
            cor = round(cor(x,y), digits = 4))

# What can you conclude?
#   --> The standard deviation, the mean, and the correlation are basically the 
#   same for all datasets. The median is different. 

# Plot all datasets of ds. Hide the legend. Hint: Use the facet_wrap() and the theme() function.

ggplot(ds, aes(x = x, y = y)) +
  geom_point() +
  facet_wrap(~ dataset, ncol = 3) +
  theme(legend.position = "none") 

# Create a loop that generates separate scatter plots for each unique datatset of the tibble ds. 
#   Export each graph as a png file.

# Assuming uni_ds is a vector of unique values for the 'dataset' variable
uni_ds <- unique(ds$dataset)

# Create the 'pic' folder if it doesn't exist
if (!dir.exists("pic")) {
  dir.create("pic")
}

for (uni_v in uni_ds) {
  # Select data for the current value
  subset_ds <- ds |> 
    filter(dataset == uni_v) %>%
    select(x, y)
  
  # Make plot
  graph <- ggplot(subset_ds, aes(x = x, y = y)) +
    geom_point() +
    labs(title = paste("Dataset:", uni_v),
         x = "X",
         y = "Y") +
    theme_bw()
  
  # Save the plot as a PNG file
  filename <- paste0("pic/", "plot_ds_", uni_v, ".png")
  ggsave(filename, plot = graph)
}

# unload packages
suppressMessages(pacman::p_unload(datasauRus, tidyverse))