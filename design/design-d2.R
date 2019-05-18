library("tidyverse")
library("graphclassmate")
library("RColorBrewer")

df <- readRDS("data/d2.rds") %>%  
  glimpse()

p <- ggplot(data = df, aes(x = percent, y = commodity, fill = drought)) +
  geom_point(size = 2, shape = 21) +
  facet_wrap(vars(drought),as.table = FALSE) +
  theme_graphclass() +
  labs(y = NULL, x = "Percent of Market",
       title = "California's top agricultural commodities in different drought conditions", 
       caption = "Source: California Agricultural Statistics Review") +
  scale_fill_manual(name="Drought Intensity", values = rev(brewer.pal(n = 6, name = "Oranges")) ) +
  theme(legend.position = "none")

p 

ggsave(filename = "multiway-d2.png",
        path = "figures",
        width = ,
        height = 7,
        units = "in",
        dpi = 300)

