library(spdep)

urban_cell <- gTouches(urban_poly,urban_poly, byid = TRUE)
g_urban <- igraph::graph.adjacency(urban_cell)
clu_urban <- igraph::components(g_urban)

large_urban_id <- which(clu_urban$membership == 2)
large_urban_poly <- urban_poly[large_urban_id,]

large_urban_poly.nb <- poly2nb(large_urban_poly)
summary(large_urban_poly.nb)
plot(large_urban_poly,border=gray(.5))
plot(large_urban_poly.nb,coordinates(large_urban_poly),col="blue",add=TRUE)

spop <- scale(data.frame(large_urban_poly@data[,c("pop")]))
lcosts <- nbcosts(large_urban_poly.nb,spop)
large_urban_poly.nb.w <- nb2listw(large_urban_poly.nb,lcosts,style="B")
summary(large_urban_poly.nb.w)


large_urban_poly.mst <- mstree(large_urban_poly.nb.w)
dim(large_urban_poly.mst)

plot(large_urban_poly.mst,coordinates(large_urban_poly),col="blue",
     cex.lab=0.7)
plot(large_urban_poly,border=gray(.5),add=TRUE)

# 4 clusters

clus4 <- skater(large_urban_poly.mst[,1:2],spop,3)
str(clus4)
table(clus4$groups)
plot(large_urban_poly,col=c("red","green","blue","brown")[clus4$groups])

large_urban_poly$clu4 <- clus4$groups

# 6 clusters

clus6 <- skater(large_urban_poly.mst[,1:2],spop,5)
table(clus6$groups)
plot(large_urban_poly,col=c("red","green","blue","brown", "yellow", "grey")[clus6$groups])

large_urban_poly$clu6 <- clus6$groups

# 8 clusters

clus8 <- skater(large_urban_poly.mst[,1:2],spop,7)
table(clus8$groups)
plot(large_urban_poly,col=c("red","green","blue","brown", "yellow", "grey", "cyan", "pink")[clus8$groups])

large_urban_poly$clu8 <- clus8$groups

# 10 clusters

clus10 <- skater(large_urban_poly.mst[,1:2],spop,9)
table(clus10$groups)
large_urban_poly$clu10 <- clus10$groups

# 15 clusters

clus15 <- skater(large_urban_poly.mst[,1:2],spop,14)
table(clus15$groups)
large_urban_poly$clu15 <- clus15$groups

# leaflet
labels <- sprintf(
  "population: %s",
  large_urban_poly$pop) %>% lapply(htmltools::HTML)

pal_clu4 <- colorFactor(palette = c("red","green","blue","yellow"), domain = large_urban_poly$clu4)
leaflet(large_urban_poly) %>% addTiles() %>%
  addPolygons(data = large_urban_poly,weight = 1, color = "grey", fillColor = ~pal_clu4(clu4),
              label = labels) %>%
  addLegend(values=~clu4,pal=pal_clu4,title="Bioko: 4 clusters by using MST") 


pal_clu6 <- colorFactor(palette = c("red","green","blue","yellow", "pink", "cyan"), domain = large_urban_poly$clu6)
leaflet(large_urban_poly) %>% addTiles() %>%
  addPolygons(data = large_urban_poly,weight = 1, color = "grey", fillColor = ~pal_clu6(clu6),
              label = labels) %>%
  addLegend(values=~clu8,pal=pal_clu8,title="Bioko: 6 clusters by using MST") 


pal_clu8 <- colorFactor(palette = c("red","green","blue","yellow", "pink", "cyan", "dodgerblue", "darkorange"), domain = large_urban_poly$clu8)
leaflet(large_urban_poly) %>% addTiles() %>%
  addPolygons(data = large_urban_poly,weight = 1, color = "grey", fillColor = ~pal_clu8(clu8),
              label = labels) %>%
  addLegend(values=~clu8,pal=pal_clu8,title="Bioko: 8 clusters by using MST") 

pal_clu10 <- colorFactor(palette = c("red","green","blue","yellow", "pink", "cyan", "dodgerblue", "darkorange", "forestgreen", "lightgoldenrod4"), domain = large_urban_poly$clu10)
leaflet(large_urban_poly) %>% addTiles() %>%
  addPolygons(data = large_urban_poly,weight = 1, color = "grey", fillColor = ~pal_clu10(clu10),
              label = labels) %>%
  addLegend(values=~clu10,pal=pal_clu10,title="Bioko: 10 clusters by using MST") 

pal_clu15 <- colorFactor(palette = c("red","green","blue","yellow", "pink", "cyan", "dodgerblue", "darkorange", "forestgreen", "lightgoldenrod4",
                                     "mediumpurple4", "magenta3", "grey", "white", "black"), domain = large_urban_poly$clu15)
leaflet(large_urban_poly) %>% addTiles() %>%
  addPolygons(data = large_urban_poly,weight = 1, color = "grey", fillColor = ~pal_clu15(clu15),
              label = labels) %>%
  addLegend(values=~clu15,pal=pal_clu15,title="Bioko: 15 clusters by using MST") 
