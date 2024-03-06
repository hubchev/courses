library("WDI")
library("tidyverse")
# install.packages("countrycode")
library("countrycode")
# install.packages("wbstats")
library("wbstats")
rm(list=ls())
setwd("/home/sthu/Dropbox/hsf/github/courses/scr/")


df_forest <- WDI(
  country = "all",
  indicator = "AG.LND.FRST.ZS",
  extra = T,
  start = 1960,
  end = 2025)

my_indicators <- c("pop" = "SP.POP.TOTL",
                   "unemployment" = "SL.UEM.TOTL.ZS",
                   "birthrate" = "SP.DYN.CBRT.IN", 
                   # "forest" = "AG.LND.FRST.ZS",
                   "gdp" = "NY.GDP.MKTP.KD",
                   "growth" = "NY.GDP.PCAP.KD.ZG"
                   )
                   
df <- wb_data(my_indicators)

df <- merge(df, df_forest, by.x = c("iso2c","date"), by.y = c("iso2c","year"))
df <- df %>% select(-country.y, -iso3c.y, -lending)
df <- rename(df, forest=AG.LND.FRST.ZS)

as_tibble(df)
save(df, file = "../dta/forest_all.Rdata")
rm(list=ls())
load("../dta/forest_all.Rdata")



df <- df %>% 
  group_by(country.x) %>%
  mutate(unemployment_dif = c(NA, diff(unemployment))) 

df <- df %>% 
  select(country.x, date, gdp, growth, unemployment, region, income, forest, 
         pop, unemployment_dif) %>%
  rename(gdp_growth = growth) %>% 
  mutate(gdppc = gdp/pop) %>% 
  na.omit() 
  
save(df, file = "../dta/forest.Rdata")




exit()


##############################    ()    #######################################
# Generate a variable of the GDP per capita growth rate. Name the variable 
# 'growth_gdp'. (If you fail here, use the variable 'growth' which is already in
# the dataset as a replacement for 'growth_gdp' in the following tasks.)
################################################################################
df <- df %>% 
  group_by(country) %>%
  mutate(growth_gdp = c(NA, diff(gdp_pc))/lag(gdp_pc, 1)) 




exit <- function() { invokeRestart("abort") 
  print("this is the last message")
}    

# Forest area (% of land area)
# AG.LND.FRST.ZS
# Forest area is land under natural or planted stands of trees of at least 5 meters in situ, whether productive or not, and excludes tree stands in agricultural production systems (for example, in fruit plantations and agroforestry systems) and trees in urban parks and gardens.
# Source: Food and Agriculture Organization, electronic files and web site.

 
# GDP per capita growth (annual %)
# Annual percentage growth rate of GDP per capita based on constant local currency. GDP per capita is gross domestic product divided by midyear population. GDP at purchaser's prices is the sum of gross value added by all resident producers in the economy plus any product taxes and minus any subsidies not included in the value of the products. It is calculated without making deductions for depreciation of fabricated assets or for depletion and degradation of natural resources.
# ID: NY.GDP.PCAP.KD.ZG
# Source: World Bank national accounts data, and OECD National Accounts data files.
#     
# GDP (constant 2015 US$)
# NY.GDP.MKTP.KD
# GDP at purchaser's prices is the sum of gross value added by all resident producers in the economy plus any product taxes and minus any subsidies not included in the value of the products. It is calculated without making deductions for depreciation of fabricated assets or for depletion and degradation of natural resources. Data are in constant 2015 prices, expressed in U.S. dollars. Dollar figures for GDP are converted from domestic currencies using 2015 official exchange rates. For a few countries where the official exchange rate does not reflect the rate effectively applied to actual foreign exchange transactions, an alternative conversion factor is used.
# Source: World Bank national accounts data, and OECD National Accounts data files.

df_gdp <- WDI(
  country = "all",
  indicator = "NY.GDP.MKTP.KD",
  start = 1960,
  end = 2025)

# GDP growth (annual %)
# Annual percentage growth rate of GDP at market prices based on constant local currency. Aggregates are based on constant 2015 prices, expressed in U.S. dollars. GDP is the sum of gross value added by all resident producers in the economy plus any product taxes and minus any subsidies not included in the value of the products. It is calculated without making deductions for depreciation of fabricated assets or for depletion and degradation of natural resources.
# ID: NY.GDP.MKTP.KD.ZG
# Source: World Bank national accounts data, and OECD National Accounts data files.

df_growth <- WDI(
  country = "all",
  indicator = "NY.GDP.MKTP.KD.ZG",
  start = 1960,
  end = 2025)


df_list <- list(df_forest, df_gdp, df_growth)

df <- df_list %>% reduce(full_join, by = c("iso2c","year"))
rm_groups <- unique(df$country[is.na(countrycode(df$iso2c, "iso2c", "iso2c"))])
df$iso2c[df$country == "Kosovo"][1]
df$iso2c[df$country == "Channel Islands"][1]
rm_groups <- rm_groups[-which(rm_groups %in% c("Kosovo", "Channel Islands"))]
df_wdi <- df[!df$country %in% rm.groups, ]
head(df_wdi)
# df <- merge(df_forest, df_gdp, by = c("iso2c","year"))

as_tibble(df_wdi)
rm(list=setdiff(ls(), "df_wdi"))

df_wdi <- 
  df_wdi %>% 
  select(country.x, country.y) %>%
  mutate(gleich=country.x==country.y)

  




