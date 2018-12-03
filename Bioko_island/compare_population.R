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
plot(jrc_ghs, xlim = c(8.5, 9), ylim = c(3,4), main = "jrc_ghs for Bioko")

shp_pop_raster <- rasterize(shp_pop, world_pop_2010, field = shp_pop@data$pop, fun = "mean", update = T, updateValue = "NA")

landscan_d <- disaggregate(landscan, fact = c(626/63, 568/56))
landscan_d <- landscan_d/100




pop_vals <- data.frame(world_pop_2010=values(world_pop_2010),
                       shp_pop_raster=values(shp_pop_raster))


#########################################
world_pop_bioko <- values(world_pop_2010)
world_pop_bioko <- world_pop_bioko[!is.na(world_pop_bioko)]
world_pop_bioko <- world_pop_bioko[world_pop_bioko!=0]
mcdi_pop <- shp_pop$pop
landscan_pop <- values(landscan)
landscan_pop <- landscan_pop[!is.na(landscan_pop)]/100
landscan_pop <- landscan_pop[landscan_pop!=0]

landscan_cdf <- ecdf(landscan_pop)
worldpop_cdf <- ecdf(world_pop_bioko)
mcdi_cdf <- ecdf(mcdi_pop)

plot(landscan_cdf, verticals=TRUE, do.points=T, col = 'red', main = "cdf plots")
plot(worldpop_cdf, verticals=TRUE, do.points=T, add=TRUE, col='green')
plot(mcdi_cdf, verticals=TRUE, do.points=T, add=TRUE, col = 'blue')
legend(250, 0.6, legend = c('landscan', 'worldpop', 'mcdi'), col = c('red', 'green', 'blue'), lty = 1, cex = 0.5)
