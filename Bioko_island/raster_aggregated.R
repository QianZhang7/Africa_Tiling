load("project/Tiling/data/population/population_rasters.RData")

world_100_value <- values(world_100_2010)
#world_pop_bioko <- world_pop_bioko[!is.na(world_pop_bioko)]
world_100_value[is.na(world_100_value)] <- 0

world_1k_value <- values(world_1k_2010)
#world_pop_bioko <- world_pop_bioko[!is.na(world_pop_bioko)]
world_1k_value[is.na(world_1k_value)] <- 0

landscan_pop <- values(landscan)
#landscan_pop <- landscan_pop[!is.na(landscan_pop)]
landscan_pop[is.na(landscan_pop)] <- 0

world_200_2010 <- aggregate(world_100_2010,fact=2,fun=sum)
world_500_2010 <- aggregate(world_100_2010,fact=5,fun=sum)

library(rgeos)
mcdi1k_centers <- SpatialPointsDataFrame(gCentroid(mcdi1k_shp, byid=TRUE),data.frame(as.numeric(as.character(mcdi1k_shp$pop))), match.ID=FALSE)
r_1k_grid <- raster(ncols=57, nrows=63)
extent(r_1k_grid) <- extent(mcdi1k_shp)
raster_mcdi_1k <- rasterize(mcdi1k_centers, r_1k_grid, field = "as.numeric.as.character.mcdi1k_shp.pop..")

mcdi100_centers <- SpatialPointsDataFrame(gCentroid(mcdi100_shp, byid=TRUE),data.frame(mcdi100_shp$PEOPLE_N), match.ID=FALSE)
r_100_grid <- raster(ncols=568, nrows=626)
extent(r_100_grid) <- extent(mcdi100_shp)
raster_mcdi_100 <- rasterize(mcdi100_centers, r_100_grid, field = "mcdi100_shp.PEOPLE_N")

mcdi_200_2010 <- aggregate(raster_mcdi_100,fact=2,fun=sum)
mcdi_500_2010 <- aggregate(raster_mcdi_100,fact=5,fun=sum)
mcdi_2k_2010 <- aggregate(raster_mcdi_1k,fact=2,fun=sum)
mcdi_5k_2010 <- aggregate(raster_mcdi_1k,fact=5,fun=sum)
world_2k_2010 <- aggregate(world_1k_2010,fact=2,fun=sum)
world_5k_2010 <- aggregate(world_1k_2010,fact=5,fun=sum)
