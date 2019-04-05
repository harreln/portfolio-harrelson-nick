library("tidyverse")
library("graphclassmate")
library("RColorBrewer")

df <- readRDS("data/ca-commodities-d2.rds") %>%  
  glimpse()

p <- ggplot(data = df, aes(x = value, y = year,fill = drought)) +
  geom_point(size = 2, shape = 21) +
  facet_wrap(vars(commodity),as.table = FALSE, ncol = 4) +
  theme_graphclass() +
  labs(y = NULL, x = "Market value (USD billions)",title = "California's Top Agricultural Commodities") +
  scale_fill_manual(name="Drought Intensity", values = brewer.pal(n = 6, name = "Oranges"))

p 

ggsave(filename = "multiway-d2.png",
       path = "figures",
       width = 8,
       height = 10,
       units = "in",
       dpi = 300)

