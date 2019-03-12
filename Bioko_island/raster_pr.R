library(raster)
library(rasterVis)
mcdi_pr <- raster("project/Tiling/denominators/mcdi_Prevalence_mean.tif")
landscan_pr <- raster("project/Tiling/denominators/ls_Prevalence_mean.tif")
worldpop_pr <- raster("project/Tiling/denominators/wp_Prevalence_mean.tif")

library(gridExtra)

p1 <- levelplot(mcdi_pr, main = "MCDI")
p2 <- levelplot(landscan_pr, main = "Landscan")
p3 <- levelplot(worldpop_pr, main = "WorldPOP")


h1 = histogram(mcdi_pr, main = 'MCDI', ylim = c(0,4))
h2 = histogram(landscan_pr, main = "Landscan", ylim = c(0,4))
h3 = histogram(worldpop_pr, main = "Worldpop", ylim = c(0,4))
grid.arrange(h1, h2,h3, ncol=3)

stack_pr = stack(mcdi_pr,landscan_pr,worldpop_pr)
names(stack_pr) <- c('MCDI_Prevalence', 'Landscan_Prevalence', 'WorldPOP_Prevalence')
densityplot(stack_pr)
bwplot(stack_pr)


library(ggplot2)
mcdi_df <- data.frame(MCDI_Prevalence = values(mcdi_pr))
landscan_df <- data.frame(Landscan_Prevalence = values(landscan_pr))
worldpop_df <- data.frame(WorldPOP_Prevalence = values(worldpop_pr))

par(mfrow = c(1,3))
g1 <- ggplot(mcdi_df, aes(x = MCDI_Prevalence)) + 
  geom_histogram(aes(y = ..density..), binwidth = 0.005, colour = 'sky blue', fill = 'sky blue') + 
  geom_density(colour = 'blue') + ylim(c(0,20))
g2 <- ggplot(landscan_df, aes(x = Landscan_Prevalence)) + 
  geom_histogram(aes(y = ..density..), binwidth = 0.005, colour = 'light green', fill = 'light green') + 
  geom_density(colour = 'dark green')+ ylim(c(0,20))
g3 <- ggplot(worldpop_df, aes(x = WorldPOP_Prevalence)) + 
  geom_histogram(aes(y = ..density..), binwidth = 0.005, colour = 'orange', fill = 'orange') + 
  geom_density(colour = 'red')+ ylim(c(0,20))
grid.arrange(g1, g2,g3, ncol=3)


mcdi_pr[is.na(mcdi_pr)] <- 0
mapTheme <- rasterTheme(region=c(brewer.pal(8,"YlOrRd")))
mapTheme$panel.background$col = 'gray50' 
levelplot(mcdi_pr, main = "MCDI", at = c(seq(0.0001,0.5, 0.01)), par.settings=mapTheme )
