ad_cell <- gTouches(shp_15, byid = TRUE)
idlist <- seq(1, 3174)

g <- igraph::graph.adjacency(ad_cell)
clu <- igraph::components(g)

group_information <- igraph::groups(clu)

csize <- length(group_information)
com_cluster <- rep(NA, csize)
for (i in 1:csize){
  com_cluster[i] <- length(group_information[[i]])
}

hist(log(com_cluster, 10))
