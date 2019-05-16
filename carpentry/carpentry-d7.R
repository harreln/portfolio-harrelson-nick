library(dplyr)
library(readr)
library(tidyr)
library(forcats)

#load individual happiness reports
happy <- as.data.frame(read_csv("data-raw/2017whr.csv"))

#load and fix GDP df
gdp <- read_csv("data-raw/gdp_data.csv")
gdp <- gdp[c("Country Name","2017")] %>%
  gather(`2017`, key = "Year", value = "GDP") %>%
  mutate(GDP = log(GDP/(10^9)))
colnames(gdp)[colnames(gdp)=="Country Name"] <- "Country"

gdp$Country <- gsub("Russian Federation", "Russia", gdp$Country)
gdp$Country <- gsub("Congo, Rep.", "Congo (Brazzaville)", gdp$Country)
gdp$Country <- gsub("Congo, Dem. Rep.", "Congo (Kinshasa)", gdp$Country)
gdp$Country <- gsub("Egypt, Arab Rep.", "Egypt", gdp$Country)
gdp$Country <- gsub("Iran, Islamic Rep." , "Iran", gdp$Country)
gdp$Country <- gsub("Papua New Guinea"   , "Guinea", gdp$Country)

#join together
df <- inner_join(happy,gdp)
df <- df[c("Country","Happiness.Score","GDP")]
colnames(df) <- c("Country","Happiness","GDP")

df$Country <- gsub("Czech Republic", "Czech Rep.", df$Country)
df$Country <- gsub("Dominican Republic", "Dominican Rep.", df$Country)
df$Country <- gsub("South Sudan", "S. Sudan", df$Country)
df$Country <- gsub("Central African Republic", "Central African Rep.", df$Country)
df$Country <- gsub("Bosnia and Herzegovina", "Bosnia and Herz.", df$Country)
df$Country <- gsub("Guinea", "Papua New Guinea ", df$Country)

#save data
saveRDS(df, "data/data-d7.rds")