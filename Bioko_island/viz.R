library(tidyverse)
library(sp)
library(rgdal)
library(rgeos)

# read the pf+ data for 2015-2017
pf15 <- read_csv('project/Tiling/data/Bioko/mis15sec.csv')
pf16 <- read_csv('project/Tiling/data/Bioko/mis16sec.csv')
pf17 <- read_csv('project/Tiling/data/Bioko/mis17sec.csv')

# read the shapefile for Bioko

shp <- readOGR("/Users/qianzh/project/Tiling/data/Bioko/sectors_inhabited.shp")
summary(shp)
proj4string(shp) <- CRS("+proj=utm +zone=32 +north +ellps=WGS84 +datum=WGS84 +units=m +no_defs +towgs84:0,0,0")

shp_wgs <- spTransform(shp, CRS("+proj=longlat +datum=WGS84"))
population <- read_csv('project/Tiling/data/Bioko/popsec.csv')

leaflet(shp_wgs) %>% addTiles() %>%
  addPolygons(weight = 2, fillOpacity = 0, color = "grey", opacity = 0.5)

shp_pop <- merge(shp_wgs, population[,2:3], by.x = "MAPAID", by.y = "secId")

shp_15 <- merge(shp_pop, pf15[,2:4], by.x = "MAPAID", by.y = "secId")
shp_16 <- merge(shp_pop, pf16[,2:4], by.x = "MAPAID", by.y = "secId")
shp_17 <- merge(shp_pop, pf17[,2:4], by.x = "MAPAID", by.y = "secId")

nums <- length(shp_15)

points <- data.frame("x" = NA, "y" = NA, "group" = NA)
for (i in 1:nums){
  sample_pop <- data.frame(spsample(SpatialPolygons(shp_15@polygons[i]), n = max(shp_15$pop[i],shp_15$n[i], na.rm = TRUE), "random"))
  sample_pop$group <- rep("Individuals",max(shp_15$pop[i],shp_15$n[i], na.rm = TRUE))
  if(shp_15$n[i] > 0 & (!is.na(shp_15$n[i]))){
    sample_pop$group[1:shp_15$n[i]] <- rep("Negative",shp_15$n[i])
    }
  if(shp_15$pf[i] > 0 &(!is.na(shp_15$pf[i]))){
    sample_pop$group[1:shp_15$pf[i]] <- rep("Positive",shp_15$pf[i])
  }
  df <- data.frame(sample_pop)
  points <- rbind(points,setNames(df, names(points)))
}
  
points <- points[-1,]


