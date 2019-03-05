library(raster)
library(rasterVis)
mcdi_pr <- raster("project/Tiling/denominators/mcdi_Prevalence_mean.tif")
landscan_pr <- raster("project/Tiling/denominators/ls_Prevalence_mean.tif")
worldpop_pr <- raster("project/Tiling/denominators/wp_Prevalence_mean.tif")
load("project/Tiling/data/population/population_rasters.RData")
mcdi_1k_r <- raster("project/Tiling/data/population/mcdi1k.tif")
mcdi_pr_mask <- mask(mcdi_pr, mcdi1k_shp)
landscan_pr_mask <- mask(landscan_pr, mcdi1k_shp)
worldpop_pr_mask <- mask(worldpop_pr, mcdi1k_shp)
levelplot(mcdi_pr_mask, main = "MCDI")
mapTheme <- rasterTheme(region=c(brewer.pal(8,"YlOrRd")))
mapTheme$panel.background$col = 'gray50' 
p1 <- levelplot(mcdi_pr_mask, main = "MCDI", at = seq(0,0.5,0.01), par.settings=mapTheme, margin=list(x=c(0,0), y=c(0,0)))
p2 <- levelplot(landscan_pr_mask, main = "Landscan", at = seq(0,0.5,0.01), par.settings=mapTheme, margin=list(x=c(0,0), y=c(0,0)))
p3 <- levelplot(worldpop_pr_mask, main = "WorldPOP", at = seq(0,0.5,0.01), par.settings=mapTheme, margin=list(x=c(0,0), y=c(0,0)))




grid.arrange(p1, p2,p3, ncol=3)
grid.draw(grobTree(rectGrob(gp=gpar(fill="white", lwd=0)), arrangeGrob(p1, p2,p3, ncol=3)))


mcdi_pr_mask_poly <- rasterToPolygons(mcdi_pr_mask)
mcdi_pr_population <- extract(mcdi_1k_r, mcdi_pr_mask_poly, fun = sum)
mcdi_pr_count <- mcdi_pr_mask

j = 1
for (i in 1:length(mcdi_pr_count)){
  if(!is.na(mcdi_pr_count[i])){
    mcdi_pr_count[i] <- mcdi_pr_count[i] * mcdi_pr_population[j]
    j <- j +1
  }
}
  
c1 <- levelplot(mcdi_pr_count, main = "MCDI Pf Counts", par.settings=mapTheme, margin=list(x=c(0,0), y=c(0,0)))


landscan_pr_mask_poly <- rasterToPolygons(landscan_pr_mask)
landscan_pr_population <- extract(landscan, landscan_pr_mask_poly, fun = sum)
landscan_pr_count <- landscan_pr_mask

j = 1
for (i in 1:length(landscan_pr_count)){
  if(!is.na(landscan_pr_count[i])){
    landscan_pr_count[i] <- landscan_pr_count[i] * landscan_pr_population[j]
    j <- j +1
  }
}

c2 <- levelplot(landscan_pr_count, main = "Landscan Pf Counts", par.settings=mapTheme, margin=list(x=c(0,0), y=c(0,0)))

worldpop_pr_mask_poly <- rasterToPolygons(worldpop_pr_mask)
worldpop_pr_population <- extract(world_1k_2010, landscan_pr_mask_poly, fun = sum)
worldpop_pr_count <- worldpop_pr_mask

j = 1
for (i in 1:length(worldpop_pr_count)){
  if(!is.na(worldpop_pr_count[i])){
    worldpop_pr_count[i] <- worldpop_pr_count[i] * worldpop_pr_population[j]
    j <- j +1
  }
}

c3 <- levelplot(worldpop_pr_count, main = "WorldPop Pf Counts", par.settings=mapTheme, margin=list(x=c(0,0), y=c(0,0)))

grid.arrange(c1, c2, c3, ncol=3)
grid.draw(grobTree(rectGrob(gp=gpar(fill="white", lwd=0)), arrangeGrob(c1, c2,c3, ncol=3)))
