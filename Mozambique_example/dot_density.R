library(maptools)
library(rgeos)
library(tidyverse)
library(rgdal)
library(ggthemes)
library(raster)
library(sp)
library(sf)

a2 <- readOGR("/Users/qianzh/project/Tiling/data/gadm36_2.shp") %>%
  spTransform(CRS("+proj=longlat +datum=WGS84"))
Moz_a2 <- a2[a2$NAME_0 == "Mozambique", ]
PfPR <- raster("/Users/qianzh/project/Tiling/data/global_Pf_Prevalence_all_ages_2000-2016/global_PfPR_all_ages_2016.tif")
population <- raster("/Users/qianzh/project/Tiling/data/population/worldpop_total_1y_2016_00_00.tif")
pf_count <- raster("/Users/qianzh/project/Tiling/data/global_Pf_Prevalence_all_ages_2000-2016/global_Pf_count_all_ages_2016.tif")

pfpr_df <-as.data.frame(PfPR, xy = TRUE)
pf_count_df <-as.data.frame(pf_count, xy = TRUE)
coordinates(pf_count_df) <- ~ x + y
Moz_a2 <- spTransform(Moz_a2, CRS("+proj=longlat +datum=WGS84 +no_defs +ellps=WGS84 +towgs84=0,0,0"))
proj4string(pf_count_df) <- proj4string(Moz_a2)
Moz_counts_index <- !is.na(sp::over(pf_count_df, as(Moz_a2, "SpatialPolygons")))



Moz_pf_counts <- pf_count_df[Moz_counts_index,]


Moz_pf_counts_df <- as.data.frame(Moz_pf_counts)

random_round <- function(x) {
  v=as.integer(x)
  r=x-v
  test=runif(length(r), 0.0, 1.0)
  add=rep(as.integer(0),length(r))
  add[r>test] <- as.integer(1)
  value=v+add
  ifelse(is.na(value) | value<0,0,value)
  return(value)
}

num_dots <- Moz_pf_counts_df %>% 
  select(global_Pf_count_all_ages_2016) %>%
  mutate_all(funs(. / 200)) %>% 
  mutate_all(random_round) %>%
  replace(is.na(.), 0)
Moz_pf_counts_df$num_dots = num_dots[,1]

Moz_pf_counts_df_plot <- Moz_pf_counts_df %>% filter(num_dots > 0)

coordinates(Moz_pf_counts_df_plot) <- ~ x + y
qpal <- colorBin(c("blue", "red"), Moz_pf_counts_df$num_dots, alpha = TRUE,
                 bins= c(1,2,4,6,8,10,20,30,40,50,100,400))






leaflet(Moz_pf_counts_df_plot) %>% addTiles() %>%
  addCircleMarkers(color = ~qpal(num_dots),
                   fillColor = ~qpal(num_dots), 
                   stroke = FALSE, fillOpacity = 1, radius = 2
  )%>%
  addLegend(values=~num_dots,pal=qpal,title="Pf Counts, 1 dot for 200") %>% 
  addPolygons(data=Moz_a2, weight = 2, fillOpacity = 0, color = "grey")


