library(spdep)
library(sp)
library(igraph)
blob_analysis_plot <- function(shapefile, pop_var, dataname){
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
       ylab = "Population in each blob", xlab = "Number of connected pixels in each blob", xaxt='n', yaxt='n', xlim = c(0, 3))
  xticks <- seq(0, 3, by=1)
  xlabels <- sapply(xticks, function(i) as.expression(bquote(10^ .(i))))
  axis(1, at=c(0, 1,2,3), labels=xlabels)
  yticks <- seq(0, 5, by=1)
  ylabels <- sapply(yticks, function(i) as.expression(bquote(10^ .(i))))
  axis(2, at=c(0, 1,2,3,4,5), labels=ylabels)
  
}

