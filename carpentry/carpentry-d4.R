library("rvest")
library("ggplot2")
library(forcats)
library(dplyr)

# read un-tidy table from web
url <- "https://www.nidcr.nih.gov/research/data-statistics/oral-cancer/incidence"
page <- read_html(url)
table <- html_table(page, fill = TRUE)

raw <- table[[1]]

control_table <- wrapr::build_frame(
  "Age",  "Rate"      |
    "All",  "All Ages"  |
    "0-19",  "0 to 19"   |
    "20-29",  "20 to 29"  |
    "30-39",  "30 to 39"  |
    "40-49",  "40 to 49"  |
    "50-59",  "50 to 59"  |
    "60-69",  "60 to 69"  |
    "70-79",  "70 to 79"  |
    "80+",  "80+"  
)

#convert to tidy form
df_tall <- cdata::rowrecs_to_blocks(
  wideTable        = raw,
  controlTable     = control_table,
  controlTableKeys = c("Age"),
  columnsToCopy    = c("Race", "Gender")
)

df2 <- data.frame(df_tall)

#filtering specific details
df2 <- df2[(df2$Race %in% c("White","Black","Asian or Pacific Islander","Hispanic")),]
df2 <- df2[(df2$Gender %in% c("Male","Female")),]
df2 <- df2[!(df2$Age == "All"),] 

#adding factors for facets
df2 <- df2 %>% 
  mutate(Race = factor(Race)) %>%
  mutate(Gender = factor(Gender)) %>%
  mutate(Age = ordered(Age)) %>%
  mutate(Race = fct_reorder(Race, Rate)) %>%
  mutate(Race = fct_recode(Race, Asian = "Asian or Pacific Islander"))

#add third category to account for different smoking rates
fem_fix <- df2 %>% 
  filter(Gender == "Female") %>%
  mutate(Rate = Rate * 1.228)

fem_fix$Gender <- "FemaleFixed"

#append this to original df

df2 <- rbind(df2, fem_fix)

colnames(df2)[colnames(df2)=="Gender"] <- "Sex"

levels(df2$Age) <- ordered(c("19","29","39","49","59", "69","79","+"))

saveRDS(df2, "data/data-d4.rds")
