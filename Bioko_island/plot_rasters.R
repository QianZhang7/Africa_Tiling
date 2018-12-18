
landscan_points = rasterToPoints(landscan)
landscan_df = data.frame(landscan_points)
head(landscan_df) #breaks will be set to column "layer"
landscan_df$population=cut(landscan_df$dblbnd,breaks=c(-Inf,0,1,10,100,1000,10000,100000)) #set breaks

ggplot(data=landscan_df) + 
  geom_tile(aes(x=x,y=y,fill=population)) + 
  scale_fill_viridis(discrete = T) +
  coord_equal() +
  theme_bw() +
  theme(panel.grid.major = element_blank()) +
  xlab("Longitude") + ylab("Latitude") +
  ggtitle("LandScan for Bioko")

worldpop2010_points = rasterToPoints(world_pop_2010)
worldpop2010_df = data.frame(worldpop2010_points)
head(worldpop2010_df) #breaks will be set to column "layer"
worldpop2010_df$population=cut(worldpop2010_df$GNQ15v2,breaks=c(-Inf,0,1,10,100,1000,10000,100000)) #set breaks

ggplot(data=worldpop2010_df) + 
  geom_tile(aes(x=x,y=y,fill=population)) + 
  viridis_pal()(9)(discrete = T) +
  coord_equal() +
  theme_bw() +
  theme(panel.grid.major = element_blank()) +
  xlab("Longitude") + ylab("Latitude") +
  ggtitle("WorldPOP (100m) for Bioko")
