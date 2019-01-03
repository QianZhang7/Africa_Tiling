library(sp)
library(rgdal)
library(rgeos)
library(raster)
# read mcdi 100m shapefile
mcdi100_shp <- readOGR("/Users/qianzh/project/Tiling/data/population/mcdi_100m/sectors_inhabited.shp")
proj4string(mcdi100_shp) <- CRS("+proj=utm +zone=32 +north +ellps=WGS84 +datum=WGS84 +units=m +no_defs +towgs84:0,0,0")
mcdi100_shp <- spTransform(mcdi100_shp, CRS("+proj=longlat +datum=WGS84"))

# read worldpop 100m raster
world_100_2010 <- raster("/Users/qianzh/project/Tiling/data/population/Equatorial_Guinea_100m_Population/GNQ10v2.tif")
world_100_2015 <- raster("/Users/qianzh/project/Tiling/data/population/Equatorial_Guinea_100m_Population/GNQ15v2.tif")
world_100_2010 <- crop(world_100_2010, extent(mcdi100_shp))
world_100_2015 <- crop(world_100_2015, extent(mcdi100_shp))

# read mcdi 1km
mcdi1k_shp <- readOGR("project/Tiling/data/population/mcdi_1km/pop4Qian2.shp")
mcdi1k_shp <- spTransform(mcdi1k_shp, CRS("+proj=longlat +datum=WGS84"))
#proj4string(mcdi1k_shp) <- CRS("+proj=utm +zone=32 +north +ellps=WGS84 +datum=WGS84 +units=m +no_defs +towgs84:0,0,0")


#read worldpop 1km raster
world_1k_2010 <- raster("project/Tiling/data/population/worldpop2010/AFR_PPP_2010_adj_v2.tif")
world_1k_2010 <- crop(world_1k_2010, extent(mcdi1k_shp))
world_1k_2015 <- raster("project/Tiling/data/population/worldpop2015/AFR_PPP_2015_adj_v2.tif")
world_1k_2015 <- crop(world_1k_2015, extent(mcdi1k_shp))

# read landscan 1km
landscan <- raster("project/Tiling/data/popgrid/LandScan Global 2017/lspop2017/dblbnd.adf")
landscan <- crop(landscan, extent(mcdi1k_shp))

save.image("project/Tiling/data/population/population_rasters.RData")
