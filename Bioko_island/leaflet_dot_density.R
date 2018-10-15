sampled_15 <- points %>% filter(group != "Individuals")
leaflet(shp_15) %>% addTiles() %>%
  addPolygons(weight = 2, fillOpacity = 0, color = "grey", opacity = 0.5)

sampled_15_sp <- rev(sampled_15)

coordinates(sampled_15_sp) <- ~x + y

pal <- colorFactor(
  palette = c("Negative" = "yellow", "Positive" = "Red"),
  domain = sampled_15_sp$group
)

pal_population <- colorBin("Blues", domain = shp_15$pop , bins = c(1,10, 20, 50,100,200,500,700))

pal_pfpr <- colorBin("Greens", domain = shp_15$pf/shp_15$n , bins = c(0,0.25,0.5, 0.75,1))

map1<-leaflet(shp_15) %>% addTiles() %>%
  addPolygons(data = shp_15,weight = 2, color = "grey", fillColor = ~pal_population(pop),) %>%
  addLegend(values=~pop,pal=pal_population,title="Population in cells(Bioko)") %>%
  addCircles(data = sampled_15_sp, color = ~pal(group),fill= FALSE, stroke = TRUE, opacity = 0.5, weight = 2)

map2<-leaflet(shp_15) %>% addTiles() %>%
  addPolygons(data = shp_15,weight = 2, color = "grey", fillColor = ~pal_pfpr(shp_15$pf/shp_15$n),) %>%
  addLegend(values=~pop,pal=pal_pfpr,title="PFPR in cells(Bioko)") %>%
  addCircles(data = sampled_15_sp, color = ~pal(group),fill= FALSE, stroke = TRUE, opacity = 0.5, weight = 2)

library(mapview)
sync(map1, map2)
