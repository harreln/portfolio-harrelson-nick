# Visualizing Data D1 Carpentry
# Nick Harrelson
# March 28 2019

library(dplyr)
library(countrycode)

wine <- read_csv("data-raw/winemag-data_first150k.csv")

#remove unnecessary columns
wine <- wine[c("country", "points", "price")]

#populate secondary df for continent joining
continent_df = data.frame(unique(wine$country))
#rename column to match first df
colnames(continent_df)[colnames(continent_df)=="unique.wine.country."] <- "country"
#solve for continents
continent_df$continent = countrycode(sourcevar = continent_df$country,
                                     origin = "country.name",
                                     destination = "continent")
#fix north/south america in secondary df 
continent_df$continent <- recode(continent_df$continent, Americas = "South America")
continent_df$continent[continent_df$country %in% c("US","Canada","Mexico")] <- "North America"

#join the two df's
wine <- left_join(wine, continent_df, by = NULL, copy = FALSE)
#remove NA data
wine <- wine[complete.cases(wine), ] %>%
  filter(wine$quality >= 80)

#add good/bad separation
wine$quality <- ifelse(wine$points <= 86,"Acceptable/Good", ifelse(wine$points <= 93, "Very Good/Excellent", "Superb/Classic"))

#keep final columns of interest 
wine <- wine %>%
  mutate(quality = factor(quality, levels = c("Acceptable/Good","Very Good/Excellent","Superb/Classic"))) %>%
  mutate(continent = factor(continent)) %>%
  mutate(continent = fct_reorder(continent, price)) %>%
  filter(continent %in% c("Africa","Asia","Europe","North America","Oceania","South America"))

saveRDS(wine, "data/wine-data-d1.rds")
