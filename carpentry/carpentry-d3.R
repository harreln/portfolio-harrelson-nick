library(dplyr)
library(readr)
library(tidyr)
library(forcats)

#load individual happiness reports
happy1 <- read_csv("data-raw/2015whr.csv")
happy1 <- happy1[c("Country","Happiness Score","Region")]
happy2 <- read_csv("data-raw/2016whr.csv")
happy2 <- happy2[c("Country","Happiness Score","Region")]
happy3 <- read_csv("data-raw/2017whr.csv")
happy3 <- happy3[c("Country","Happiness.Score")] %>% left_join(happy2[c("Country","Region")])

#add year to reports
happy1$Year <- '2015'
happy2$Year <- '2016'
happy3$Year <- '2017'

#fix column name
colnames(happy3)[colnames(happy3)=="Happiness.Score"] <- "HappinessScore"
colnames(happy2)[colnames(happy2)=="Happiness Score"] <- "HappinessScore"
colnames(happy1)[colnames(happy1)=="Happiness Score"] <- "HappinessScore"

#combine happiness dfs
happy <- rbind(happy1,happy2) %>% rbind(happy3)

#load and fix GDP df
gdp <- read_csv("data-raw/gdp_data.csv")
gdp <- gdp[c("Country Name", "2015","2016","2017")] %>%
  gather(`2015`, `2016`, `2017`, key = "Year", value = "GDP") %>%
  mutate(GDP = GDP/(10^9))
colnames(gdp)[colnames(gdp)=="Country Name"] <- "Country"

#join together
df <- inner_join(happy,gdp)

#add population data
pop <- read_csv("data-raw/population.csv") %>%
  filter(Year == 2015)
pop <- pop[c("Country Name", "Value")]
colnames(pop)[colnames(pop)=="Country Name"] <- "Country"
colnames(pop)[colnames(pop)=="Value"] <- "Population"

df <- left_join(df,pop)
  
df <- df %>% mutate(Region = factor(Region)) %>%
  mutate(Region = fct_reorder(Region, HappinessScore)) %>%
  mutate(Population = Population/(10^6))

df <- df[complete.cases(df),]
df <- df[!(df$Region=="Australia and New Zealand"),] %>% 
  mutate(Region = fct_recode(Region, "Middle East and North Africa" = "Middle East and Northern Africa"))

#save data
saveRDS(df, "data/data-d3.rds")
