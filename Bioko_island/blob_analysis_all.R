par(mfrow = c(2,2))
blob_analysis_plot(mcdi100_shp, pop_var = "PEOPLE_N", dataname = "MCDI 100m", color = 'red')

mcdi1k_shp$pop_num <- as.numeric(as.character(mcdi1k_shp$pop))
blob_analysis_plot(mcdi1k_shp, pop_var = "pop_num", dataname = "MCDI 1k", color = 'orange')

landscan_shp <- rasterToPolygons(landscan)
landscan_shp <- landscan_shp[landscan_shp$dblbnd>0,]
blob_analysis_plot(landscan_shp, pop_var = "dblbnd", dataname = "Landscan 1k", color = 'dark green')

world_1k_2010_shp = rasterToPolygons(world_1k_2010)
world_1k_2010_shp <- world_1k_2010_shp[world_1k_2010_shp$AFR_PPP_2010_adj_v2>0,]

blob_analysis_plot_worldpop_1k <- function(shapefile, pop_var, dataname, color = color){
  nb <- poly2nb(shapefile, queen = F)
  mat <- nb2mat(nb, style="B", zero.policy = T)
  cell_num <- length(shapefile)
  idlist <- seq(1, cell_num)
  rownames(mat) <- idlist
  colnames(mat) <- idlist
  g <- igraph::graph.adjacency(mat)
  clu <- igraph::components(g)
  group_information <- igraph::groups(clu)
  popsum = rep(NA, clu$no)
  for (i in 1:clu$no){
    idlist = as.numeric(group_information[[i]]) + 1
    popsum[i] = sum(shapefile[[pop_var]][idlist], na.rm = T)
  }
  com_cluster <- rep(NA, clu$no)
  for (i in 1:clu$no){
    com_cluster[i] <- length(group_information[[i]])
  }
  plot(log(com_cluster,10), log(popsum,10), main = paste(dataname, ":", clu$no, "blobs (4 directions)",sep = " "),
       ylab = "Population in each blob",color = color, xlab = "Number of connected pixels in each blob", xaxt='n', yaxt='n', xlim = c(0, 4), ylim = c(0, 6))
  xticks <- seq(0, 4, by=1)
  xlabels <- sapply(xticks, function(i) as.expression(bquote(10^ .(i))))
  axis(1, at=c(0, 1,2,3,4), labels=xlabels)
  yticks <- seq(0, 6, by=1)
  ylabels <- sapply(yticks, function(i) as.expression(bquote(10^ .(i))))
  axis(2, at=c(0, 1,2,3,4,5,6), labels=ylabels)
  
}



blob_analysis_plot_worldpop_1k(world_1k_2010_shp, pop_var = "AFR_PPP_2010_adj_v2", dataname = "WorldPOP 1k", color = 'blue')
