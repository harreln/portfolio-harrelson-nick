#Nick Harrelson D6

composite <- read_csv("data-raw/composite-data.csv") %>% as.data.frame()

df <- setNames(composite, c("Material","Tensile Strength\n[MPa]", "Tensile Modulus\n[GPa]", "Density\n[g/cc]", "Specific Strength\n[MPa/(g/cc)]", "Specific Modulus\n[GPa/(g/cc)]","Ultimate Strain","Manufacturer","Type"))

df <- df[ , -which(names(df) %in% c("Manufacturer"))] 

df$Type[df$Type=="Bulk polymer matrix materials"] <- "Bulk polymers"
df$Type[df$Type=="Glass fibers"] <- "Fibers"
df$Type[df$Type=="Other fibers"] <- "Fibers"
df$Type[df$Type=="PAN-Based Carbon Fibers"] <- "Fibers"
df$Type[df$Type=="Pitch-Based Carbon Fibers"] <- "Fibers"
df$Type[df$Type=="Polymetric Fibers"] <- "Fibers"

df$Type <- as.factor(df$Type)

saveRDS(df, "data/d6.rds")
