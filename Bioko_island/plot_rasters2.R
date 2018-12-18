cuts=c(0,1,10,100,1000,10000,100000)
pal <- colorRampPalette(c("grey","khaki1", "yellow","orange", "red", "maroon"))

par(mfrow = c(2,2))
plot(landscan, xlim = c(8.4, 9), ylim = c(3,4), main = "LandScan for Bioko", breaks= cuts, col=c("grey", brewer.pal(n = 6, name = "YlOrRd")), legend = F)
legend(x = "bottomright",inset = 0,
       legend = c("0","1","10","100","1000","10000","100000"), 
       col=c("grey", brewer.pal(n = 6, name = "YlOrRd")), lwd=5, cex=.5, horiz = F)
plot(world_pop_2010, xlim = c(8.4, 9), ylim = c(3,4), main = "WorldPOP_2010(100m) for Bioko", breaks= cuts, col=c("grey", brewer.pal(n = 6, name = "YlOrRd")), legend = F)
legend(x = "bottomright",inset = 0,
       legend = c("0","1","10","100","1000","10000","100000"), 
       col=c("grey", brewer.pal(n = 6, name = "YlOrRd")), lwd=5, cex=.5, horiz = F)
plot(world_pop, xlim = c(8.4, 9), ylim = c(3.2,3.8), main = "WorldPOP(1km) for Bioko", breaks= cuts, col=c("grey", brewer.pal(n = 6, name = "YlOrRd")), legend = F)
legend(x = "bottomright",inset = 0, y = 3.5,
       legend = c("0","1","10","100","1000","10000","100000"), 
       col=c("grey", brewer.pal(n = 6, name = "YlOrRd")), lwd=5, cex=.5, horiz = F)

ggplot(data=worldpop2010_df) + 
  geom_tile(aes(x=x,y=y,fill=population)) + 
  viridis_pal()(9)(discrete = T) +
  coord_equal() +
  theme_bw() +
  theme(panel.grid.major = element_blank()) +
  xlab("Longitude") + ylab("Latitude") +
  ggtitle("WorldPOP (100m) for Bioko")

