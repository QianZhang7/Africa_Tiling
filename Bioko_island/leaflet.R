urban_poly$urban_200 <- rep(NA, 1920)

for (i in 1:1920){
  if(urban_poly$pop[i] >= 200){
    urban_poly$urban_200[i] <- 1
  }else{
    urban_poly$urban_200[i] <- 0
  }
}

pal_binary <- colorFactor(palette = c('blue', 'red'), domain = urban_poly$urban_200)

leaflet(urban_poly) %>% addTiles() %>%
  addPolygons(data = urban_poly,weight = 1, color = "grey", fillColor = ~pal_binary(urban_200)) %>%
  addLegend(values=~urban,pal=pal_binary,title="pop >200 cells(Bioko)") 

para_urban <- urban_poly[which(urban_poly$urban == 0),]

leaflet(para_urban) %>% addTiles() %>%
  addPolygons(data = para_urban,weight = 1, color = "grey", fillColor = 'blue') %>%
  addLegend(values=~urban,pal=pal_binary,title="pop >100 cells(Bioko)") 

library(rasterVis)

