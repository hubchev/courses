setwd("/home/sthu/Dropbox/hsf/github/courses/rmd/")

rm(list=ls())

# install.packages("tidyverse")
# install.packages("ggpubr")
# install.packages("sjPlot")
library("tidyverse")
library("ggpubr")
library("sjPlot")
library("GGally")

load(url("https://github.com/hubchev/courses/raw/main/dta/forest.Rdata"))

summary(df)

df <- rename(df, country=country.x)

df <- df %>% 
  mutate(gdp_mio = gdp/1000000)

df  %>%
  group_by(region) %>%
  summarise( mean(gdp_mio), 
             mean(forest)
  )

df  %>%
  group_by(region) %>%
  summarise(m_gdp_pc = mean(gdppc), 
            m_forest = mean(forest)
  )

# rmarkdown::render("exe_forest.Rmd", "all")

cc <- 
  
  df %>% 
  select(country, gdp, gdp_growth, forest) %>%
  plot()


cc <-   df %>% 
  select(gdp, gdp_growth, forest)

ggpairs(cc)
  
plot(cc)
