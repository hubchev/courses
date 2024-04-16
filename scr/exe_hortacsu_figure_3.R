# setwd("~/Dropbox/hsf/courses/Rlang/hortacsu")

rm(list = ls())


# install and load packages
if (!require(pacman)) install.packages("pacman")
pacman::p_load(tidyverse, readxl)


# Define the URL of the ZIP file
zipF <- "https://github.com/hubchev/courses/raw/main/dta/113962-V1.zip"

# Download the ZIP file
download.file(zipF, destfile = "113962-V1.zip")

# Unzip the contents
unzip("113962-V1.zip")

df_curves <- read_excel("Hortacsu_Syverson_JEP_Retail/diffusion_curves_figure.xlsx",
  sheet = "Data and Predictions", range = "N3:Y60"
)

df <- df_curves |>
  pivot_longer(
    cols = "Music and Video":"Food and Beverages",
    names_to = "industry",
    values_to = "value"
  )

# Plot
df |>
  ggplot(aes(x = Year, y = value, group = industry, color = industry)) +
  geom_line()


#  unload packages
suppressMessages(pacman::p_unload(tidyverse, readxl))

