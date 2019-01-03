load("project/Tiling/data/population/population_rasters.RData")

cuts=c(0,1,10,100,1000,10000,100000)
# convert shapefile to raster # mcdi
r_100 <- raster(ncol=568, nrow=626)
extent(r_100) <- extent(world_100_2010)
r_mcdi100 <- rasterize(mcdi100_shp, r_100, field = 'PEOPLE_N', update=TRUE, updateValue="NA")

r_1k <- raster(ncol=57, nrow=63)
extent(r_1k) <- extent(world_1k_2010)
r_mcdi1k <- rasterize(mcdi1k_shp, r_1k, field = 'pop', update=TRUE, updateValue="NA")

png("project/Tiling/data/popgrid/dec2018/mcdi_worldpop_100_raster.png", height = 800, width = 1200)
par(mfrow = c(2,2))
plot(world_pop_2010, xlim = c(8.4, 9), ylim = c(3,4), main = "WorldPOP(100m) for Bioko", breaks= cuts, col=c("gray50", brewer.pal(n = 6, name = "YlOrRd")), legend = F)
legend(x = 9,inset = 0, y = 3.4,
       legend = c("0","1","10","100","1000"), 
       col=c("gray50", brewer.pal(n = 6, name = "YlOrRd")), lwd=10, cex=1, horiz = F)
plot(r_mcdi100, xlim = c(8.4, 9), ylim = c(3,4), 
     main = "MCDI(100m) for Bioko", breaks= cuts, 
     col=c("gray50", brewer.pal(n = 4, name = "YlOrRd")), legend = F)
plot(world_100_2010, col=c("gray50"), legend = F, add = T)
plot(r_mcdi100, xlim = c(8.4, 9), ylim = c(3,4), 
     main = "MCDI(100m) for Bioko", breaks= cuts, 
     col=c("gray50", brewer.pal(n = 4, name = "YlOrRd")), legend = F, add = T)
legend(x = 8.98,inset = 0,y = 3.4,
       legend = c("0","1","10","100","1000"), 
       col=c("gray50", brewer.pal(n = 6, name = "YlOrRd")), lwd=10, cex=1, horiz = F)
dev.off()

# 1km
png("project/Tiling/data/popgrid/dec2018/mcdi_worldpop_1k_raster_new.png", height = 800, width = 1200)
par(mfrow = c(2,2))
plot(landscan, xlim = c(8.4, 9), ylim = c(3,4), main = "LandScan(1km) for Bioko", breaks= cuts, col=c("gray50", brewer.pal(n = 6, name = "YlOrRd")), legend = F)
legend(x = 9, y = 3.5,inset = 0,
       legend = c("0","1","10","100","1000","10000"), 
       col=c("gray50", brewer.pal(n = 6, name = "YlOrRd")), lwd=5, cex=1, horiz = F)
plot(world_1k_2010, xlim = c(8.4, 9), ylim = c(3,4), main = "WorldPOP(1km) for Bioko", breaks= cuts, col=c("gray50", brewer.pal(n = 6, name = "YlOrRd")), legend = F)
legend(x = 9, y = 3.5,inset = 0,
       legend = c("0","1","10","100","1000","10000"), 
       col=c("gray50", brewer.pal(n = 6, name = "YlOrRd")), lwd=5, cex=1, horiz = F)
plot(r_mcdi1k, xlim = c(8.4, 9), ylim = c(3,4), 
     main = "MCDI(1km) for Bioko", breaks= cuts, 
     col=c("gray50", brewer.pal(n = 4, name = "YlOrRd")), legend = F)
plot(world_1k_2010, col=c("gray50"), legend = F, add = T)
plot(r_mcdi1k, xlim = c(8.4, 9), ylim = c(3,4), 
     main = "MCDI(1km) for Bioko", breaks= cuts, 
     col=c("gray50", brewer.pal(n = 4, name = "YlOrRd")), legend = F, add = T)
legend(x = 8.98, y = 3.5,inset = 0,
       legend = c("0","1","10","100","1000","10000"), 
       col=c("gray50", brewer.pal(n = 6, name = "YlOrRd")), lwd=5, cex=1, horiz = F)
dev.off()

