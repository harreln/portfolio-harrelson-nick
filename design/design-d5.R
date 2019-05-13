library(lubridate)
library(ggplot2)
library(dplyr)
library(data.table)
library(ggrepel)
library(tidyverse)
library(magick)
library("ggmap")
library(graphclassmate)

attacks <- readRDS("data/data-d5bigger.rds") %>%  
  filter(Perpetrator == "Islamic State") %>%
  glimpse()

attacks_world <- readRDS("data/data-d5bigger.rds") %>%
  glimpse()

levels(attacks$yearcol) <- c("2017", "2018", "2019 (up to May 1)")
levels(attacks_world$yearcol) <- c("2017", "2018", "2019 (up to May 1)")


#Set your API Key
#ggmap::register_google(key = "AIzaSyCOJEHgC1vT_27i2ZS1Bk0vLnihkvk42eA")

# First Plot, middle east only
p <- ggmap(get_googlemap(center = c(lon = 41, lat = 34),
                         zoom = 6, scale = 2,
                         maptype ='roadmap',
                         color = 'bw'))


p + geom_point(aes(x = lon, y = lat,  size = HarmLevel), data = attacks, alpha = 0.4, color = "#003f5c") + 
  scale_size_continuous(range=c(1,20)) +
  theme_void() +
  theme(legend.position="none") +
  facet_wrap(vars(yearcol)) +
  labs(title = "Attacks claimed by the Islamic State, 2017-2019",
       subtitle = "Point size is proportional to the number of deaths and injuries in each attack\n",
       caption = "Source: Wikipedia, List of terrorist incidents") 

ggsave(filename = "d5-middle_east.png",
       path = "figures",
       width = 8,
       height = 4,
       units = "in",
       dpi = 300)

# Second Plot, Entire globe
p_world <- ggmap(get_googlemap(center = c(lon = 60, lat = 34),
                         zoom = 2, scale = 2, 
                         maptype ='roadmap',
                         color = 'bw')) +
  scale_y_continuous(limits=c(-42, 60)) +
  scale_x_continuous(limits=c(-15,150))


p_world_add <- p_world + geom_point(aes(x = lon, y = lat,  size = HarmLevel, color = Perpetrator), data = attacks_world, alpha = 0.5) + 
  scale_size_continuous(range=c(1,8)) +
  theme_void() +
  facet_wrap(vars(yearcol)) +
  guides(size = "none", color = "none") +
  scale_color_manual(values=c(rcb("dark_Br"),rcb("dark_Gn"))) +
  labs(title = "Attacks claimed by the Islamic State and Boko Haram, 2017-2019",
       subtitle = "Point size is proportional to the number of deaths and injuries in each attack.\nISIS in green, Boko Haram in brown.\n",
       caption = "Source: Wikipedia, List of terrorist incidents")
  

ggsave(filename = "d5-world.png",
       path = "figures",
       width = 8,
       height = 4,
       units = "in",
       dpi = 300)

# Compute data for bar charts

bar_data <- aggregate(cbind(attacks_world$Injured, attacks_world$Dead), by=list(Category=attacks_world$yearcol), FUN=sum)
names(bar_data) <- c("Year","Injured","Dead")

library(reshape)
bar_data <- melt(bar_data, id=c("Year")) %>% as_tibble()

#Individual plots 
#2017
b2017 <- ggplot(data=bar_data[c(1,4),1:3], aes(x=variable, y=value)) +
  geom_bar(stat="identity") +
  xlab("") + ylab("") + ylim(0,6500) + theme_minimal() +
  scale_fill_manual(values=c("#cecece"))

ggsave(filename = "d5-2017.png",
       path = "figures",
       width = 8/3,
       height = 1.8,
       units = "in",
       dpi = 300)

#2018
b2018 <- ggplot(data=bar_data[c(2,5),1:3], aes(x=variable, y=value)) +
  geom_bar(stat="identity") +
  xlab("") + ylab("") + ylim(0,6500) + theme_minimal()
ggsave(filename = "d5-2018.png",
       path = "figures",
       width = 8/3,
       height = 1.8,
       units = "in",
       dpi = 300)

#2019
append2019 <- bar_data[c(3,6),1:3]
append2019 <-  do.call(rbind, list(Total = append2019, Projected = append2019))
append2019 <- add_column(append2019, type = c("Total as of May 1","Total as of May 1","2019 Total Projection","2019 Total Projection"))
append2019[3,3] = append2019[3,3]*2 #multiply x2 not x3 so that the stacking adds up correctly
append2019[4,3] = append2019[4,3]*2

b2019 <- ggplot(data = append2019, aes(x = variable, y = value, fill = type)) + 
  geom_bar(stat="identity") + 
  xlab("") + ylab("") +
  guides(fill="none") +
  ylim(0,6500) +
  theme_minimal() +
  scale_fill_manual(values=c("#848484", "#cecece")) + 
  geom_text(aes(x = variable, y = value-200, label = type), size = 2)

ggsave(filename = "d5-2019.png",
       path = "figures",
       width = 8/3,
       height = 1.8,
       units = "in",
       dpi = 300)

#Image Magick everything together

world <- image_read("figures/d5-world.png")
first <- image_read("figures/d5-2017.png")
second <- image_read("figures/d5-2018.png")
third <- image_read("figures/d5-2019.png")

source_note <- image_crop(world, "2400x180+0+1020")
world_crop <- image_crop(world, "2400x1020")

bottom <- image_append(c(first, second, third), stack = FALSE)
final <- image_append(c(world_crop, bottom, source_note), stack = TRUE)
final <- image_border(final, "#ffffff", "15x15")

image_write(final, 
            path = "figures/d5.png", 
            format = "png")

