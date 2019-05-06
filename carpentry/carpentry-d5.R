library(dplyr)
library(httr)
library(XML)
library(stringr)
library(stringi)
library(lubridate)

# List of separate pages
urls <- list()
dates <- list()
year <- list()

years <- c("2017","2018","2019")
months = c("January","February","March","April","May","June","July","August","September","October","November","December")

# generate urls

for (y in years){
  for (m in months){
    urls[length(urls)+1] <- sprintf("https://en.wikipedia.org/wiki/List_of_terrorist_incidents_in_%s_%s", m,y)
    dates[length(dates)+1] <- sprintf("%s %s", m,y)
    year[length(year)+1] <- sprintf("%s", y)
  }
}

# help keep track of other iterables
urls <- unlist(urls)
dates <- unlist(dates)
year <- unlist(year)

# scrape it all baby
df <- data.frame()
test <- list()

col_names <- c("Date","Type","Dead","Injured","Location","Details","Perpetrator","Part of")

# Scrape tables and append to main df
for(url in urls){
  print(url)
  if (url == "https://en.wikipedia.org/wiki/List_of_terrorist_incidents_in_June_2019"){
    break
  }
  
  r <- GET(url)
  doc <- readHTMLTable(doc=content(r, "text"), header = TRUE)
  doc <- setNames(doc[[1]], col_names)
  
  monthyear <- rep(dates[url == urls], nrow(doc))
  doc <- cbind(doc, monthyear)
  
  yearcol <- rep(year[url == urls], nrow(doc))
  doc <- cbind(doc, yearcol)
  
  df <- rbind(df,doc)
}

raw <- df

#start cleaning

#fix dates
df_work <- raw[c("Date", "Type", "Dead", "Injured", "Location", "Perpetrator", "monthyear", "yearcol")] %>%
  filter(str_detect(Perpetrator, "Islamic State") | str_detect(Perpetrator, "Boko Haram"))

df_work$Date <- dmy(paste(df_work$Date, df_work$monthyear))
df_work <- select(df_work, -c("monthyear"))

#fix formatting on death/injury counts
df_work$Dead <- as.numeric(stri_extract_first_regex(df_work$Dead, "[0-9]+"))
df_work$Dead[is.na(df_work$Dead)] <- 0
df_work$Injured <- as.numeric(stri_extract_first_regex(df_work$Injured, "[0-9]+"))
df_work$Injured[is.na(df_work$Injured)] <- 0

# calculation of general harm factor (# deaths + 1/2 # injuries)
df_work$HarmLevel <- df_work$Dead + (df_work$Injured/2)

#fix perp column
df_work$Perpetrator <- ifelse(str_detect(df_work$Perpetrator, "Islamic State"), "Islamic State", "Boko Haram")

# for google maps api 
#register_google("AIzaSyCOJEHgC1vT_27i2ZS1Bk0vLnihkvk42eA")

df_work$Location <- as.character(df_work$Location)
df_loc <- mutate_geocode(df_work,Location)

df_copy <- df_loc
#saveRDS(df_copy, "data/data-d5bigger.rds")
