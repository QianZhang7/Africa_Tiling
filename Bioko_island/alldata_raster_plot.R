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

# viz the 100m rasters
par(mfrow = c(1,2))
cuts=c(0,1,10,100,1000)
png("project/Tiling/data/popgrid/dec2018/mcdi_100_raster.png", height = 800, width = 1200)
plot(r_mcdi100, xlim = c(8.4, 9), ylim = c(3.2,3.8), 
     main = "MCDI(100m) for Bioko", breaks= cuts, 
     col=c("grey", brewer.pal(n = 4, name = "YlOrRd")), legend = F)
plot(world_100_2010, col=c("gray50"), legend = F, add = T)
plot(r_mcdi100, xlim = c(8.4, 9), ylim = c(3.2,3.8), 
     main = "MCDI(100m) for Bioko", breaks= cuts, 
     col=c("grey", brewer.pal(n = 4, name = "YlOrRd")), legend = F, add = T)
legend(x = "bottomright",inset = 0, y = 3.4,
       legend = c("0","1","10","100","1000","10000","100000"),
       col=c("gray50", brewer.pal(n = 4, name = "YlOrRd")), lwd=5, cex=.5, horiz = F)

plot(world_100_2010, xlim = c(8.4, 9), ylim = c(3,4), main = "WorldPOP_2010(100m) for Bioko", breaks= cuts, col=c("gray50", brewer.pal(n = 4, name = "YlOrRd")), legend = F)
legend(x = "bottomright",inset = 0,
       legend = c("0","1","10","100","1000"), 
       col=c("gray50", brewer.pal(n = 4, name = "YlOrRd")), lwd=5, cex=.5, horiz = F)
dev.off()
