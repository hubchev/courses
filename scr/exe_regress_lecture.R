## ---- echo = TRUE--------------------------------------------------
# install and load packages
if (!require(pacman)) install.packages("pacman")
pacman::p_load(tidyverse, haven, ggplot2, sjPlot)

classdata <- read.csv("https://raw.githubusercontent.com/hubchev/courses/main/dta/classdata.csv")

head(classdata)

## ---- echo = TRUE--------------------------------------------------

summary(classdata)

## ----pressure, echo=TRUE-------------------------------------------
ggplot(classdata, aes(x = height, y = weight)) +
  geom_point()


## ---- echo=TRUE----------------------------------------------------
ggplot(classdata, aes(x = height, y = weight)) +
  geom_point() +
  stat_smooth(formula = y ~ x, method = "lm", se = FALSE, colour = "red", linetype = 1)


## ---- echo=TRUE----------------------------------------------------
## baseline regression  model
model <- lm(weight ~ height + sex, data = classdata)
show(model)
interm <- model$coefficients[1]
slope <- model$coefficients[2]
interw <- model$coefficients[1] + model$coefficients[3]

## ---- echo=TRUE----------------------------------------------------
summary(model)

## ---- echo=TRUE----------------------------------------------------
ggplot(classdata, aes(x = height, y = weight, shape = sex)) +
  geom_point() +
  geom_abline(slope = slope, intercept = interw, linetype = 2, size = 1.5) +
  geom_abline(slope = slope, intercept = interm, linetype = 2, size = 1.5) +
  geom_abline(slope = coef(model)[[2]], intercept = coef(model)[[1]])


## ---- echo=TRUE----------------------------------------------------

ggplot(classdata, aes(x = height, y = weight, shape = sex)) +
  geom_point(aes(size = 2)) +
  stat_smooth(
    formula = y ~ x, method = "lm",
    se = FALSE, colour = "red", linetype = 1
  )


## ---- echo=TRUE----------------------------------------------------
ggplot(classdata, aes(x = height, y = weight, shape = sex)) +
  geom_point(aes(size = siblings))


## ---- echo=TRUE----------------------------------------------------
## baseline model
model <- lm(weight ~ height + sex, data = classdata)

ggplot(classdata, aes(x = height, y = weight, shape = sex)) +
  geom_point(aes(size = 2)) +
  stat_smooth(
    formula = y ~ x,
    method = "lm",
    se = T,
    colour = "red",
    linetype = 1
  )

## ---- echo=TRUE, results='hide'------------------------------------

m1 <- lm(weight ~ height, data = classdata)
m2 <- lm(weight ~ height + sex, data = classdata)
m3 <- lm(weight ~ height + sex + height * sex, data = classdata)
m4 <- lm(weight ~ height + sex + height * sex + siblings, data = classdata)
m5 <- lm(weight ~ height + sex + height * sex, data = subset(classdata, siblings < 4))


tab_model(m1, m2, m3, m4, m5,
  p.style = "stars",
  p.threshold = c(0.2, 0.1, 0.05),
  show.ci = FALSE,
  show.se = FALSE
)

## ---- echo=FALSE---------------------------------------------------
tab_model(m1, m2, m3, m4,
  p.style = "stars",
  p.threshold = c(0.2, 0.1, 0.05),
  show.ci = FALSE,
  show.se = FALSE
)

## ---- echo=FALSE---------------------------------------------------
tab_model(m3, m5,
  p.style = "stars",
  p.threshold = c(0.2, 0.1, 0.05),
  show.ci = FALSE,
  show.se = FALSE
)

## ---- echo=T-------------------------------------------------------
plot(residuals(m3), fitted(m3))
plot(residuals(m3), classdata$siblings)

#  unload packages
suppressMessages(pacman::p_unload(tidyverse, haven, sjPlot))
