################################################################################
# Dear students, I hope you are doing good. 
# In the following I will give you some tasks and hints what you should study 
# and repeat, respectively.
################################################################################

# ==============================================================================
# 0. 
# Set your working directory and clear the environment.
# ______________________________________________________________________________


# ==============================================================================
# 1. 
# Download and read the most recent version of the lecture notes.
# ______________________________________________________________________________


# ==============================================================================
# 2. 
# Read: Wickham and Grolemund (2018, ch. "Workflow: basics"). 
# See: https://r4ds.had.co.nz/workflow-basics.html 
# ______________________________________________________________________________


# ==============================================================================
# 3. 
# Answer the following questions:

# ===
# a) 
# Run the two following lines of code 
# (a.k.a. send it from the script to the console)
# Why does the second line of code not work? Look carefully! 
# This may seem like an exercise in pointlessness, but training your brain
# to notice even the tiniest difference will pay off when programming.)

my_variable <- 10
my_varıable
  
# ===
# b)
# Tweak each of the following R commands so that they run correctly:
    
library(tidyverse)

ggplot(dota = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy))

fliter(mpg, cyl = 8)

filter(diamond, carat > 3)

# Solutions:
ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy))

ggplot(data = mpg) + 
  geom_point() +
  aes(x = displ, y = hwy)

filter(diamonds, carat > 3)

filter(mpg, cyl == 8)


# ===
# c)
# Press Alt + Shift + K. What happens? How can you get to the same place using
# the menus?
# ______________________________________________________________________________


# ==============================================================================
# 4. 
# Read Wickham and Grolemund (2018, ch. "Data transformation") 
# See: https://r4ds.had.co.nz/transform.html
# 
# Answer the following questions (Also see lecture notes excercise "Subsetting")
# 
# --- Solutions to these questions can be found here:
# https://raw.githubusercontent.com/hubchev/courses/main/scr/exe_subset.R
# !!! For your own benefit: try to come up with the solution yourself.  

# ===
# Load the following packages: tidyverse, dplyr, and tibble.


# ===
# Check to see if you have the mtcars dataset by entering the command mtcars.


# ===
# Save the mtcars dataset in an object named cars.


# ===
# What class is cars?


# ===
# How many observations (rows) and variables (columns) are in the 
# mtcars dataset?


# ===
# Rename mpg in cars to MPG. Use rename().


# ===
# Convert the column names of cars to all upper case. Use rename\_all, 
# and the toupper command.


# ===
# Convert the rownames of cars to a column called car using 
# rownames\_to\_column. 


# ===
# Subset the columns from cars that end in "p" and call it pvars 
# using ends\_with().


# ===
# Create a subset cars that only contains the columns: wt, qsec, and hp and 
# assign this object to carsSub.  (Use select().)


# ===
# What are the dimensions of carsSub? (Use dim().)


# ===# Convert the column names of carsSub to all upper case. Use rename\_all(), 
# and toupper() (or colnames()).


# ===
# Subset the rows of cars that get more than 20 miles per gallon (mpg) 
# of fuel efficiency. How many are there? (Use filter().)


# ===
# Subset the rows that get less than 16 miles per gallon (mpg) of fuel 
# efficiency and have more than 100 horsepower (hp). 
# How many are there? (Use filter() and the pipe operator.)


# ===
# Create a subset of the cars data that only contains the columns: wt, qsec, and
# hp for cars with 8 cylinders (cyl) and reassign this object to carsSub. 
# What are the dimensions of this dataset? Don't use the pipe operator.


# ===
# Create a subset of the cars data that only contains the columns: 
# wt, qsec, and hp for cars with 8 cylinders (cyl) and reassign 
# this object to carsSub2. Use the pipe operator.


# ===
# Re-order the rows of carsSub by weight (wt) in increasing order. 
# (Use arrange().)


# ===
# Create a new variable in carsSub called wt2, which is equal to $wt^2$, 
# using mutate() and piping \%>\%.

# ______________________________________________________________________________



# ==============================================================================
# 5. 
# Read Wickham and Grolemund (2018, ch. "Data transformation") 
# See: https://r4ds.had.co.nz/transform.html
# Answer the question (1) of exercise 5.2.4 of Wickham and Grolemund (2018)
# See: 
# https://r4ds.had.co.nz/transform.html#exercises-8
# 
# Solutions can be found here:
# https://jrnold.github.io/r4ds-exercise-solutions/transform.html
# !!! For your own benefit: try to come up with the solution yourself. 

# ===
# Find all flights that


# ===
# Had an arrival delay of two or more hours


# ===
# Flew to Houston (IAH or HOU)


# ===
# Were operated by United, American, or Delta


# ===
# Departed in summer (July, August, and September)


# ===
# Arrived more than two hours late, but didn’t leave late


# ===
# Were delayed by at least an hour, but made up over 30 minutes in flight


# ===
# Departed between midnight and 6 am (inclusive)

# ______________________________________________________________________________
