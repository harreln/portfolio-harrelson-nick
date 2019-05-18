library("tidyverse")
library("graphclassmate")
library("RColorBrewer")

df <- readRDS("data/d2.rds") %>%  
  glimpse()

p <- ggplot(data = df, aes(x = percent, y = commodity, fill = drought)) +
  geom_point(size = 2, shape = 21) +
  facet_wrap(vars(drought),as.table = FALSE,ncol = 2) +
  theme_graphclass() +
  labs(y = NULL, x = "Percent of Market",
       title = "California's top agricultural commodities in different drought conditions", 
       caption = "Source: California Agricultural Statistics Review") +
  scale_fill_manual(name="Drought Intensity", values = (brewer.pal(n = 6, name = "Oranges")) ) +
  theme(legend.position = "none",
        panel.spacing.x=unit(1, "lines")) +
  scale_x_continuous(limits = c(0,0.2), expand = c(0, 0), labels=c('0','5','10','15','20'))
  

p 

ggsave(filename = "multiway-d2.png",
        path = "figures",
        width = 6,
        height = 10,
        units = "in",
        dpi = 300)

