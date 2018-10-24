large_id <- which(com_cluster == 1920)
urban_ele <- as.numeric(unlist(group_information[large_id]))
urban_poly <- shp_15[urban_ele,]
urban_poly$urban <- rep(NA, 1920)

for (i in 1:1920){
  if(urban_poly$pop[i] >= 100){
    urban_poly$urban[i] <- 1
  }else{
    urban_poly$urban[i] <- 0
  }
}

pal_binary <- colorFactor(palette = c('blue', 'red'), domain = urban_poly$urban)

leaflet(urban_poly) %>% addTiles() %>%
  addPolygons(data = urban_poly,weight = 1, color = "grey", fillColor = ~pal_binary(urban)) %>%
  addLegend(values=~urban,pal=pal_binary,title="pop >100 cells(Bioko)") 

para_urban <- urban_poly[which(urban_poly$urban == 0),]

leaflet(para_urban) %>% addTiles() %>%
  addPolygons(data = para_urban,weight = 1, color = "grey", fillColor = 'blue') %>%
  addLegend(values=~urban,pal=pal_binary,title="pop >100 cells(Bioko)") 


centroid <- gCentroid(para_urban, byid = TRUE)

para_urban_df <- as.data.frame(coordinates(centroid))

para_urban_df$pop <- para_urban$pop

WithinClusterSumOfSquares <- rep(NA, 14)

for (i in 2:15) {
  ClusterInfo=kmeans(para_urban_df, centers=i)
  WithinClusterSumOfSquares[i] = sum(ClusterInfo$withinss)
}

plot(1:15, WithinClusterSumOfSquares, type="b", xlab="Number of Clusters",ylab="Within groups sum of squares") 

# choose i = 6

Cluster=kmeans(para_urban_df, centers=6)

para_urban$cluster <- Cluster$cluster


pal_cluster <- colorFactor(palette = c("red", "blue", "green", "pink", "yellow", "orange"), domain = para_urban$cluster)

leaflet(para_urban) %>% addTiles() %>%
  addPolygons(data = para_urban,weight = 1, color = "grey", fillColor = ~pal_cluster(cluster))

