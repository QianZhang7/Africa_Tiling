cuts=c(0,1,10,100,1000,10000)
pal <- colorRampPalette(c("grey","khaki1", "yellow","orange", "red", "maroon"))

par(mfrow = c(2,2))
plot(landscan, xlim = c(8.4, 9), ylim = c(3,4), main = "LandScan(1km) for Bioko", breaks= cuts, col=c("grey", brewer.pal(n = 6, name = "YlOrRd")), legend = F)
legend(x = "bottomright",inset = 0,
       legend = c("0","1","10","100","1000","10000","100000"), 
       col=c("grey", brewer.pal(n = 6, name = "YlOrRd")), lwd=5, cex=.5, horiz = F)
plot(world_pop, xlim = c(8.4, 9), ylim = c(3.2,3.8), main = "WorldPOP(1km) for Bioko", breaks= cuts, col=c("grey", brewer.pal(n = 6, name = "YlOrRd")), legend = F)
legend(x = "bottomright",inset = 0, y = 3.5,
       legend = c("0","1","10","100","1000","10000","100000"), 
       col=c("grey", brewer.pal(n = 6, name = "YlOrRd")), lwd=5, cex=.5, horiz = F)
plot(world_pop_2010, xlim = c(8.4, 9), ylim = c(3,4), main = "WorldPOP_2010(100m) for Bioko", breaks= cuts, col=c("grey", brewer.pal(n = 6, name = "YlOrRd")), legend = F)
legend(x = "bottomright",inset = 0,
       legend = c("0","1","10","100","1000","10000","100000"), 
       col=c("grey", brewer.pal(n = 6, name = "YlOrRd")), lwd=5, cex=.5, horiz = F)
plot(shp_15, xlim = c(8.4, 9), ylim = c(3.2,3.8), main = "MCDI(100m) for Bioko", breaks= cuts, col=c("grey", brewer.pal(n = 6, name = "YlOrRd")), legend = F)
legend(x = "bottomright",inset = 0, y = 3.5,
       legend = c("0","1","10","100","1000","10000","100000"),
       col=c("grey", brewer.pal(n = 6, name = "YlOrRd")), lwd=5, cex=.5, horiz = F)


