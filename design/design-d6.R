library("scagnostics")

df <- readRDS("data/d6.rds")

mytitle <- "Comparing Material Properties of Composites (values normalized)"

ggparcoord(data = df, 
           columns = 2:7, 
           groupColumn  = "Type",
           scale = "center", 
           order = "Skewed", 
           mapping = ggplot2::aes(size = 1, alpha = 0.4),
           title = mytitle) +
  ggplot2::scale_size_identity() +
  labs(x = "", y = "")
  
ggsave(filename = "d6.png",
       path = "figures",
       width = 7,
       height = 4,
       units = "in",
       dpi = 300)
