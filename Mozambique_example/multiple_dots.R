library(maptools)
library(rgeos)
library(tidyverse)
library(rgdal)
library(ggthemes)
library(raster)
library(sp)
library(sf)
library(leaflet)
library(spatialEco)
load("project/Tiling/Africa_Tiling/Mozambique_example/Moz_data.RData")

Moz_pf_counts_df_plot <- Moz_pf_counts_df %>% filter(num_dots > 0)

Moz_pf_counts_df_plot_expanded <- Moz_pf_counts_df_plot[rep(row.names(Moz_pf_counts_df_plot), Moz_pf_counts_df_plot$num_dots), 1:3]
options(digits = 9)
Moz_pf_counts_df_plot_expanded$x2 = jitter(Moz_pf_counts_df_plot_expanded$x, factor = 0.0001)
Moz_pf_counts_df_plot_expanded$y2 = jitter(Moz_pf_counts_df_plot_expanded$y, factor = 0.0001)

coordinates(Moz_pf_counts_df_plot_expanded) <- ~ x2 + y2


Moz_population <- raster::extract(population, cbind(Moz_pf_counts_df_plot_expanded$x2, Moz_pf_counts_df_plot_expanded$y2), fun = 'sum', small = TRUE, na.rm = TRUE) 
Moz_pfpr <- raster::extract(PfPR, cbind(Moz_pf_counts_df_plot_expanded$x2, Moz_pf_counts_df_plot_expanded$y2), fun = 'mean', small = TRUE, na.rm = TRUE)


Moz_pf_counts_df_plot_expanded$Moz_population = Moz_population
Moz_pf_counts_df_plot_expanded$Moz_pfpr = Moz_pfpr


############# try multiple dot density plot######################

map1<- leaflet(Moz_pf_counts_df_plot_expanded) %>% addTiles() %>% addMarkers(
  clusterOptions = markerClusterOptions()
)%>% 
  addPolygons(data=Moz_a2, weight = 2, fillOpacity = 0, color = "grey")

############### add population layers ###############################
Moz_total_population <- raster::extract(population, cbind(Moz_pf_counts_df$x, Moz_pf_counts_df$y), fun = 'sum', small = TRUE, na.rm = TRUE) 
Moz_pf_counts_df$Moz_total_population <- Moz_total_population

coordinates(Moz_pf_counts_df) <- ~ x + y
proj4string(Moz_pf_counts_df) <- proj4string(Moz_a2)


Moz_a2@data$poly.ids <- 1:nrow(Moz_a2)
population_a2 <- point.in.poly(Moz_pf_counts_df, Moz_a2)
Moz_a2@data$mean_pop <-tapply(population_a2@data$Moz_total_population, population_a2@data$poly.ids, FUN=mean)

bins = c(0, 100, 200, 500, 1000, 2000, 5000, 10000, Inf)
pal <- colorBin("YlOrRd", domain = Moz_a2$mean_pop, bins = bins)

labels <- sprintf(
  "<strong>%s</strong><br/>%g people / resolution: ?25 km<sup>2</sup>",
  Moz_a2$NAME_2, Moz_a2$mean_pop
) %>% lapply(htmltools::HTML)


leaflet(Moz_pf_counts_df_plot_expanded) %>% addTiles() %>% addMarkers(
  clusterOptions = markerClusterOptions()
)%>% addPolygons(data = Moz_a2,
                 fillColor = ~pal(mean_pop),
                 weight = 2,
                 opacity = 1,
                 color = "white",
                 dashArray = "3",
                 fillOpacity = 0.7,
                 highlight = highlightOptions(
                   weight = 5,
                   color = "#666",
                   dashArray = "",
                   fillOpacity = 0.7,
                   bringToFront = TRUE),
                 label = labels,
                 labelOptions = labelOptions(
                   style = list("font-weight" = "normal", padding = "3px 8px"),
                   textsize = "15px",
                   direction = "auto")) %>%
  addLegend(pal = pal, values = ~density, opacity = 0.7, title = NULL,
            position = "bottomright")

############### add pfpr layers ###############################
