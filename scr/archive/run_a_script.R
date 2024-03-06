## ---------------------------
## Script name: SH-R-01
## Purpose of script: First script students should run
## ---------------------------
## Author: Dr. Stephan Huber
## Date Created: 2020-09-30
## Copyright (c) Stephan Huber, 2020
## Email: Stephan.Huber@hs-fresenius.de
## ---------------------------


# Let us start with using R within RStudio
# with a # you can write a comment in your script

# with "Ctrl+Enter" you can execute a line of command, try it out:
print("Hello, world!")

# we use the book: "R for Dummies" in the course
# when reading the book, always try to execute the code snippets by your own
# For example, p. 3:
# Simulate 1 million throws of two six‐sided dices:
set.seed(42)
throws <- 1e6
dice <- replicate(2,
                  sample(1:6, throws, replace = TRUE)
)
table(rowSums(dice))

# with a "?" you get some help/information about the functions and operators used 
?set.seed
?assignOps
?sample
?hist
?table

# there are other ways to get help and learn within R
help.start()
example(hist)
apropos("hist")
vignette()
vignette("ggwordcloud")

# Performing multiple calculations with vectors
24 + 7 + 11
1 + 2 + 3 + 4 + 5
14 / 2
# but
14 : 2 # this operator is called sequence
3*2
3      *       2
# but > 3 x 2 does not work!
x <- 1:5  # see assignment operator ?assignOps
x
x + 2
x + 6:10
x
# alternatively:
x2 <- x + 6:10
x3 <- 6:10
x4 <- x + x3

# To construct a vector, type into the console:
c(1, 2, 3, 4, 5)
?c()
b <- c(1, 2, 3, 4, 5)
b

# Packages are sort of R's brain so let's 
# SEE WHAT PACKAGES ARE AROUND
# https://www.r-pkg.org/
# https://cran.r-project.org/web/views/
# For example tidyvers and ggplot2 are powerfull packages to create data-visualizations, see:
# https://www.r-graph-gallery.com/

# LOAD PACKAGES 
# There are a lot of packages pre-installed but not loaded, see here: 
installed.packages()

# A package can be installed using install.packages("<package name>"). 
install.packages("dplyr")
# A package can be removed using remove.packages("<package name>").
remove.packages("dplyr")

# I recommend "pacman" for managing add-on packages. It will
# install packages, if needed, and then load the packages.
install.packages("pacman")

# Then load the package by using either of the following:
require(pacman)  # Gives a confirmation message.
library(pacman)  # No message.

# Or, by using "pacman::p_load" you can use the p_load
# function from pacman without actually loading pacman.
# These are packages I load every time.
pacman::p_load(pacman, dplyr, GGally, ggplot2, ggthemes, 
               ggvis, httr, lubridate, plotly, rio, rmarkdown, shiny, 
               stringr, tidyr) 


# the package "datasets" contains some datasets 
library(datasets)  # Load/unload base packages manually
?datasets
library(help = "datasets")

# CLEAN UP #################################################

# Clear packages
p_unload(dplyr, tidyr, stringr) # Clear specific packages
p_unload(all)  # Easier: clears all add-ons

detach("package:datasets", unload = TRUE)  # For base

# Clear console
cat("\014")  # shortut for doing that is ctrl+L

