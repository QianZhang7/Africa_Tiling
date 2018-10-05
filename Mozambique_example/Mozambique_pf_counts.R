require("rgdal") 
require("maptools")
require("ggplot2")
require("plyr")
require("raster")

# Reading the A2 units
s <- readOGR("/Users/qianzh/project/Tiling/data/gadm36_2.shp")
Mozambique_a2 <- s[s$NAME_0 == "Mozambique", ]
summary(Mozambique_a2)
plot(Mozambique_a2)
PfPR <- raster("/Users/qianzh/project/Tiling/data/global_Pf_Prevalence_all_ages_2000-2016/global_PfPR_all_ages_2016.tif")
plot(PfPR)

population <- raster("/Users/qianzh/project/Tiling/data/population/worldpop_total_1y_2016_00_00.tif")
pf_count <- raster("/Users/qianzh/project/Tiling/data/global_Pf_Prevalence_all_ages_2000-2016/global_Pf_count_all_ages_2016.tif")

#Raster to points
points_pfpr <- rasterToPoints(PfPR)
points_pf_counts <- rasterToPoints(pf_count)
points_pf_counts<- as.data.frame(points_pf_counts)

require(dplyr)
Moz_pf_counts <- points_pf_counts %>% filter(x >= 30.21741 & x <= 40.83931 & y >= -26.86869 & y <= -10.47125  )

require(sp)
pts <-data.frame(Moz_pf_counts[,1:2])
coordinates(pts) <- ~ x + y

# reproject the polygons and pts 
MozA2_wgs84 <- spTransform(Mozambique_a2, CRS("+proj=longlat +datum=WGS84 +no_defs +ellps=WGS84 +towgs84=0,0,0"))
proj4string(pts) <- proj4string(MozA2_wgs84)

# filter out the pts outside Mozambique
Moz_pts_index <- !is.na(over(pts, as(MozA2_wgs84, "SpatialPolygons")))

Moz_pf_counts_new <- Moz_pf_counts[Moz_pts_index,]
Moz_pts <- pts[Moz_pts_index]

qpal <- colorBin(c("Blue", "Red"), Moz_pts$counts, 
                 bins=c(0,50,100,150,200,300,400,500,1000, 2000, 5000,10000,20000, 30000, 40000, 50000, 65000))

leaflet(Moz_pts) %>% addTiles() %>%
  addCircleMarkers(color = 'white',
                   fillColor = ~qpal(counts), 
                   stroke = FALSE, radius = 5
  )%>%
  addLegend(values=~counts,pal=qpal,title="Pf Counts") %>% 
  addPolygons(data=MozA2_wgs84, weight = 2, fillOpacity = 0, color = "grey")
