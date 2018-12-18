library(spdep)

urban_cell <- gTouches(urban_poly,urban_poly, byid = TRUE)
g_urban <- igraph::graph.adjacency(urban_cell)
clu_urban <- igraph::components(g_urban)

large_urban_id <- which(clu_urban$membership == 2)
large_urban_poly <- urban_poly[large_urban_id,]

large_urban_poly.nb <- poly2nb(large_urban_poly, queen = T)
summary(large_urban_poly.nb)
plot(large_urban_poly,border=gray(.5))
plot(large_urban_poly.nb,coordinates(large_urban_poly),col="blue",add=TRUE)

###### mcdi pop #######################################

spop <- scale(data.frame(large_urban_poly@data[,c("pop")]))
lcosts <- nbcosts(large_urban_poly.nb,spop)
large_urban_poly.nb.w <- nb2listw(large_urban_poly.nb,lcosts,style="B")
summary(large_urban_poly.nb.w)
large_urban_poly.mst <- mstree(large_urban_poly.nb.w)
dim(large_urban_poly.mst)

plot(large_urban_poly.mst,coordinates(large_urban_poly),col="blue",
     cex.lab=0.7)
plot(large_urban_poly,border=gray(.5),add=TRUE)

# 10 clusters

clus10 <- skater(large_urban_poly.mst[,1:2],spop,9)
str(clus10)
table(clus10$groups)
plot(large_urban_poly,col=c("red","green","blue","yellow", "pink", "cyan", "dodgerblue", "darkorange", "forestgreen", "lightgoldenrod4")[clus10$groups])

large_urban_poly$clu10 <- clus10$groups

labels <- sprintf(
  "population: %s",
  large_urban_poly$pop) %>% lapply(htmltools::HTML)

pal_clu10 <- colorFactor(palette = c("red","green","blue","yellow", "pink", "cyan", "dodgerblue", "darkorange", "forestgreen", "lightgoldenrod4"), domain = large_urban_poly$clu10)
map_mcdi <- leaflet(large_urban_poly) %>% addTiles() %>%
  addPolygons(data = large_urban_poly,weight = 1, color = "grey", fillColor = ~pal_clu10(clu10),
              label = labels) #%>%
  #addLegend(values=~clu10,pal=pal_clu10,title="Bioko: 10 clusters by using MCDI pop") 



########## worldpop ###################################################
large_urban_poly$bioko_world_pop_2010[is.na(large_urban_poly$bioko_world_pop_2010)] <- 0
spop_world <- scale(data.frame(large_urban_poly@data[,c("bioko_world_pop_2010")]))
lcosts_world <- nbcosts(large_urban_poly.nb,spop_world)
large_urban_poly.nb.w_world <- nb2listw(large_urban_poly.nb,lcosts_world,style="B")
summary(large_urban_poly.nb.w_world)
large_urban_poly.mst_world <- mstree(large_urban_poly.nb.w_world)
dim(large_urban_poly.mst_world)

plot(large_urban_poly.mst_world,coordinates(large_urban_poly),col="blue",
     cex.lab=0.7)
plot(large_urban_poly,border=gray(.5),add=TRUE)

# 10 clusters

clus10_world <- skater(large_urban_poly.mst_world[,1:2],spop,9)
str(clus10_world)
table(clus10$groups)
plot(large_urban_poly,col=c("red","green","blue","yellow", "pink", "cyan", "dodgerblue", "darkorange", "forestgreen", "lightgoldenrod4")[clus10$groups])

large_urban_poly$clu10_world <- clus10_world$groups

labels_world <- sprintf("population: %s",large_urban_poly$bioko_world_pop_2010) %>% lapply(htmltools::HTML)

pal_clu10_world <- colorFactor(palette = c("red","green","blue","yellow", "pink", "cyan", "dodgerblue", "darkorange", "forestgreen", "lightgoldenrod4"), domain = large_urban_poly$clu10_world)
map_world <- leaflet(large_urban_poly) %>% addTiles() %>%
  addPolygons(data = large_urban_poly,weight = 1, color = "grey", fillColor = ~pal_clu10_world(clu10_world),
              label = labels_world) #%>%
  #addLegend(values=~clu10_world,pal=pal_clu10_world,title="Bioko: 10 clusters by using worldpop") 





########## landscan ###################################################
spop_landscan <- scale(data.frame(large_urban_poly@data[,c("bioko_landscan")]))
lcosts_landscan <- nbcosts(large_urban_poly.nb,spop_landscan)
large_urban_poly.nb.w_landscan <- nb2listw(large_urban_poly.nb,lcosts_landscan,style="B")
summary(large_urban_poly.nb.w_landscan)
large_urban_poly.mst_landscan <- mstree(large_urban_poly.nb.w_landscan)
dim(large_urban_poly.mst_landscan)

plot(large_urban_poly.mst_landscan,coordinates(large_urban_poly),col="blue",
     cex.lab=0.7)
plot(large_urban_poly,border=gray(.5),add=TRUE)

# 10 clusters

clus10_landscan <- skater(large_urban_poly.mst_landscan[,1:2],spop,9)
str(clus10_landscan)
table(clus10_landscan$groups)
plot(large_urban_poly,col=c("red","green","blue","yellow", "pink", "cyan", "dodgerblue", "darkorange", "forestgreen", "lightgoldenrod4")[clus10_landscan$groups])

large_urban_poly$clu10_landscan <- clus10_landscan$groups

labels_landscan <- sprintf("population: %s",large_urban_poly$bioko_landscan) %>% lapply(htmltools::HTML)

pal_clu10_landscan <- colorFactor(palette = c("red","green","blue","yellow", "pink", "cyan", "dodgerblue", "darkorange", "forestgreen", "lightgoldenrod4"), domain = large_urban_poly$clu10_landscan)
map_landscan <- leaflet(large_urban_poly) %>% addTiles() %>%
  addPolygons(data = large_urban_poly,weight = 1, color = "grey", fillColor = ~pal_clu10_landscan(clu10_landscan),
              label = labels_landscan) #%>%
  #addLegend(values=~clu10_landscan,pal=pal_clu10_landscan,title="Bioko: 10 clusters by using landscan") 

sync(map_mcdi, map_world,map_landscan)
