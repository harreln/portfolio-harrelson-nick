library("tidyverse")
library("graphclassmate")
library("dplyr")
library("ggplot2")
library("tidyverse")
library(RColorBrewer)

df <- readRDS("data/wine-data-d1.rds") %>% 
  glimpse()

p <- ggplot(df, aes(y = price, x = quality, fill = quality)) +
  geom_boxplot(outlier.shape = NA) +
  geom_hline(aes(yintercept=15), linetype = "dashed") +
  coord_flip() +
  facet_wrap(vars(df$continent), as.table = FALSE, ncol = 1) +
  scale_y_continuous(breaks = seq(0, 120, by = 10),limits = c(0,120)) +
  labs(y = "Bottle Price (USD)", 
       x = "",
       caption = "Source: Wine Entusiast Magazine, 2018") +
  theme_graphclass() +
  theme(legend.position = "none") +
  scale_fill_manual(values=brewer.pal(3, "RdPu")) +
  scale_color_manual(values=brewer.pal(3, "Purples"))

p

ggsave(filename = "boxplot-d1.png",
       path = "figures",
       width = 8,
       height = 6,
       units = "in",
       dpi = 300)
