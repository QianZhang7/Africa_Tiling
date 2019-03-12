library(raster)
library(rasterVis)

landscan_shp <- rasterToPolygons(landscan)
landscan_shp <- landscan_shp[!is.na(landscan_shp@data$dblbnd),]
landscan_shp <- landscan_shp[which(landscan_shp@data$dblbnd > 0),]
landscan_pr_mask_2 <- mask(landscan_pr, landscan_shp)


world1k_shp <- rasterToPolygons(world_1k_2010)
world1k_shp <- world1k_shp[!is.na(world1k_shp@data$AFR_PPP_2010_adj_v2),]
world1k_shp <- world1k_shp[which(world1k_shp@data$AFR_PPP_2010_adj_v2 > 0),]
worldpop_pr_mask_2 <- mask(worldpop_pr, world1k_shp)
levelplot(mcdi_pr_mask, main = "MCDI")
mapTheme <- rasterTheme(region=c(brewer.pal(8,"YlOrRd")))
mapTheme$panel.background$col = 'gray50' 
p1 <- levelplot(mcdi_pr_mask, main = "MCDI", at = seq(0,0.5,0.01), par.settings=mapTheme, margin=list(x=c(0,0), y=c(0,0)))
p2 <- levelplot(landscan_pr_mask_2, main = "Landscan", at = seq(0,0.5,0.01), par.settings=mapTheme, margin=list(x=c(0,0), y=c(0,0)))
p3 <- levelplot(worldpop_pr_mask_2, main = "WorldPOP", at = seq(0,0.5,0.01), par.settings=mapTheme, margin=list(x=c(0,0), y=c(0,0)))

grid.arrange(p1, p2,p3, ncol=3)





# mcdi_pr_mask_poly <- rasterToPolygons(mcdi_pr_mask)
# mcdi_pr_population <- extract(mcdi_1k_r, mcdi_pr_mask_poly, fun = sum)
# mcdi_pr_count <- mcdi_pr_mask
# 
# j = 1
# for (i in 1:length(mcdi_pr_count)){
#   if(!is.na(mcdi_pr_count[i])){
#     mcdi_pr_count[i] <- mcdi_pr_count[i] * mcdi_pr_population[j]
#     j <- j +1
#   }
# }
# 
# c1 <- levelplot(mcdi_pr_count, main = "MCDI Pf Counts", at = seq(0,3000,100), par.settings=mapTheme, margin=list(x=c(0,0), y=c(0,0)))


landscan_pr_mask_poly_2 <- rasterToPolygons(landscan_pr_mask_2)
landscan_pr_population_2 <- extract(landscan, landscan_pr_mask_poly_2, fun = sum)
landscan_pr_count_2 <- landscan_pr_mask_2

j = 1
for (i in 1:length(landscan_pr_count_2)){
  if(!is.na(landscan_pr_count_2[i])){
    landscan_pr_count_2[i] <- landscan_pr_count_2[i] * landscan_pr_population_2[j]
    j <- j +1
  }
}

c2 <- levelplot(landscan_pr_count_2, main = "Landscan Pf Counts", at = seq(0,3000,100),par.settings=mapTheme, margin=list(x=c(0,0), y=c(0,0)))

worldpop_pr_mask_poly_2 <- rasterToPolygons(worldpop_pr_mask_2)
worldpop_pr_population_2 <- extract(world_1k_2010, worldpop_pr_mask_poly_2, fun = sum)
worldpop_pr_count_2 <- worldpop_pr_mask_2

j = 1
for (i in 1:length(worldpop_pr_count_2)){
  if(!is.na(worldpop_pr_count_2[i])){
    worldpop_pr_count_2[i] <- worldpop_pr_count_2[i] * worldpop_pr_population_2[j]
    j <- j +1
  }
}

c3 <- levelplot(worldpop_pr_count_2, main = "WorldPop Pf Counts",at = seq(0,3000,100), par.settings=mapTheme, margin=list(x=c(0,0), y=c(0,0)))

grid.arrange(c1, c2,c3, ncol=3)

hc1 = histogram(mcdi_pr_count, main = 'MCDI pf Counts')
hc2 = histogram(landscan_pr_count_2, main = "Landscan pf Counts")
hc3 = histogram(worldpop_pr_count_2, main = "Worldpop pf Counts")
grid.arrange(hc1, hc2,hc3, ncol=3)

#mcdi_pf_df <- data.frame(MCDI_PfCount = values(mcdi_pr_count))
landscan_pf_df_2 <- data.frame(Landscan_PfCount = values(landscan_pr_count_2))
worldpop_pf_df_2 <- data.frame(WorldPOP_PfCount = values(worldpop_pr_count_2))

par(mfrow = c(1,3))
gc1 <- ggplot(mcdi_pf_df, aes(x = MCDI_PfCount)) + 
  geom_histogram(aes(y = ..density..), binwidth = 10, colour = 'sky blue', fill = 'sky blue') + 
  geom_density(colour = 'blue')+ ylim(c(0,0.03))+ xlim(c(0,2500))
gc2 <- ggplot(landscan_pf_df_2, aes(x = Landscan_PfCount)) + 
  geom_histogram(aes(y = ..density..), binwidth = 10, colour = 'light green', fill = 'light green') + 
  geom_density(colour = 'dark green')+ ylim(c(0,0.03))+ xlim(c(0,2500))
gc3 <- ggplot(worldpop_pf_df_2, aes(x = WorldPOP_PfCount)) + 
  geom_histogram(aes(y = ..density..), binwidth = 10, colour = 'orange', fill = 'orange') + 
  geom_density(colour = 'red')+ ylim(c(0,0.03)) + xlim(c(0,2500))
grid.arrange(gc1, gc2,gc3, ncol=3)

stack_prc_2 = stack(mcdi_pr_count,landscan_pr_count_2,worldpop_pr_count_2)
names(stack_prc_2) <- c('MCDI_PfCounts', 'Landscan_PfCounts', 'WorldPOP_PfCounts')
densityplot(stack_prc_2)


mcdi_pfpr <- data.frame(MCDI_Pr = values(mcdi_pr_mask))
landscan_pfpr <- data.frame(Landscan_Pr = values(landscan_pr_mask_2))
worldpop_pfpr <- data.frame(WorldPOP_Pr = values(worldpop_pr_mask_2))

par(mfrow = c(1,3))
g1 <- ggplot(mcdi_pfpr, aes(x = MCDI_Pr)) + 
  geom_histogram(aes(y = ..density..), binwidth = 0.01, colour = 'sky blue', fill = 'sky blue') + 
  geom_density(colour = 'blue') +ylim(c(0,21))
g2 <- ggplot(landscan_pfpr, aes(x = Landscan_Pr)) + 
  geom_histogram(aes(y = ..density..), binwidth = 0.01, colour = 'light green', fill = 'light green') + 
  geom_density(colour = 'dark green')+ylim(c(0,21))
g3 <- ggplot(worldpop_pfpr, aes(x = WorldPOP_Pr)) + 
  geom_histogram(aes(y = ..density..), binwidth = 0.01, colour = 'orange', fill = 'orange') + 
  geom_density(colour = 'red')+ylim(c(0,21))
grid.arrange(g1, g2,g3, ncol=3)


stack_prc_3 = stack(mcdi_pr_mask,landscan_pr_mask_2,worldpop_pr_mask_2)
names(stack_prc_3) <- c('MCDI_PfPR', 'Landscan_PfPR', 'WorldPOP_PfPR')
densityplot(stack_prc_3)
