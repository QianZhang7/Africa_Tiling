ad_cell <- gTouches(shp_15,shp_15, byid = TRUE)
idlist <- seq(1, 3172)

g <- igraph::graph.adjacency(ad_cell)
clu <- igraph::components(g)
dg <- decompose.graph(g)
plot(dg[[6]])

g1 <- igraph::graph_from_adjacency_matrix( ad_cell )
clu1 <- igraph::components(g1)
group_information <- igraph::groups(clu)

csize <- length(group_information)
com_cluster <- rep(NA, csize)
for (i in 1:csize){
  com_cluster[i] <- length(group_information[[i]])
}

hist(log(com_cluster, 10))
