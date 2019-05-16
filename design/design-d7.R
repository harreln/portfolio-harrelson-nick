library(ggplot2)
library(dplyr)
library(rworldmap)
library(micromap)

world <- getMap(resolution = "low")

data <- as.data.frame(readRDS("data/data-d7.rds"))

worldPolys <- create_map_table(world, IDcolumn="NAME")
head(worldPolys)

p <- mmplot(stat.data = data,
       map.data = worldPolys,
       panel.types = c('labels','dot','dot','map'),
       panel.data = list('Country','Happiness','GDP',NA),
       ord.by = 'Happiness', rev.ord = T,
       grouping = 10, median.row = F,
       map.link = c('Country','ID'),
       print.file="figures/d7.png",print.res=300,
       panel.att=list(list(1, header="Country",
                     panel.width=1.6,
                     align="left", text.size=.9),
                list(2, header="Happiness\nIndex",
                       graph.bgcolor="lightgray", point.size=1.5,
                       xaxis.title="Score (0-10)", panel.width = 2),
                list(3, header="Gross Domestic\nProduct",
                       graph.bgcolor="lightgray", point.size=1.5,
                    #   xaxis.ticks=list(20,30,40), xaxis.labels=list(20,30,40),
                       xaxis.title="log(Billions USD)", panel.width = 2),
                list(4, header="Light Gray Means\nHighlighted Above",
                       inactive.fill="lightgray",
                       inactive.border.color=gray(.7), inactive.border.size=0.2,
                       panel.width=4)),
       plot.height = 22, plot.width = 10)
