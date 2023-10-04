## ----setup, include=FALSE-----------------------------------------------------
library("knitr")
knit_hooks$set(purl = hook_purl)

## ----eval=FALSE---------------------------------------------------------------
#  setwd("/home/sthu/Dropbox/hsf/github/courses/rmd/")
#  rmarkdown::render("23-09_ds-project-desc.Rmd", "all")

## ----echo=TRUE, message=FALSE-------------------------------------------------
#install.packages("devtools")
#library("devtools")
#devtools::install_github("benmarwick/wordcountaddin", type = "source", dependencies = T)
library("wordcountaddin")
wordcount <- wordcountaddin::word_count()


## ----figofme, echo=FALSE, fig.cap="Prof. Dr. Stephan Huber", out.width = '20%', fig.align = 'center'----
knitr::include_graphics("/home/sthu/Dropbox/hsf/pic/huber2.jpeg")

## -----------------------------------------------------------------------------
iris2 <- head(iris)
knitr::kable(iris2, caption = "An example table caption.")

