library(tabulizer)
library(dplyr)
library(stringr)
library(readr)
library(tidyverse)

loc1 <- '../portfolio-harrelson-nick/data-raw/pdf1.pdf'
loc2 <- '../portfolio-harrelson-nick/data-raw/pdf2.pdf'
loc3 <- '../portfolio-harrelson-nick/data-raw/pdf3.pdf'
loc4 <- '../portfolio-harrelson-nick/data-raw/pdf4.pdf'

# Extract the first table: 2009,2010
out1 <- extract_tables(loc1)[[1]] %>% 
  as_tibble() %>% 
  slice(5:24)
out1["2010"] <- str_split_fixed(out1$V2, " ", 4)[,3]
out1["2009"] <- str_split_fixed(out1$V2, " ", 4)[,1]
out1 <- out1[c("V1", "2010", "2009")] %>% 
  rename(commodity = V1) %>%
  gather('2009','2010', key="year", value="value")
out1["value"] <- parse_number(out1$value)

# Extract the second table: 2011, 2012, 2013
out2 <- extract_tables(loc2)[[1]] %>% 
  as_tibble()  %>% 
  slice(4:23) %>%
  rename(commodity = V1) %>% 
  rename("2011" = V2) %>% 
  rename("2012" = V4) %>%
  rename("2013" = V5)
out2 <- out2[c("commodity", "2011", "2012", "2013")] %>% 
  gather(`2011`, `2012`, `2013`, key = "year", value = "value")
out2["value"] <- parse_number(out2$value)

# Extract the third table: 2014, 2015, 2016
out3 <- extract_tables((loc3))[[1]] %>% 
  as_tibble() %>% 
  slice(5:24) %>%
  rename(commodity = V1) %>% 
  rename("2014" = V2) %>%
  rename("2016" = V5)
out3["2015"] <- str_split_fixed(out3$V3, " ",2)[,2]
out3 <- out3[c('commodity', '2014','2015','2016')] %>% gather('2014','2015','2016',key = 'year', value = 'value')
out3["value"] <- parse_number(out3$value)

# Extract the fourth table: 2017
out4 <- extract_tables((loc4))[[1]] %>%
  as_tibble() %>% 
  slice(5:24) %>%
  rename(commodity = V1) %>%
  rename("2017" = V4)
out4 <- out4[c('commodity','2017')] %>% gather('2017',key = 'year',value='value')
out4["value"] <- parse_number(out4$value)

# Combine four sources into single tibble
df <- out1 %>% 
  rbind(out2) %>% 
  rbind(out3) %>% 
  rbind(out4) 

#fix names in commodity to match
df$commodity[df$commodity == "Carrots 1"] <- "Carrots"
df$commodity[df$commodity == "Carrots, Fresh"] <- "Carrots"
df$commodity[df$commodity == "Carrots, All"] <- "Carrots"
df$commodity[df$commodity == "Tomatoes, All"] <- "Tomatoes"
df$commodity[df$commodity == "Cattle and Calves"] <- "Cattle & Calves"
df$commodity[df$commodity == "Pistachio"] <- "Pistachios"
df$commodity[df$commodity == "Cotton Lint, All"] <- "Cotton"
df$commodity[df$commodity == "Cotton, All"] <- "Cotton"
df$commodity[df$commodity == "Peppers, All"] <- "Peppers"
df$commodity[df$commodity == "Broilers"] <- "Chickens"
df$commodity[df$commodity == "Berries, All Strawberries"] <- "Strawberries"

# remove low count data points
df <- df %>% 
  filter(commodity != "Avocados") %>%
  filter(commodity != "Garlic")

# setup factors
df <- df %>%
  mutate(commodity = factor(commodity)) %>%
  mutate(commodity = fct_reorder(commodity, value)) %>%
  mutate(year = factor(year)) %>%
  mutate(value = value/(1000*1000))

df$drought[df$year == "2009"] <- "Severe"
df$drought[df$year == "2010"] <- "None"
df$drought[df$year == "2011"] <- "None"
df$drought[df$year == "2012"] <- "Moderate"
df$drought[df$year == "2013"] <- "Extreme"
df$drought[df$year == "2014"] <- "Exceptional"
df$drought[df$year == "2015"] <- "Exceptional"
df$drought[df$year == "2016"] <- "Exceptional"
df$drought[df$year == "2017"] <- "Abnormally Dry"

df$drought <- factor(df$drought, levels = c("None","Abnormally Dry","Moderate","Severe","Extreme","Exceptional"))

# save data
saveRDS(df, "data/ca-commodities-d2.rds")