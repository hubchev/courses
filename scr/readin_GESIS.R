# set working directory
setwd("/home/sthu/Dropbox/hsf/23-ws/ewa/")

# clear the environment
rm(list = ls())

# load packages
# install.packages("haven")
# install.packages("tidyverse")
library("haven")
library("tidyverse")

# Data manually downloaded from:
# Zank, Susanne, Woopen, Christiane, Wagner, Michael, Rietz, Christian, &
# Kaspar, Roman (2022). Quality of Life and Well-being of Very Old People in NRW
# (Representative Survey NRW80+) Cross-Section Wave 1. GESIS, Cologne.
# ZA7558 Data file Version 2.0.0, https://doi.org/10.4232/1.13978.

# All source data and information to the data can be found in the subfolder
# "source".

# unzip the ZA7558_v2-0-0.dta.zip and save it in data
unzip("source/ZA7558_v2-0-0.dta.zip", exdir = "data/.")

# read in the data
dfdta <- read_dta("data/ZA7558_v2-0-0.dta")
dfsav <- read_sav("source/ZA7558_v2-0-0.sav")

# check if both formats provide the same data
all.equal(dfdta, dfsav)

# --> this is NOT the case. The labels and missings are treated differently.

# save the environment
save.image(file = "data/gesis.RData")
