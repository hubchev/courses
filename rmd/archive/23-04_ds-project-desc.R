## ----setup, include=FALSE-----------------------------------------------------
library("knitr")
knit_hooks$set(purl = hook_purl)

## ----eval=FALSE---------------------------------------------------------------
#  setwd("/home/sthu/Dropbox/hsf/github/courses/rmd/")
#  rmarkdown::render("23-04_ds-project-desc.Rmd", "all")

## ----echo=TRUE, message=FALSE-------------------------------------------------
#install.packages("devtools")
#library("devtools")
#devtools::install_github("benmarwick/wordcountaddin", type = "source", dependencies = T)
library("wordcountaddin")
wordcount <- wordcountaddin::word_count( )

## ----figofme, echo=FALSE, fig.cap="Prof. Dr. Stephan Huber", out.width = '20%', fig.align = 'center'----
knitr::include_graphics("../pic/huber2.jpeg")

