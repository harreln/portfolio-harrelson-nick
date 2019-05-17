library("tidyverse")
library("graphclassmate")
library("dplyr")
library("ggplot2")
library("tidyverse")

df <- readRDS("data/wine-data-d1.rds") %>% 
  glimpse()

p <- ggplot(df, aes(y = price, x = quality, fill = quality)) +
  geom_boxplot() +
  coord_flip() +
  facet_wrap(vars(df$continent)) +
  scale_y_continuous(breaks = seq(0, 120, by = 10),limits = c(0,120)) +
  labs(y = "Bottle Price (USD)", x = "") +
  theme_graphclass() +
  theme(legend.position = "none") 

p

ggsave(filename = "boxplot-d1.png",
       path = "figures",
       width = 8,
       height = 4,
       units = "in",
       dpi = 300)
