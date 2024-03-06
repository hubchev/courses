# 1
#Stephan Huber, 000, 2020-May-30

# 2
# setwd("/home/sthu/Dropbox/hsf/22-ss/dsb_bac/work/")

# 3
rm(list=ls())

# 4
if (!require(pacman)) install.packages("pacman")
pacman::p_load(tidyverse, haven)

# 5
# cross-section

# 6
sex <- c("f", "f", "f", "m", "m",  "m")
age <- c(21, 19, 23, 18, 20, 61)
weight <- c(48, 55,63,71,77,85)
calories <- c(1700,1800,2300,2000,2800,2500)
sport <- c(60,120,180,60,240,30)
df <- data.frame(sex, age, weight, calories, sport)

# write_csv(df, file = "/home/sthu/Dropbox/hsf/exams/21-04/stuff/df.csv")
# write_csv(df, file = "/home/sthu/Dropbox/hsf/github/courses/dta/df-calories.csv")
df <- read_csv("https://raw.githubusercontent.com/hubchev/courses/main/dta/df-calories.csv")

# 7 
summary(df)

# 8
df  %>%
  group_by(sex) %>%
  summarise(mcal = mean(calories), 
            sdcal = sd(calories), 
            mweight = mean(weight), 
            sdweight = sd(weight)
            )
 
# 9
# discussed in class

# 10
# Many things can be mentioned here such as the use of colors 
# (red/blue is not a good choice for color blind people), 
# the legend makes no sense as red and green both refer to \textit{sport}, 
# the label of `f' and `m' is not explained in the legend, 
# rotating the labels of the y-axis would increase readability, and 
# both axes do not start at zero which is hard to see. 
# Also, it is a common to draw the variable you want to explain 
# (here: calories) on the y-axis.

# 11
plot(df)

# 12
cor(df$calories, df$sport, method = c("pearson"))
cor(df$weight, df$calories, method = c("pearson"))

# 13
ggplot(df, aes(x = calories, y = weight, label=sex )) +
  geom_point() +
  geom_text(hjust=0, vjust=0) +
  stat_smooth(formula=y~x, method="lm", se=FALSE)

# 14
reg_base <- lm(weight ~ calories, data = df)
summary(reg_base)

# 15
# 1) An increase of 100 calories (taken on average on a daily basis) is associated 
# - on average and ceteris paribus - with 2.69 more of kg the participants are 
# pretended to weight.   
# 2) The estimated coefficient $beta_1$ is statistically significantly different to zero
# on a significance level of 5%.
# 3) About 60 % of the variation of the weight is explained by the 
# estimated coefficients of the empirical model.

# 16
# For omitted variable bias to occur, the omitted variable `Z` must satisfy
# two conditions:
#   1) The omitted variable is correlated with the included regressor 
#   2) The omitted variable is a determinant of the dependent variable 

# 17
# discussed in class


# unload packages
pacman::p_unload(tidyverse, haven)

