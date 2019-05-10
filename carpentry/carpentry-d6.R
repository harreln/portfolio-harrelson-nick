#Nick Harrelson D6

composite <- read_csv("data-raw/composite-data.csv") %>% as.data.frame()

df <- setNames(composite, c("Material","TensileStrength", "TensileModulus", "Density", "SpecificStrength", "SpecificModulus","UltimateStrain","Manufacturer","Type"))

df <- df[ , -which(names(df) %in% c("Manufacturer"))] 

df$Type[df$Type=="Bulk polymers"] <- "Bulk polymer matrix materials"
df$Type[df$Type=="Other fibers"] <- "Glass fibers"
df$Type[df$Type=="PAN-Based Carbon Fibers"] <- "Carbon Fibers"
df$Type[df$Type=="Pitch-Based Carbon Fibers"] <- "Carbon Fibers"

df$Type <- as.factor(df$Type)


saveRDS(df, "data/d6.rds")
