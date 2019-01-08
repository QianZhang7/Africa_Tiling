library(raster)
landscan <- raster("project/Tiling/data/popgrid/LandScan Global 2017/lspop2017/dblbnd.adf")
landscan <- crop(landscan, extent(shp_wgs))
plot(landscan, xlim = c(8.5, 9), ylim = c(3,4), main = "LandScan for Bioko")
ciesin <- raster("project/Tiling/data/popgrid/gpw-v4-population-count-adjusted-to-2015-unwpp-country-totals-rev10_2015_30_sec_tif/gpw_v4_population_count_adjusted_to_2015_unwpp_country_totals_rev10_2015_30_sec.tif")
plot(ciesin, xlim = c(8.5, 9), ylim = c(3,4), main = "CIESIN for Bioko")
world_pop_2010 <- raster("~/Documents/Equatorial Guinea 100m Population/GNQ15v2.tif")
world_pop_2010 <- crop(world_pop_2010, extent(shp_wgs))
plot(world_pop_2010, xlim = c(8.5, 9), ylim = c(3,4), main = "WorldPOP for Bioko")
cidr <- raster("project/Tiling/data/popgrid/popdynamics-pop-projection-ssp-2010-2100-ssp1-geotiff/SSP1/Total/GeoTIFF/ssp1_2010.tif")
plot(cidr, xlim = c(8.5, 9), ylim = c(3,4), main = "CIDR for Bioko")
jrc_ghs <- raster("project/Tiling/data/popgrid/GHS_POP_GPW42015_GLOBE_R2015A_54009_1k_v1_0/GHS_POP_GPW42015_GLOBE_R2015A_54009_1k_v1_0.tif")
raster::plot(jrc_ghs, xlim = c(8.5, 9), ylim = c(3,4), main = "jrc_ghs for Bioko")

shp_pop_raster <- rasterize(shp_pop, world_pop_2010, field = shp_pop@data$pop, fun = "mean", update = T, updateValue = "NA")




#########################################
world_pop_bioko <- values(world_pop_2010)
#world_pop_bioko <- world_pop_bioko[!is.na(world_pop_bioko)]
world_pop_bioko[is.na(world_pop_bioko)] <- 0

world_pop_bioko_1km_raster <- crop(world_pop, extent(shp_wgs))
world_pop_bioko_1km <- values(world_pop_bioko_1km_raster)
#world_pop_bioko_1km <- world_pop_bioko[!is.na(world_pop_bioko_1km)]
world_pop_bioko_1km[is.na(world_pop_bioko_1km)] <- 0


mcdi_pop <- shp_pop$pop
mcdi_pop[is.na(mcdi_pop)] <- 0

landscan_pop <- values(landscan)
#landscan_pop <- landscan_pop[!is.na(landscan_pop)]
landscan_pop[is.na(landscan_pop)] <- 0

#landscan_cdf <- ecdf(landscan_pop/sum(landscan_pop))
#worldpop_cdf <- ecdf(world_pop_bioko/sum(world_pop_bioko))
#mcdi_cdf <- ecdf(mcdi_pop/sum(mcdi_pop))
#worldpop_1km_cdf <- ecdf(world_pop_bioko_1km/sum(world_pop_bioko_1km))


# par(mfrow=c(2,2))
# plot(landscan_cdf, verticals=TRUE, do.points=T, col = 'red', main = "cdf plots for Landscan Population(1km)")
# plot(worldpop_1km_cdf, verticals=TRUE, do.points=T, col = 'orange', main = "cdf plots for WorldPOP Population(1km)")
# plot(worldpop_cdf, verticals=TRUE, do.points=T, col='green', main = "cdf plots for WorldPOP Population(100m)")
# plot(mcdi_cdf, verticals=TRUE, do.points=T, col = 'blue', main = "cdf plots for MCDI Population(100m)")


areaXpop.new = function(H, color, title){
  sH = sort(H)
  area = c(1:length(H))/length(H)
  cdf = cumsum(sH)/sum(H)
  plot(area, cdf, type ="l", col = color, main = title)
}
areaXpop = function(H, color){
  sH = sort(H)
  area = c(1:length(H))/length(H)
  cdf = cumsum(sH)/sum(H)
  lines(area, cdf, type ="l", col = color)
}

mcdi_pop_cdf = append(mcdi_pop,rep(0, (length(world_pop_bioko)-length(mcdi_pop))))
par(xpd=FALSE)
areaXpop.new(landscan_pop, color = "red", title = "Cdf plots")
areaXpop(world_pop_bioko_1km,color = "orange")
areaXpop(world_pop_bioko, color = "green")
areaXpop(mcdi_pop_cdf, color = "blue")

legend(0,1,c("Landscan:1km", "WorldPOP:1km", "WorldPOP:100m", "MCDI:100m"), col = c("red", "orange","green","blue"), lty = 1, cex = 0.6)
