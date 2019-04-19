library(ggplot2)
library("graphclassmate")

df <- readRDS("data/data-d3.rds") %>%  
  glimpse()

p <- ggplot(data = df, aes(x = GDP, y = HappinessScore, size = Population)) +
  geom_jitter(alpha = 0.75) + 
  facet_wrap(vars(Region),as.table = FALSE, ncol = 3)+ 
  scale_x_continuous(trans='log10') + 
  theme_graphclass() +
  labs(y = "Happiness Index", x = "GDP (log10 billions of USD)",title = "Does money buy happiness? Countries from 2015-2017")  +
  labs(size='Populations (Millions)') 

p

ggsave(filename = "scatter-d3.png",
       path = "figures",
       width = 8,
       height = 7,
       units = "in",
       dpi = 300)

