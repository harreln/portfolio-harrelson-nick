library(ggplot2)
library("graphclassmate")
library(dplyr)

Sys.time()

df <- readRDS("data/data-d3.rds") %>%  
  glimpse()

df_all <- df[c('x','y')]

p <- ggplot() +
  geom_point(data = df_all, aes(x=x, y=y), shape = 21, fill = "#9fbfdf", colour = "#9fbfdf") +
  geom_point(data = df, aes(x = x, y = y), shape = 21, fill = "#336699", alpha = 0.5) + 
  facet_wrap(vars(material),as.table = FALSE)+ 
  theme_graphclass() +
  labs(y = "", x = "",title = "Goodman Diagrams") +
  scale_x_continuous(limits = c(0,1), expand = c(0, 0), labels=c('0','0.25','0.5','0.75','1')) +
  scale_y_continuous(limits = c(0,1), expand = c(0, 0), labels=c('0','0.25','0.5','0.75','1')) +
  geom_abline(intercept = 1, slope = -1) +
  xlab("Mean Stress / Ultimate Tensile Strength") + 
  ylab("Alternating Stress / Fatigue Stress") +
  theme(panel.spacing.x=unit(1, "lines"),
        panel.grid.major = element_blank(), 
        panel.grid.minor = element_blank(),
        panel.background = element_blank(), 
        axis.line = element_line(colour = "black")) +
  coord_fixed()


p

ggsave(filename = "scatter-d3.png",
       path = "figures",
       width = 8,
       height = 7,
       units = "in",
       dpi = 300)

Sys.time()
