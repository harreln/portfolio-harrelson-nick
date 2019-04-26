library(ggplot2)
library("graphclassmate")
library(magick)

df <- readRDS("data/data-d4.rds") %>%  
  glimpse()

p <- ggplot(df, aes(x = Age, y = Rate)) +
  geom_point() +
  facet_wrap(vars(Race), as.table = FALSE, nrow = 1) +
  labs(y = "", x = "Age Group", 
       title = "New incidences of oral cancer per 100,000 people\n", 
       caption = "Source: National Institute of Dental and Craniofacial Research, 2018") +
  theme_graphclass(line_color = rcb("mid_Gray"), 
                   font_size = 11) + 
  theme(axis.text.x = element_text(angle = 45, hjust = 1),
        axis.line = element_line(colour = rcb("pale_Gray")), 
        strip.text = element_text(color = rcb("dark_Gray"), face = "bold"), 
        plot.margin = unit(c(2, 4, 1, 0), "mm"), # top, right, bottom, and left margins
        panel.border = element_rect(color = rcb("pale_Gray"), fill = NA), 
        panel.spacing = unit(3, "mm"), 
        plot.background = element_rect(color = NA, fill = rcb("pale_Gray")), 
        panel.background = element_rect(color = NA, fill = rcb("pale_Gray")), 
        panel.grid.minor = element_blank(), 
        strip.background = element_rect(color = rcb("pale_Gray"), fill = rcb("pale_Gray"))) +
  aes(fill = Gender) +
  geom_point(size = 2.5, shape = 21, color = "black") +
  scale_fill_manual(values = c(rcb("pale_Gray"),"black"))


ggsave(plot = p, 
       filename = "d4-plot.png",
       path    = "figures",
       width   = 8,
       height  = 3,
       units   = "in",
       dpi     = "retina")

# read images
the_graph <- image_read("figures/d4-plot.png")
advert <- image_read("resources/man-cig.jpg")

#create grey image with colored headline
top <- image_crop(advert, "853x760")
middle <- image_crop(advert, "853x65+0+760")
bottom <- image_crop(advert, "853x355+0+825")

top <- image_quantize(top, max = 10, colorspace = "gray")
bottom <- image_quantize(bottom, max = 10, colorspace = "gray")

ad <- image_append(c(top, middle, bottom), stack = TRUE)
ad <- image_border(ad, rcb("pale_Gray"), "15x15")

# scale the heights to match 
ad    <- image_scale(ad, "x500")
the_graph <- image_scale(the_graph, "x500")

# append to the graph image 
final_img <- image_append(c(ad, the_graph), stack = FALSE)


# headline box same width as figure 
width  <- image_info(final_img)[["width"]]

# select a height (pixels) by trial and error
height <- 60

# create the box 
text_box <- image_blank(width = width, height = height, color = rcb("pale_Gray"))

# add the headline text to the box 
text_box <- image_annotate(text_box, 
                           text     = "But a Healthy Mouth tastes Best.", 
                           gravity  = "west", 
                           location = "+10+0", 
                           size     = 40, 
                           color    = "#B8334B", 
                           font     = "Georgia")

# create the box 
sub_box <- image_blank(width = width, height = height, color = rcb("pale_Gray"))

# add the headline text to the box 
sub_box <- image_annotate(sub_box, 
                           text     = "Despite only smoking approximately 20% more (Nat. Inst. on Drug Abuse), men develop oral cancer at twice the rate of women. Avoiding tobacco\n products and living a healthy lifestlye is the only method of prevention.", 
                           gravity  = "west", 
                           location = "+10+0", 
                           size     = 25, 
                           color    = "#B8334B", 
                           font     = "Georgia")


# join the headline to the image 
final_img <- image_append(c(text_box, sub_box, final_img), stack = TRUE)

# and write to file
image_write(final_img, 
            path = "figures/d4.png", 
            format = "png")
