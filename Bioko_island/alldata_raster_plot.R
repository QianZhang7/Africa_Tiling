library(sp)
library(rgdal)
library(raster)
library(RColorBrewer)


# load the data image
load("project/Tiling/data/population/population_rasters.RData")

# convert shapefile to raster # mcdi
r_100 <- raster(ncol=568, nrow=626)
extent(r_100) <- extent(world_100_2010)
r_mcdi100 <- rasterize(mcdi100_shp, r_100, field = 'PEOPLE_N', update=TRUE, updateValue="NA")

r_1k <- raster(ncol=57, nrow=63)
extent(r_1k) <- extent(world_1k_2010)
r_mcdi1k <- rasterize(mcdi1k_shp, r_1k, field = 'pop', update=TRUE, updateValue="NA")

r_mcdi100[is.na(r_mcdi100[])] <- -9999

# viz the rasters
cuts=c(0,1,10,100,1000,10000,100000)
world.shp <- readOGR("project/Tiling/data/population/TM_WORLD_BORDERS-0.3/TM_WORLD_BORDERS-0.3.shp")

# viz the 100m rasters
par(mfrow = c(1,2))

plot(world.shp, col = "gray80")
plot(r_mcdi100, main = "MCDI(100m) for Bioko", breaks= cuts, col=c("grey", brewer.pal(n = 6, name = "YlOrRd")), legend = F, add = T)
legend(x = "bottomright",inset = 0,
       legend = c("0","1","10","100","1000","10000","100000"), 
       col=c("grey", brewer.pal(n = 7, name = "YlOrRd")), lwd=5, cex=.5, horiz = F)

