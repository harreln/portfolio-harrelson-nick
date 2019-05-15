library(ggplot2)
library("graphclassmate")
library(magick)
library(grid)

df_orig <- readRDS("data/data-d4.rds") %>%  
  glimpse()

df_fix <- filter(df_orig, Sex == "FemaleFixed")
df <- filter(df_orig, Sex != "FemaleFixed")

p <- ggplot() +
  geom_line(data = df_fix, aes(x=Age, y=Rate, group=1), color = rcb("dark_Gray")) +
  geom_point(data = df_fix, 
             mapping = aes(x = Age, y = Rate), 
             size = 3, 
             color = "#F9F9F9") +
  geom_point(data = df_fix, 
             mapping = aes(x = Age, y = Rate), 
             size = 1, 
             color = rcb("dark_Gray"),
             shape = 3) +
  geom_point(data = df, aes(x=Age, y=Rate, fill=Sex), size = 2.5, shape = 21, color = "black") +
  facet_wrap(vars(Race), as.table = FALSE, nrow=1) +
  scale_fill_manual(values = c(rcb("pale_Gray"),"black"))

p <- p + 
  theme_graphclass(line_color = rcb("mid_Gray"), font_size = 11) + 
  theme(axis.line = element_line(color = "#F9F9F9"), 
        strip.text = element_text(color = rcb("dark_Gray"), face = "bold"), 
        plot.margin = unit(c(2, 4, 1, 0), "mm"), # top, right, bottom, and left margins
        panel.border = element_rect(color = "#F9F9F9", fill = NA), 
        panel.spacing = unit(3, "mm"), 
        plot.background = element_rect(color = NA, fill = "#F9F9F9"), 
        panel.background = element_rect(color = NA, fill = "#F9F9F9"), 
        panel.grid.minor = element_blank(), 
        strip.background = element_rect(color = "#F9F9F9", fill = "#F9F9F9"),
        legend.position = "none") +
  labs(y = "", x = "Upper Limit of Age Group", 
       title = "New incidences of oral cancer per 100,000 people\n", 
       caption = "Source: National Institute of Dental and Craniofacial Research, 2018")

ggsave(plot = p, 
       filename = "d4-plot.png",
       path    = "figures",
       width   = 8,
       height  = 4,
       units   = "in",
       dpi     = "retina")

# read graph and annotate sex 
the_graph <- image_read("figures/d4-plot.png") %>%
  image_annotate("Male", size = 40, color = rcb("dark_Gray"), boxcolor = "#F9F9F9", location = "+685+510") %>%
  image_annotate("Female", size = 40, color = rcb("dark_Gray"), boxcolor = "#F9F9F9", location = "+685+750") %>%
  image_annotate("Female, adjusted\nfor smoking rates", size = 40, color = rcb("dark_Gray"), boxcolor = "#F9F9F9", location = "+685+635")


# read images
photo <- image_read("resources/throat-cancer.jpg") %>%
 # image_quantize(max = 10, colorspace = "gray") %>%
  image_border("#F9F9F9", "15x15") %>%
  image_crop("800x766+180+0")


# scale the heights to match 
photo <- image_scale(photo, "x500")
the_graph <- image_scale(the_graph, "x500")

# append to the graph image 
#final_img <- image_append(c(ad, the_graph), stack = FALSE)
#MOVE

# headline box same width as figure 
width  <- image_info(the_graph)[["width"]]

# select a height (pixels) by trial and error
height <- 120

# create the box 
text_box <- image_blank(width = width, height = height, color = "#F9F9F9")

# join the headline to the image 
final_img <- image_append(c(text_box, the_graph), stack = TRUE)

final_img <- image_scale(final_img, "x500")

final_img <- image_append(c(final_img, photo), stack = FALSE) %>%
  image_annotate(text     = "Despite only smoking approimately 20% more (Nat. Inst. on Drug Abuse), men develop oral\ncancer at twice the rate of women. Avoiding tobacco products and living a healthy lifestyle is\nthe only method of prevention", 
                 gravity  = "west", 
                 location = "+10-200", 
                 size     = 25, 
                 color    = "#872121", 
                 font     = "Georgia")


# and write to file
image_write(final_img, 
            path = "figures/d4.png", 
            format = "png")
