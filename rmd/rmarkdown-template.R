## ----setup, include=FALSE-----------------------------------------------------
library("knitr")
knit_hooks$set(purl = hook_purl)

## ----message=FALSE, include=FALSE---------------------------------------------
#install.packages("devtools")
#library("devtools")
#devtools::install_github("benmarwick/wordcountaddin", type = "source", dependencies = T)
library("wordcountaddin")

## ---- echo=F, message=FALSE---------------------------------------------------
#Wordcount:
wordcount <- wordcountaddin::word_count( )

## ----echo=TRUE----------------------------------------------------------------
setwd("/home/sthu/Dropbox/hsf/github/courses/rmd/")

## -----------------------------------------------------------------------------
norm <- rnorm(100, mean = 0, sd = 1)

## ---- echo = FALSE------------------------------------------------------------
A <- c("a", "a", "b", "b")
B <- c(5, 10, 15, 20)
dataframe <- data.frame(A, B)
print(dataframe)

## ---- warning = FALSE---------------------------------------------------------
library(dplyr)

## ---- fig.width = 4, fig.height = 3-------------------------------------------
A <- c("a", "a", "b", "b")
B <- c(5, 10, 15, 20)
dataframe <- data.frame(A, B)
print(dataframe)
boxplot(B~A,data=dataframe)

## -----------------------------------------------------------------------------
library("tidyverse")

## ----include=TRUE-------------------------------------------------------------
library("rmarkdown")
paged_table(mtcars)

