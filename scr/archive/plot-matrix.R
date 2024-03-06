
setwd("/home/sthu/Dropbox/hsf/22-ss/dsb_bac/work/")
rm(list=ls())
library(tidyverse)
library("GGally")
  read_csv("https://raw.githubusercontent.com/hubchev/courses/main/dta/classdata.csv") %>%
  select(sex,weight,height,siblings) %>% 
  ggpairs(.,
          title = "Graphical Visualization of Our Survey in a Matrix: An Example", 
          mapping = ggplot2::aes(colour=sex), 
          lower = list(continuous = wrap("smooth", alpha = 0.9, size=1.1), 
                       discrete = "blank", combo="count"), 
          diag = list(discrete="barDiag", 
                      continuous = wrap("densityDiag", alpha=0.4 )), 
          upper = list(combo = wrap("box_no_facet", alpha=0.5),
                       continuous = wrap("cor", size=4, align_percent=0.8))) + 
  theme(panel.grid.major = element_blank())    # remove gridlines ,
legend = "This chart was created in R using the ggpairs() function"
