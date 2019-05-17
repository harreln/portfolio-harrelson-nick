library(dplyr)
library(readr)
library(tidyr)
library(forcats)

alt_alum6061 <- read_tsv("data-raw/alt-alum.csv")
mean_alum6061 <- read_tsv("data-raw/mean-alum.csv")
alt_alum2024 <- read_tsv("data-raw/alt-alum2024.csv")
mean_alum2024 <- read_tsv("data-raw/mean-alum2024.csv")
alt_steel <- read_tsv("data-raw/alt-steel.csv")
mean_steel <- read_tsv("data-raw/mean-steel.csv")
alt_poly <- read_tsv("data-raw/alt-poly.csv")
mean_poly <- read_tsv("data-raw/mean-poly.csv")
alt_delrin <- read_tsv("data-raw/alt-delrin.csv")
mean_delrin <- read_tsv("data-raw/mean-delrin.csv")

df1 <- data.frame(alternating = alt_alum6061$`Maximum Principal Stress (Pa)`, mean = mean_alum6061$`Maximum Principal Stress (Pa)`, material = "Aluminum 6061-T6") %>%
  mutate(x = mean/(310*(10^6))) %>%
  mutate(y = alternating/(96.5*(10^6)))
df2 <- data.frame(alternating = alt_alum2024$`Maximum Principal Stress (Pa)`, mean = mean_alum2024$`Maximum Principal Stress (Pa)`, material = "Aluminum 2024") %>%
  mutate(x = mean/(469*(10^6))) %>%
  mutate(y = alternating/(138*(10^6)))
df3 <- data.frame(alternating = alt_steel$`Maximum Principal Stress (Pa)`, mean = mean_steel$`Maximum Principal Stress (Pa)`, material = "1144 Steel") %>%
  mutate(x = mean/(620*(10^6))) %>%
  mutate(y = alternating/(350*(10^6)))
df4 <- data.frame(alternating = alt_poly$`Maximum Principal Stress (Pa)`, mean = mean_poly$`Maximum Principal Stress (Pa)`, material = "Polycarbonate") %>%
  mutate(x = mean/(65*(10^6))) %>%
  mutate(y = alternating/(13.8*(10^6)))
df5 <- data.frame(alternating = alt_delrin$`Maximum Principal Stress (Pa)`, mean = mean_delrin$`Maximum Principal Stress (Pa)`, material = "Delrin") %>%
  mutate(x = mean/(69*(10^6))) %>%
  mutate(y = alternating/(32*(10^6)))

df <- rbind(df1,df2) %>%
  rbind(df3) %>%
  rbind(df4) %>%
  rbind(df5)

df$material <- fct_reorder2(df$material, df$x, df$y)

#save data
saveRDS(df, "data/data-d3.rds")
# 
# x_axis = mean_stress/ult_tensile;
# y_axis = alt_stress/fatigue_str;