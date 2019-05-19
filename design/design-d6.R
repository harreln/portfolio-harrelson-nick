library("scagnostics")
library(ggplot2)
library(GGally)


df <- readRDS("data/d6.rds")

mytitle <- "Comparing Material Properties of Composite Material Components"

ggscatmat(na.omit(df), columns = 2:7, color = "Type") +
  geom_point(size = 1, alpha = 0.1, na.rm = TRUE, shape = 21) + 
  theme(legend.position = "right",
        panel.spacing = unit(1, "mm"),  
        axis.text.x = element_text(angle = 90, hjust = 1)) +
  scale_color_manual(values = brewer.pal(name = "Dark2", n = 3)) +
  labs(title = mytitle,
       caption = "Source: Principles of Composite Material Mechanics, Ronald F. Gibson",
       color = "Material Type") 




ggsave(filename = "d6.png",
       path = "figures",
       width = 8,
       height = 8,
       units = "in",
       dpi = 300)
