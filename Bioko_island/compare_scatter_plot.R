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


world_1k_2010_points = as.data.frame(rasterToPoints(world_1k_2010))
coordinates(world_1k_2010_points) <- ~ x + y
world_1k_2010_points$polygonid <- match_pnt_polygon(world_1k_2010_points,mcdi1k_shp)
world_1k_2010_points$pop <- as.numeric(as.character(mcdi1k_shp$pop_num[world_1k_2010_points$polygonid]))

zeros = intersect(which(is.na(world_1k_2010_points$pop)),which(world_1k_2010_points$AFR_PPP_2010_adj_v2 == 0))
zero_percent = length(zeros)/length(world_1k_2010_points$pop) *100

world_1k_2010_points <- world_1k_2010_points[-zeros,]
world_1k_2010_points$pop[is.na(world_1k_2010_points$pop)] <- 0
world_1k_2010_points$jitter_pop <- world_1k_2010_points$pop + jitter(rep(0.1, length(world_1k_2010_points$pop)))
#world_1k_2010_points$log_worldpop_1k <- log(world_1k_2010_points$AFR_PPP_2010_adj_v2,10)
#world_1k_2010_points$log_mcdi_1k <- log(world_1k_2010_points$jitter_pop,10)
library(scales)
#plot_worldpop_1k <- ggplot(as.data.frame(world_1k_2010_points), aes(x = log_mcdi_1k, y = log_worldpop_1k, color = 'red')) + geom_point()
plot_worldpop_1k <- ggplot(as.data.frame(world_1k_2010_points), aes(x = jitter_pop, y = AFR_PPP_2010_adj_v2, color = 'red')) + geom_point()
plot_worldpop_1k_log<- plot_worldpop_1k + scale_x_continuous(name="log_scaled MCDI population", trans='log10', 
                                      breaks = trans_breaks("log10", function(x) 10^x),
                                      labels = trans_format("log10", math_format(10^.x))) +
  scale_y_continuous(name="log-scaled WorldPOP population", trans='log10')+
  geom_vline(xintercept = 1, color = 'gray') + geom_hline(yintercept = 1, color = 'gray')

plot_worldpop_1k_log + theme(legend.position="none", plot.title = element_text(hjust = 0.5)) +
  annotate("text", x = 0.35, y = 0.7, label = "0.04% cases \n are both 0s")+
  ggtitle("MCDI vs WorldPOP (1km)")

