library(ggplot2)
library(vcdExtra)
library(raster)

match_pnt_polygon <- function(points, shpfile){
  pnt_cnt <- length(points)
  shp_len <- length(shpfile)
  match <- rep(NA,pnt_cnt)
  for (i in 1:pnt_cnt){
    for (j in 1:shp_len){
      flag <- point.in.polygon(points@coords[i,1],points@coords[i,2], shpfile@polygons[[j]]@Polygons[[1]]@coords[,1], shpfile@polygons[[j]]@Polygons[[1]]@coords[,2])
      if(flag == 1){
        match[i] <- j
        break
      }
    }
  }
  return(match)
}


mcdi_pr_mask_point <- as.data.frame(rasterToPoints(mcdi_pr_mask))
coordinates(mcdi_pr_mask_point) <- ~ x + y
mcdi_pr_mask_point$polygonid <- match_pnt_polygon(mcdi_pr_mask_point,mcdi1k_shp)
mcdi_pr_mask_point$pop <- as.numeric(as.character(mcdi1k_shp$pop[mcdi_pr_mask_point$polygonid]))

mcdi_pr_dup <- expand.dft(as.data.frame(mcdi_pr_mask_point), freq= "pop")

dup_g1 <- ggplot(mcdi_pr_dup, aes(x = mcdi_Prevalence_mean)) + 
  geom_histogram(aes(y = ..density..), binwidth = 0.005, colour = 'sky blue', fill = 'sky blue') + 
  geom_density(colour = 'blue') + ylim(c(0,90))+ xlim(c(0,0.5))


landscan_pr_mask_point <- as.data.frame(rasterToPoints(landscan_pr_mask_2))
coordinates(landscan_pr_mask_point) <- ~ x + y
landscan_pr_mask_point$polygonid <- match_pnt_polygon(landscan_pr_mask_point,landscan_shp)
landscan_pr_mask_point$pop <- landscan_shp$dblbnd[landscan_pr_mask_point$polygonid]

landscan_pr_dup <- expand.dft(as.data.frame(landscan_pr_mask_point), freq= "pop")

dup_g2 <- ggplot(landscan_pr_dup, aes(x = ls_Prevalence_mean)) + 
  geom_histogram(aes(y = ..density..), binwidth = 0.005, colour = 'light green', fill = 'light green') + 
  geom_density(colour = 'dark green')+ ylim(c(0,90))+ xlim(c(0,0.5))

worldpop_pr_mask_point <- as.data.frame(rasterToPoints(worldpop_pr_mask_2))
coordinates(worldpop_pr_mask_point) <- ~ x + y
worldpop_pr_mask_point$polygonid <- match_pnt_polygon(worldpop_pr_mask_point,world1k_shp)
worldpop_pr_mask_point$pop <- world1k_shp$AFR_PPP_2010_adj_v2[worldpop_pr_mask_point$polygonid]

worldpop_pr_dup <- expand.dft(as.data.frame(worldpop_pr_mask_point), freq= "pop")

dup_g3 <- ggplot(worldpop_pr_dup, aes(x = wp_Prevalence_mean)) + 
  geom_histogram(aes(y = ..density..), binwidth = 0.005, colour = 'orange', fill = 'orange') + 
  geom_density(colour = 'red')+ ylim(c(0,90)) + xlim(c(0,0.5))


library(gridExtra)
grid.arrange(dup_g1, dup_g2,dup_g3, ncol=3)


ggplot(mcdi_pr_dup, aes(x = mcdi_Prevalence_mean)) + 
  geom_density(colour = 'blue') + ylim(c(0,90))+ xlim(c(0,0.5)) +
  geom_density(data = landscan_pr_dup, aes(x = ls_Prevalence_mean), colour = 'dark green') +
  geom_density(data = worldpop_pr_dup, aes(x = wp_Prevalence_mean), colour = 'red') +
  annotate('text', label = c("mcdi", 'landscan', "worldpop")) + theme_bw() + theme( panel.grid.major = element_blank(),
                                                                                   panel.grid.minor = element_blank(), axis.line = element_line(colour = "black"))













