popsum = rep(NA, 204)
for (i in 1:204){
  idlist = as.numeric(group_information[[i]]) + 1
  popsum[i] = sum(shp_15$pop[idlist], na.rm = T)
}

hist(log(popsum,10), main = "Population counts in 204 blobs")

plot(log(com_cluster,10), log(popsum,10), main = "cells and population counts in 204 blobs")

shp_15_cent = coordinates(shp_15)
shp_15_wt_df = data.frame(shp_15_cent)
shp_15_wt_df$pop = shp_15$pop
colnames(shp_15_wt_df) = c("x", "y", "pop")
coordinates(shp_15_wt_df) = ~x+y

wt_cent = data.frame('x' = rep(NA, 204), 'y' = rep(NA, 204))
for (i in 1:204){
  idlist = as.numeric(group_information[[i]]) + 1
  wt_cent[i,] = data.frame(x = weighted.mean(shp_15_wt_df$x[idlist], shp_15_wt_df$pop[idlist]), y = 
                             weighted.mean(shp_15_wt_df$y[idlist], shp_15_wt_df$pop[idlist]))
}

coordinates(wt_cent) = ~x+y
leaflet(shp_15) %>% addTiles() %>%
  addPolygons(data = shp_15, weight = 2, color = ~pal_population(pop),fillColor = ~pal_population(pop)) %>%
  addLegend(values=~pop,pal=pal_population,title="Population in cells(Bioko)") %>%
  addCircles(data = wt_cent, color = "green")

