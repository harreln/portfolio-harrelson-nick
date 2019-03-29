library("tidyverse")
library("graphclassmate")
library("dplyr")
library("ggplot2")
library("tidyverse")

df <- readRDS("data/wine-data-d1.rds") %>% 
  glimpse()

outlier_only <- df %>%
  group_by(continent, quality) %>%
  mutate(outlier = price > summary(price)[5] + 1.50*(summary(price)[5]-summary(price)[2])) %>%
  ungroup() %>% 
  filter(outlier == TRUE)

p <- ggplot(df, aes(x = continent, y = price, fill = quality)) +
  geom_boxplot(width = 0.5, alpha = 0.75, outlier.shape = NA) +
  coord_flip() +
  scale_y_continuous(breaks = seq(0, 120, by = 10),limits = c(0,120)) +
  labs(y = "Bottle Price (USD)", x = "") +
  theme_graphclass() +
  scale_fill_manual(values = c(rcb("light_Gn"), rcb("light_PR")), labels = c("Bad Wine", "Good Wine")) +
  aes(color = quality) +
  scale_color_manual(values = c(rcb("dark_Gn"), rcb("dark_PR"))) +
  guides(fill  = guide_legend(title = NULL), color = "none") +
  theme(legend.position="top")

p

ggsave(filename = "boxplot-d1.png",
       path = "figures",
       width = 8,
       height = 4,
       units = "in",
       dpi = 300)
