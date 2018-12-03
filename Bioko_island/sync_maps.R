world_pop_2010 <- raster("~/Documents/Equatorial Guinea 100m Population/GNQ15v2.tif")
bioko_world_pop_2010 <- raster::extract(world_pop_2010, shp_15, fun = sum)
shp_15$bioko_world_pop_2010 <- round(unlist(bioko_world_pop_2010)[,1],0)

pal_population <- colorBin(c("Blue", "red"), domain = shp_15$pop , bins = c(1,10, 20, 50,100,200,500,700))


map1 <- leaflet(shp_15) %>% addTiles() %>%
  addPolygons(data = shp_15,weight = 2, color = ~pal_population(bioko_world_pop_2010), fillColor = ~pal_population(bioko_world_pop_2010))%>%
  addLegend(values=~bioko_world_pop_2010,pal=pal_population,title="World Population") 

map2 <-leaflet(shp_15) %>% addTiles() %>%
  addPolygons(data = shp_15,weight = 2, color = ~pal_population(pop), fillColor = ~pal_population(pop))%>%
  addLegend(values=~pop,pal=pal_population,title="MCDI Population") 


library(mapview)
sync(map1, map2)
