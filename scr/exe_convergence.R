# Convergence

# set working directory
# setwd("/home/sthu/Dropbox/hsf/github/courses/")


# clear the environment
rm(list = ls())

# some packages needed install.packages(...) and load packages library(...)

# Let us do the following:
  # 1. check if a package is installed
  # 2. if not installed the package should be installed and loaded
  # 3. if installed the package should be loaded
# I like to do it with a function that is part of pacman package:


# load packages
if (!require(pacman)) install.packages("pacman")
pacman::p_load(haven, tidyverse, vtable, gtsummary, pastecs, Hmisc, 
               sjlabelled, tis, ggpubr, sjPlot, psych)

# an alternative is to install and load it like that
# install.packages(c("haven", "tidyverse", "vtable", "gtsummary", "pastecs"))
# library(c("haven", "tidyverse", "vtable", "gtsummary", "pastecs"))

# import data
data <- read_dta("https://github.com/hubchev/courses/raw/main/dta/convergence.dta")

# inspect data
names(data)
str(data)
data
head(data)
tail(data)
summary(data)
view(data)

#library(vtable)
# vtable(data, missing=TRUE)

# library(pastecs)
stat.desc(data)

# library(Hmisc)
describe(data)

# library(gtsummary)
tbl_summary(data)

# check the assignments of countries to continents
data %>% 
  select(country, africa, asia, weurope) %>% 
  view()

data <- mutate(data, x_1 = africa + asia + weurope)

data %>% 
  filter(x_1==0) %>% 
  select(africa, asia, weurope, country) %>% 
  view()

# correct the assignment manually
data$weurope[data$country == "Austria"] <- 1
data$weurope[data$country == "Greece"] <- 1
data$weurope[data$country == "Cyprus"] <- 1

filter(data, data$weurope==1) # check changes

# In the following, I do the same with a loop
# c_europe <- c("Austria","Greece","Cyprus")
# sum(data$weurope)                       # check changes
# for (i in c_europe){
#   print(i)
#   data$weurope[data$country == i] <- 1
#   }
# sum(data$weurope)                       # check changes
# data$weurope[data$country == "Austria"] # check changes

# create a category for the remaining countries
# use ifelse -- ifelse(condition, result if TRUE, result if FALSE)
data$rest <- ifelse(data$africa == 0 & data$asia == 0 & data$weurope == 0, 1, 0)
data$rest <- set_label(data$rest, label = "=1 if not in Africa, W.Europe, or Asia")

# create table with means across country groups
table_gdp <- data %>%
  group_by(africa, asia, weurope) %>%
  summarise_at(vars(gdppc60:gdppc95), list(name = mean))

data %>%
  group_by(africa, asia, weurope) %>%
  select(gdppc60:gdppc95) %>% 
  summarise_all(mean)

# create growth rate
data$gr1 <- (data$gdppc95 - data$gdppc60)/data$gdppc60
data$gr2 <- log(data$gdppc95) - log(data$gdppc60)
cor(data$gr1, data$gr2)

ggplot(data, aes(x = gdppc60, y = growth, label=country)) +
  geom_point() +
  geom_text(hjust=0, vjust=0) 

p1 <- ggplot(data, aes(x = gdppc60, y = growth, label=country )) +
  geom_point() +
  stat_smooth(formula=y~x, method="lm", se=FALSE, colour="red", linetype=1) +
 # geom_text(hjust=0, vjust=0) +
  ggtitle("World")

p2 <- data %>% 
  filter(weurope==1) %>% 
  ggplot( aes(x = gdppc60, y = growth, label=country )) +
  geom_point() +
  stat_smooth(formula=y~x, method="lm", se=FALSE, colour="red", linetype=1) +
  #geom_text(hjust=0, vjust=0) +
  ggtitle("Western Europe")

p3 <- data %>% 
  filter(asia==1) %>% 
  ggplot( aes(x = gdppc60, y = growth, label=country )) +
  geom_point() +
  stat_smooth(formula=y~x, method="lm", se=FALSE, colour="red", linetype=1) +
 # geom_text(hjust=0, vjust=0) +
  ggtitle("Asia")

p4 <- data %>% 
  filter(africa==1) %>% 
  ggplot( aes(x = gdppc60, y = growth, label=country )) +
  geom_point() +
  stat_smooth(formula=y~x, method="lm", se=FALSE, colour="red", linetype=1) +
#  geom_text( hjust=0, vjust=0) +
  ggtitle("Africa")

ggarrange(p1, p2, p3, p4 , 
          labels = c("A", "B", "C", "D"),
          ncol = 2, nrow = 2)

# Regression analysis
m1  <-  lm(growth ~ gdppc60, data = data)
m2  <-  lm(growth ~ gdppc60, data = subset(data, weurope==1))
m3  <-  lm(growth ~ gdppc60, data = subset(data, asia==1))
m4  <-  lm(growth ~ gdppc60, data = subset(data, africa==1))

tab_model(m1, m2, m3, m4,
          p.style = "stars",
          p.threshold = c(0.2, 0.1, 0.05),
          show.ci = FALSE, 
          show.se = FALSE, 
          show.aic = TRUE,
          dv.labels = c("World", "W.Europe", "Asia", "Africa")) 


# reshape data (see: https://stackoverflow.com/questions/2185252/reshaping-data-frame-from-wide-to-long-format)
data_long <- gather(data, condition, measurement, gdppc60:gdppc95, factor_key=TRUE)
data_long$year <- as.numeric(substr(data_long$condition, 6, 7))

data_long$gr_long <- data_long %>% 
  select(country,measurement) %>%
  group_by(country) %>%
  mutate(gr = c(NA,diff(measurement))/lag(measurement, 1))

# erase all helping variables
data <- select(data, -starts_with("h_"))

# generate and remove variables in a dataframe
data <- mutate(data, Land = country)
data <- select(data, -country)




data %>%
  summarise(
    y65 = mean(gdppc65, na.rm = TRUE),
    y70 = mean(gdppc70, na.rm = TRUE),
    y75 = mean(gdppc75, na.rm = TRUE),
    y80 = mean(gdppc80, na.rm = TRUE),
    y85 = mean(gdppc85, na.rm = TRUE),
    y90 = mean(gdppc90, na.rm = TRUE),
    y95 = mean(gdppc95, na.rm = TRUE)
  )

suppressMessages(pacman::p_unload(haven, tidyverse, vtable, gtsummary, pastecs, Hmisc, 
               sjlabelled, tis, ggpubr, sjPlot))

    
