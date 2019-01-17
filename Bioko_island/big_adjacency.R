world_1k_2010_shp = rasterToPolygons(world_1k_2010)
ad_world_1k_2010_shp = gTouches(world_1k_2010_shp, world_1k_2010_shp,  byid = TRUE)
world_100_2010_shp = rasterToPolygons(world_100_2010)
#ad_world_100_2010_shp = gTouches(world_100_2010_shp[1:10000,], world_100_2010_shp[10001:20000,],  byid = TRUE)

# polyids = seq_along(world_1k_2010_shp)
# adjMat = matrix(FALSE, ncol = length(world_1k_2010_shp), nrow = length(world_1k_2010_shp))
# for (ii in polyids) {
#   for (jj in setdiff(polyids, seq_len(ii))) {
#     adjMat[ii, jj] = 
#       class(gIntersection(world_1k_2010_shp[ii, ], world_1k_2010_shp[jj, ])) == 'SpatialLines'
#   }
# }
ad_world_1k_2010_shp2 = gOverlaps(world_1k_2010_shp, world_1k_2010_shp,  byid = TRUE)

library(spdep)
library(sp)
nb <- poly2nb(world_1k_2010_shp, queen = F)
mat <- nb2mat(nb, style="B")

nb_100 <- poly2nb(world_100_2010_shp, queen = F)
