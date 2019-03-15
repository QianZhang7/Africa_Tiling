
density_by_population = function(H, color, title){
  H_value = values(H)
  H_value <- H_value[!is.na(H_value)]
  log_H_value <- log(H_value, 10)
  value_list <- c()
  for (i in 1:length(H_value)){
    value_list <- c(value_list, rep(log_H_value[i],H_value[i]))
  }
  return(density(value_list))
}

par(mfrow = c(2,2))

plot(density_by_population(world_100_2010), type ="l", col = "red", main = "Pdf for 100m grids", xlab = 'population counts',  xaxt='n', xlim = c(0,4), ylim= c(0,9))
lines(density_by_population(raster_mcdi_100), col = 'orange')
ticks <- seq(0, 4, by=1)
labels <- sapply(ticks, function(i) as.expression(bquote(10^ .(i))))
axis(1, at=c(0, 1,2,3,4), labels=labels)
legend(3,8,c("WorldPOP:100m", "mcdi:100m"), col = c("red", "orange"), lty = 1, cex = 0.6)

plot(density_by_population(world_200_2010), type ="l", col = "red", main = "Pdf for 200m grids(aggregated)", xlab = 'population counts',  xaxt='n', xlim = c(0,4), ylim= c(0,9))
lines(density_by_population(mcdi_200_2010), col = 'orange')
ticks <- seq(0, 4, by=1)
labels <- sapply(ticks, function(i) as.expression(bquote(10^ .(i))))
axis(1, at=c(0, 1,2,3,4), labels=labels)
legend(3,8,c("WorldPOP:200m", "mcdi:200m"), col = c("red", "orange"), lty = 1, cex = 0.6)


plot(density_by_population(world_500_2010), type ="l", col = "red", main = "Pdf for 500m grids(aggregated)", xlab = 'population counts',  xaxt='n', xlim = c(0,4), ylim= c(0,9))
lines(density_by_population(mcdi_500_2010), col = 'orange')
ticks <- seq(0, 4, by=1)
labels <- sapply(ticks, function(i) as.expression(bquote(10^ .(i))))
axis(1, at=c(0, 1,2,3,4), labels=labels)
legend(3,8,c("WorldPOP:500m", "mcdi:500m"), col = c("red", "orange"), lty = 1, cex = 0.6)

plot(density_by_population(world_1k_2010), type ="l", col = "red", main = "Pdf for 1km grids", xlab = 'population counts',  xaxt='n', xlim = c(0,5), ylim= c(0,9))
lines(density_by_population(raster_mcdi_1k), col = 'orange')
ticks <- seq(0, 5, by=1)
labels <- sapply(ticks, function(i) as.expression(bquote(10^ .(i))))
axis(1, at=c(0, 1,2,3,4,5), labels=labels)
legend(3.8,8,c("WorldPOP:1km", "mcdi:1km"), col = c("red", "orange"), lty = 1, cex = 0.6)

