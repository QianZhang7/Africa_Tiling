ad_cell <- gTouches(shp_15, byid = TRUE)
idlist <- seq(1, 3174)

g <- igraph::graph.adjacency(ad_cell)
clu <- igraph::components(g)

group_information <- igraph::groups(clu)
