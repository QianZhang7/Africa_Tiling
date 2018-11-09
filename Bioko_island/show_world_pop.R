world_pop <- raster("project/human_mobility/data/covariates/population/worldpop_total_1y_2016_00_00.tif")
bioko_world_pop <- raster::extract(world_pop, shp_15, fun = sum)
shp_15$world_pop <- round(unlist(bioko_world_pop)[,1],0)

labels_mcdi <- sprintf(
  "MCDI_population: %s,\n  World POP: %s",
  shp_15$pop, shp_15$world_pop) %>% lapply(htmltools::HTML)

leaflet(shp_15) %>% addTiles() %>%
  addPolygons(data = shp_15,weight = 2, color = "red", fillColor = "red",label = labels_mcdi)

plot(x = shp_15$pop, y = shp_15$world_pop, main = "World pop VS MCDI pop", xlab = "MCDI pop", ylab = "World pop")

