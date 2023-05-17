# Base R or pipe
# exe_base_pipe.R
# Stephan Huber; 2023-05-08

setwd("/home/sthu/Dropbox/hsf/test")
rm(list=ls())

library("datasets")
library("tidyverse")
library("dplyr")

# a)
# Using the pipe |> 
# Select rows where cyl is 4 or 6 and wt is less than 3.5
df1 <- mtcars |> 
  filter(cyl %in% c(4, 6) & wt < 3.5)  
df1

# Without the pipe |> 
# Select rows where cyl is 4 or 6 and wt is less than 3.5
df2 <- subset(mtcars, cyl %in% c(4, 6) & wt < 3.5)
df2

# Check if the resulting dataframe is identical to the expected output
identical(df1, df2)


# b)
# Using the pipe |> and tidyverse (mutate)
df3 <- mtcars |> 
  mutate(cyl_4_or_6 = 
           if_else(cyl %in% c(4, 6) & wt < 3.5, TRUE, FALSE))
df3

# without pipe and with base R (transform)
df4 <- mtcars
df4$cyl_4_or_6 <- with(mtcars, cyl %in% c(4, 6) & wt < 3.5)

# Alternatively in one line:
df5 <- transform(mtcars, cyl_4_or_6 = cyl %in% c(4,6) & wt < 3.5)

# Check if the resulting dataframe is identical to the expected output
identical(df3, df4)
identical(df3, df5)
