library(lubridate)
library(ggplot2)
library(dplyr)
library(data.table)
library(ggrepel)
library(tidyverse)
library("ggmap")

attacks <- readRDS("data/data-d5bigger.rds") %>%  
  filter(Perpetrator == "Islamic State") %>%
  glimpse()

#Set your API Key
#ggmap::register_google(key = "AIzaSyCOJEHgC1vT_27i2ZS1Bk0vLnihkvk42eA")

p <- ggmap(get_googlemap(center = c(lon = 41, lat = 34),
                         zoom = 6, scale = 2,
                         maptype ='roadmap',
                         color = 'bw'))


p + geom_point(aes(x = lon, y = lat,  size = HarmLevel), data = attacks, alpha = 0.4, color = "#003f5c") + 
  scale_size_continuous(range=c(1,20)) +
  theme_void() +
  theme(legend.position="none") +
  facet_wrap(~yearcol)








map <- map_data("world") #%>% filter(region %in% c("Syria","Iraq"))

p <- ggplot() +
  geom_polygon(data = map, aes(x=long, y=lat, group = group), colour = "black", fill = "grey", alpha = 0.1) +
  #geom_polygon(data = map, aes(x=long, y = lat), fill="grey", alpha=0.3) +
  geom_point( data=df, aes(x=lon, y=lat, size = HarmLevel), alpha = 0.7) +
  scale_size_continuous(range=c(1,12)) +
  theme_void() + 
  coord_map() + 
  #ylim(15,50) + 
  #xlim(-30,105) + 
  facet_wrap(~yearcol) +
  labs(title="Attacks claimed by the Islamic State in January-April") +
  #coord_cartesian(xlim = c(-30, 105), ylim = c(10, 45))
  coord_cartesian()
#try GGmap
#richards book r for journalism on maps
p

#ggsave(filename = "d5.png",
#       path = "figures",
#       width = 8,
#       height = 7,
#       units = "in",
#       dpi = 300)
