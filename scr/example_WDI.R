if (!require(pacman)) install.packages("pacman")
pacman::p_load(WDI, wbstats)

?WDI
WDIsearch("gdp")[1:10, ]
dat <- WDI(indicator = "NY.GDP.PCAP.KD", country = c("MX", "CA", "US"), start = 1960, end = 2012)
head(dat)

library(ggplot2)
ggplot(dat, aes(year, NY.GDP.PCAP.KD, color = country)) +
  geom_line() +
  xlab("Year") +
  ylab("GDP per capita")
