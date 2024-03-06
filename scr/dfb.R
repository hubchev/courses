# In dfb.R I analyze German soccer results

# Set your working directory. 

# Clear th environment.

library("bundesligR")
library("tidyverse")

# Read in the data as tibble as follows:
liga <- as_tibble(bundesligR)

# --------------------------------------
# !!! ERROR:
# "Borussia Moenchengladbach" is also entitled "Bor. Moenchengladbach"!

# How often is "Bor. Moenchengladbach" in the data?

# Show all entries with "Bor. Moenchengladbach".


# Replace "Bor. Moenchengladbach" with "Borussia Moenchengladbach".

# ------------------------------------

# Check for the data class.


# View the data.


# Glimpse on the data.


# Show the first and last observations.


# Show summary statistics to all variables.


# How many teams have played in the league over the years?


# Which teams have played Bundesliga so far?


# How many teams have played Bundesliga?


# How often has each team played in the Bundesliga?


# Show summary statistics of variable `Season` only.


# Show summary statistics of all numeric of variables (`Team` is a character).


# What is the highest number of points ever received by a team?

# Show only the name of the club with the highest number of points ever received.


# Create a new tibble using `liga` removing the variable `Pts_pre_95` from the data.

# Create a new tibble using `liga` renaming W, D, and L to Win, Draw, and Loss.
# Additionally rename GF, GA, GD to Goals_shot, Goals_received, Goal_difference. 

# Create a new tibble using `liga` without the variable `Pts_pre_95` and only 
# observations before the year 1996

# Remove the three tibbles just created from the environment.


# Rename all variables of `liga` to lower cases and store it as `dfb`.


# Show the winner and the runner up after the year 2010.
# Additionally show the points received.


# Create a variable that counts how often a team was ranked first.

# How often has each team played in the Bundesliga?


# Make a ranking that shows which team has played the Bundesliga most often.

# Add a variable to `dfb` that contains the number of appearances of a team in the league.


# Create a number that indicates how often a team has played Bundesliga in a given year. 


# Make a ranking with the number of titles of all teams that ever won the league.

# Create a numeric identifying variable for each team.

# When a team is in the league, what is the probability that it wins the league?


# Make a scatterplot with points on the y-axis and position on the x-axis.


# Make a scatterplot with points on the y-axis and position on the x-axis.
# Additionally, only consider seasons with 18 teams and
# add lines that make clear how many points you needed to be placed 
# in between rank 2 and 15.


